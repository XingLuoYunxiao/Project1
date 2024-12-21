import { CommentData } from "../model/BasicDataSource";
import { Comment } from "../model/Comment";
import { FriendMoment } from "../model/FriendMoment";
import { FriendMomentAdd } from "../model/FriendMomentAdd";
import { queryCollection, queryComment, shareData, Sharedata, updateGood } from "../model/sharedata";
import { taskpool } from "@kit.ArkTS";
import { Spot } from "travel";

export class ShareViewModel{
  private static instance: ShareViewModel = new ShareViewModel();

  private constructor() {
    // 私有构造函数防止外部实例化
  }
  public static getInstance(): ShareViewModel {
    return ShareViewModel.instance;
  }
  shareList: CommentData<FriendMomentAdd> = new CommentData(); // 朋友圈列表
  commentList: CommentData<Comment> = new CommentData(); // 评论列表
  sharedata: Sharedata = Sharedata.getInstance()
  count:number=0
  none:number=0
  pageNum: number = 1;

  reset(){
    this.pageNum=1
    this.none=0
    this.shareList.notifyDataDeleteAll()
  }

  async shareDeal(){
    let task: taskpool.Task = new taskpool.Task(shareData,this.pageNum);
    const value=await taskpool.execute(task) as FriendMoment[]
    this.pageNum++
    const result: Array<FriendMomentAdd> = [];
    for (let index = 0; index < value.length; index++) {
      //遍历的每一项
      const cur=value[index]
      const img=await this.sharedata.getUrl(cur.image)
      result.push(new FriendMomentAdd(cur.id,cur.userId,cur.text,img,cur.good,cur.location,cur.userPhoto,cur.userName))
    }
    if(result.length<5){
      this.none=1
    }
    this.shareList.appendArrayData(result)
  }

  //评论查询
  async commentDeal(momentid:string){
    let task:taskpool.Task=new taskpool.Task(queryComment,momentid)
    let value:Array<Comment>= await taskpool.execute(task) as Array<Comment>
    this.commentList.notifyDataDeleteAll()
    for (let index = 0; index < value.length; index++) {
      //每条评论
      const cur=value[index]
      this.commentList.pushData(cur)
    }
    this.count=this.commentList.totalCount()
  }

  async shareAdd(data:FriendMoment,photo:string,name:string,seletimg:string){
    this.sharedata.addshareData(data)
      // .then(async ()=>{
          // this.shareList.addDataFirst(new FriendMomentAdd(data.id,data.userId,data.text,seletimg,data.good,data.location,photo,name))
      //   this.shareList.notifyDataReload()
      // })
  }

  async commentAdd(data:Comment){
    this.sharedata.addcommentData(data)
      .then(async ()=>{

      })
  }

  async updateGood(momentid:string,good:number){
    try {
      //创建任务
      let task: taskpool.Task = new taskpool.Task(updateGood, momentid,good);
      await taskpool.execute(task);
    } catch (err) {
      console.error('点赞失败', 'query error:' + `${err}`);
    }
  }

  async upload(uid:string,time:string): Promise<string>{
    const res=await this.sharedata.upload(uid,time)
    return res.photoUris[0]
  }

  //使用taskPool执行查询任务（收藏查询）
  async taskPoolExecuteQuery(condition:string): Promise<Array<Spot>> {
    try {
      //创建任务
      let task: taskpool.Task = new taskpool.Task(queryCollection, condition); // query函数调用 需使用装饰器@Concurrent
      let result: Array<Spot> = await taskpool.execute(task) as Array<Spot>;
      return result;
    } catch (err) {
      console.error('taskPoolQuery', 'query error:' + `${err}`);
      return [];
    }
  }

}
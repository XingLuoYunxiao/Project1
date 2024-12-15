import { CommentData } from "../model/BasicDataSource";
import { Comment } from "../model/Comment";
import { FriendMoment } from "../model/FriendMoment";
import { FriendMomentAdd } from "../model/FriendMomentAdd";
import { queryCollection, queryComment, shareData, Sharedata } from "../model/sharedata";
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

  async shareDeal(){
    let task: taskpool.Task = new taskpool.Task(shareData);
    const value=await taskpool.execute(task) as FriendMoment[]
    this.shareList.notifyDataDeleteAll()
    for (let index = 0; index < value.length; index++) {
      //遍历的每一项
      const cur=value[index]
      const img=await this.sharedata.getUrl(cur.image)
      this.shareList.pushData(new FriendMomentAdd(cur.id,cur.userId,cur.text,img,cur.good,cur.location,cur.userPhoto,cur.userName))
    }
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

  async shareAdd(data:FriendMoment,photo:string,name:string){
    this.sharedata.addshareData(data)
      .then(async ()=>{
          this.shareList.pushData(new FriendMomentAdd(data.id,data.userId,data.text,data.image,data.good,data.location,photo,name))
      })
  }

  async commentAdd(data:Comment){
    this.sharedata.addcommentData(data)
      .then(async ()=>{

      })
  }

  // async shareUpdate(data:Comment){
  //   this.sharedata.updateshareData(data)
  //     .then(async ()=>{
  //       //修改成功
  //     })
  // }

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
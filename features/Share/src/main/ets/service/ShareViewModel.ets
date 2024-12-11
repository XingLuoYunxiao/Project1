import { CommentData } from "../model/BasicDataSource";
import { Comment } from "../model/Comment";
import { FriendMoment } from "../model/FriendMoment";
import { FriendMomentAdd } from "../model/FriendMomentAdd";
import { Sharedata } from "../model/sharedata";

export class ShareViewModel{
  private static instance: ShareViewModel = new ShareViewModel();

  private constructor() {
    // 私有构造函数防止外部实例化
  }
  public static getInstance(): ShareViewModel {
    return ShareViewModel.instance;
  }
  shareList: CommentData<FriendMomentAdd> = new CommentData(); // 评论列表
  sharedata: Sharedata = Sharedata.getInstance()

  async shareDeal(){
    this.sharedata.shareData()
      .then(async (value: FriendMoment[])=>{
        this.shareList.notifyDataDeleteAll()
        for (let index = 0; index < value.length; index++) {
          //遍历的每一项
          const cur=value[index]
          this.shareList.pushData(new FriendMomentAdd(cur.id,cur.userId,cur.text,cur.image,cur.good,cur.location,cur.userPhoto,cur.userName))
        }
      })
  }

  async commentDeal(momentid:number){
    this.sharedata.commentData(momentid)
      .then(async (value: Comment[])=>{
        this.shareList.notifyDataDeleteAll()
        for (let index = 0; index < value.length; index++) {
          //每条评论
          const cur=value[index]

        }
      })
  }

  async shareAdd(data:FriendMoment){
    this.sharedata.addshareData(data)
      .then(async ()=>{
        //TODO 换成用户名和头像
          this.shareList.pushData(new FriendMomentAdd(data.id,data.userId,data.text,data.image,data.good,data.location,'app.media.Zoologist','用户名'))
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
}
import { LazyDataSource, LoadingStatus } from "utils"
import { spotComment } from "../model/spotComment"
import { promptAction } from "@kit.ArkUI"
import { taskpool as taskPool } from '@kit.ArkTS'
import { addCommentData, getUserData, loadCommentsData, User } from "../model/CommentModel"
import { cloudStorage } from "@kit.CloudFoundationKit"
import { BusinessError } from "@kit.BasicServicesKit"

let bucket: cloudStorage.StorageBucket = cloudStorage.bucket(); // 将启动异步任务查询云侧默认实例


@Observed
export class CommentService{
  private static instance: CommentService = new CommentService()
  //所有评论
  comments: spotComment[] = []
  commentsSource: LazyDataSource<spotComment> = new LazyDataSource<spotComment>()

  //顶级评论
  topComments: spotComment[] = []
  topCommentsSource: LazyDataSource<spotComment> = new LazyDataSource<spotComment>()

  //加载状态
  commentsLoadingState: LoadingStatus = LoadingStatus.OFF

  pageNum: number = 1

  private constructor(){}

  public static getInstance(): CommentService{
    if( !CommentService.instance){
      CommentService.instance = new CommentService()
    }
    return CommentService.instance
  }

  async taskPoolExecuteCommentQuery(spotId: number, pageNum: number){
    try{
      let task: taskPool.Task = new taskPool.Task(loadCommentsData, spotId, pageNum)
      let result: Array<spotComment> = await taskPool.execute(task) as spotComment[]
      return result;
    }catch (err){
      console.error('taskPoolExecuteCommentQuery error:', err)
      return []
    }
  }

  async loadMoreComments(spotId: number): Promise<void> {
    try {
      /* const moreComments = await this.spotNetWork.getSpotComments(
         this.spotId,
         this.pageIndex,
         this.pageSize
       )*/
      const newComments = await this.taskPoolExecuteCommentQuery(spotId, this.pageNum++)
      if(newComments.length){
        this.commentsLoadingState = LoadingStatus.SUCCESS
      }
      // 筛选当前景点的顶级评论
      if (this.pageNum === 1) {
        this.comments = []
        this.comments.push(...newComments)
        this.commentsSource.pushArrayData(this.comments)
      }else{
        this.comments.push(...newComments)
        this.commentsSource.appendArrayData(newComments)
      }
      const spotComments = this.comments.filter(comment =>
      comment.spotId === spotId && comment.parentId === -1
      )
      this.topComments = spotComments
      this.topCommentsSource.pushArrayData(this.topComments)
      //this.commentList = this.commentList.concat(this.comments)
    } catch (error) {
      promptAction.showToast({ message: '加载更多评论失败', duration: 2000 })
    }
  }


  // 获取某个顶级评论的回复列表
  getReplies(topCommentId: number, spotId: number): spotComment[] {
    return this.comments.filter(comment =>
    comment.spotId === spotId && comment.parentId === topCommentId
    )
  }

  // 添加评论
  async taskPoolExecuteCommentAdd(comment: spotComment): Promise<void> {
    try{
      let task: taskPool.Task = new taskPool.Task(addCommentData, comment)
      await taskPool.execute(task)
    }catch (e){
      promptAction.showToast({ message: '发送评论失败', duration: 2000 })
    }
  }

  // 发送评论的方法
  async postComment(commentInput: string, spotId:number, userId:string, parentId: number): Promise<void> {
    if (!commentInput.trim()) {
      promptAction.showToast({ message: '评论内容不能为空', duration: 2000 })
      return
    }

    try {
      const newComment: spotComment = new spotComment()
      newComment.userId = userId
      newComment.spotId = spotId
      newComment.content = commentInput
      newComment.replyTime = new Date()
      newComment.parentId = parentId

      this.comments.push(newComment)
      this.commentsSource.appendArrayData([newComment])
      if(parentId === -1){
        this.topComments.push(newComment)
        this.topCommentsSource.appendArrayData([newComment])
      }

      this.taskPoolExecuteCommentAdd(newComment)
    } catch (error) {
      promptAction.showToast({ message: '发送评论失败', duration: 2000 })
    }
  }

  //在云存储获取头像
  async getUserUrl(img:string): Promise<string>{
    return await this.getCloudUserUrl(img)
  }

  getCloudUserUrl(img:string):Promise<string> {
    return new Promise((resolve,reject)=>{
      bucket.getDownloadURL(`share/comment/${img}.png`).then((downloadURL: string) => {
        resolve(downloadURL)
        console.info(`getDownloadURL: ${downloadURL}`);
      }).catch((err: BusinessError) => {
        resolve('')
        console.error(`getDownloadURL failed, Code: ${err.code}, message: ${err.message}`);
      });
    })
  }

  //获取用户信息
  async getUserinfo(userid:string):Promise<User>{
    return new Promise((resolve,reject)=>{
      getUserData(userid).then(
        ((value:User[])=>{
          resolve(value[0]) ;
        })
      );
    })
  }


  //重置
  reset(){
    this.comments = []
    this.commentsSource.clear()
    this.topComments = []
    this.topCommentsSource.clear()
    this.commentsLoadingState = LoadingStatus.OFF
    this.pageNum = 1
  }


}
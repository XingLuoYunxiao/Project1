import { LazyDataSource, LoadingStatus } from "utils"
import { spotComment } from "../model/spotComment"
import { promptAction } from "@kit.ArkUI"

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

  private constructor(){}

  public static getInstance(): CommentService{
    if( !CommentService.instance){
      CommentService.instance = new CommentService()
    }
    return CommentService.instance
  }

  async loadMoreComments(spotId: number): Promise<void> {
    try {
      /* const moreComments = await this.spotNetWork.getSpotComments(
         this.spotId,
         this.pageIndex,
         this.pageSize
       )*/
      // 模拟数据
      const comment1: spotComment = new spotComment()
      comment1.id = 1
      comment1.userId = 1
      comment1.spotId = spotId
      comment1.content = '这是一个很美的景点！'
      comment1.replyTime = new Date()
      comment1.parentId = -1

      const comment2: spotComment = new spotComment()
      comment2.id = 2
      comment2.userId = 2
      comment2.spotId = spotId
      comment2.content = '风景确实很棒！'
      comment2.replyTime = new Date()
      comment2.parentId = -1

      const comment3: spotComment = new spotComment()
      comment3.id = 3
      comment3.userId = 3
      comment3.spotId = spotId
      comment3.content = '我完全同意！'
      comment3.replyTime = new Date()
      comment3.parentId = 1 // 回复comment1

      const comment4: spotComment = new spotComment()
      comment4.id = 4
      comment4.userId = 4
      comment4.spotId = spotId
      comment4.content = '更多细节分享一下？'
      comment4.replyTime = new Date()
      comment4.parentId = 1 // 回复comment1

      const comment5: spotComment = new spotComment()
      comment5.id = 5
      comment5.userId = 5
      comment5.spotId = spotId
      comment5.content = '非常感谢分享！'
      comment5.replyTime = new Date()
      comment5.parentId = 2 // 回复comment2

      // 另一个景点的评论（不会显示）
      const comment6: spotComment = new spotComment()
      comment6.id = 6
      comment6.userId = 6
      comment6.spotId = 999 // 不同的景点ID
      comment6.content = '这是另一个景点的评论'
      comment6.replyTime = new Date()
      comment6.parentId = -1

      // 筛选当前景点的顶级评论
      if (this.comments.length === 0) {
        this.comments = [comment1, comment2, comment3, comment4, comment5, comment6]
        this.commentsSource.pushArrayData(this.comments)
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


}
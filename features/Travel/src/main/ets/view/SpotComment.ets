import { spotComment } from "../model/spotComment"
import { promptAction, Router } from "@kit.ArkUI"
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule"
import { Spot } from "../model/Spot"

@Component
export struct SpotComment {
  @Prop spot: Spot
  @State userName: string | undefined = '用户'
  @State userId: number = 1
  @State commentList: spotComment[] = []
  @State totalCommentCount: number = 0
  @State currentUserAvatar: Resource = $r('app.media.avator')
  @State currentUserId: string = 'user123'
  @State commentInput: string = ''
  @State comments: spotComment[] = []
  @State selectedTopComment: spotComment | null = null

  // 初始化评论数据
  async aboutToAppear(): Promise<void> {
    await this.loadComments()
  }

  // 加载评论的方法
  async loadComments(): Promise<void> {
    try {
      // 模拟数据
      const comment1: spotComment = new spotComment()
      comment1.id = 1
      comment1.userId = 1
      comment1.spotId = this.spot.id
      comment1.content = '这是一个很美的景点！'
      comment1.replyTime = new Date()
      comment1.parentId = -1

      const comment2: spotComment = new spotComment()
      comment2.id = 2
      comment2.userId = 2
      comment2.spotId = this.spot.id
      comment2.content = '风景确实很棒！'
      comment2.replyTime = new Date()
      comment2.parentId = -1

      const comment3: spotComment = new spotComment()
      comment3.id = 3
      comment3.userId = 3
      comment3.spotId = this.spot.id
      comment3.content = '我完全同意！'
      comment3.replyTime = new Date()
      comment3.parentId = 1 // 回复comment1

      const comment4: spotComment = new spotComment()
      comment4.id = 4
      comment4.userId = 4
      comment4.spotId = this.spot.id
      comment4.content = '更多细节分享一下？'
      comment4.replyTime = new Date()
      comment4.parentId = 1 // 回复comment1

      const comment5: spotComment = new spotComment()
      comment5.id = 5
      comment5.userId = 5
      comment5.spotId = this.spot.id
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

      if(this.comments.length === 0){
        this.comments = [comment1, comment2, comment3, comment4, comment5, comment6]
      }

      // 筛选当前景点的顶级评论
      const spotComments = this.comments.filter(comment =>
      comment.spotId === this.spot.id && comment.parentId === -1
      )
      this.commentList = spotComments.slice(0, 3)
      this.totalCommentCount = spotComments.length
    } catch (error) {
      console.error('加载评论失败', error)
      promptAction.showToast({ message: '加载评论失败', duration: 2000 })
    }
  }

  // 获取某个顶级评论的回复列表
  getReplies(topCommentId: number): spotComment[] {
    return this.comments.filter(comment =>
    comment.spotId === this.spot.id && comment.parentId === topCommentId
    )
  }

  // 发送评论的方法
  async postComment(): Promise<void> {
    if (!this.commentInput.trim()) {
      promptAction.showToast({ message: '评论内容不能为空', duration: 2000 })
      return
    }

    try {
      const newComment: spotComment = new spotComment()
      newComment.userId = this.userId
      newComment.spotId = this.spot.id
      newComment.content = this.commentInput
      newComment.replyTime = new Date()
      newComment.parentId = -1

      this.commentInput = ''
      this.comments.push(newComment)
      this.commentList.push(newComment)
      await this.loadComments()
    } catch (error) {
      promptAction.showToast({ message: '发送评论失败', duration: 2000 })
    }
  }


  build() {
    Column() {
      // 评论标题
      Row() {
        Text('用户点评')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text(`共 ${this.totalCommentCount} 条评论`)
          .fontSize(14)
          .fontColor(Color.Gray)
      }
      .width('100%')
      .padding(16)

      // 评论列表
      ForEach(this.commentList, (comment: spotComment) => {
        Column() {

          Column(){
            Row() {
              Image(this.currentUserAvatar)
                .width(40)
                .height(40)
                .borderRadius(20)
                .margin({ right: 10 })
              Column() {
                Row() {
                  Text(this.userName?.toString() || '')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                }

                Text(comment.replyTime?.toLocaleString() || '')
                  .fontSize(12)
                  .fontColor(Color.Gray)
              }
            }
            .justifyContent(FlexAlign.Start)
            .width('100%')
            Row(){
              Text(comment.content || '')
                .fontWeight(500)
                .fontSize(16)
                .margin({ top: 8 })
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
            .margin({ left: 40 })
          }


        }
        .width('100%')
        .padding(10)
        .margin({ bottom: 8 })
        .backgroundColor('#F5F6F7')
        .borderRadius(12)
      })

      // 查看全部评论按钮
      Text('查看全部评论')
        .width('100%')
        .textAlign(TextAlign.Center)
        .fontColor(Color.Gray)
        .margin({ top: 16, bottom: 16 })
        .onClick(() => {
          buildRouterModel(
            RouterNameConstants.ENTRY_HAP,
            BuilderNameConstants.TRAVEL_SPOTDETAILCOMMENT,
            new Object({ spot: this.spot })
          )
        })

      // 评论输入区域
      Row() {
        TextInput({ placeholder: '说点什么...', text: this.commentInput })
          .layoutWeight(1)
          .margin({ right: 10 })
          .onChange((value: string) => {
            this.commentInput = value
          })

        Button('发送')
          .onClick(() => this.postComment())
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F6F7')
    }

    .margin({ top: 8 })
    .backgroundColor(Color.White)
  }
}
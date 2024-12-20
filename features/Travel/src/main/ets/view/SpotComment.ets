import { spotComment } from "../model/spotComment"
import { promptAction, Router } from "@kit.ArkUI"
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule"
import { Spot } from "../model/Spot"
import { CommentService } from "../service/CommentService"
import { formatTime } from "../pages/SpotDetailComment"

@Component
export struct SpotComment {
  @Prop spot: Spot
  @State commentService: CommentService = CommentService.getInstance()
  @State userName: string | undefined = '用户'
  @StorageLink('personUid') userId: string = '';
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
      if( this.spot && this.spot.id){
        await this.commentService.loadMoreComments(this.spot.id)
      }
      // 筛选当前景点的顶级评论
      this.commentList = this.commentService.topComments.slice(0, 3)
      this.totalCommentCount = this.commentService.topComments.length
    } catch (error) {
      console.error('加载评论失败', error)
      promptAction.showToast({ message: '加载评论失败', duration: 2000 })
    }
  }

  aboutToDisappear(): void {
    this.commentService.reset()
  }


  // 发送评论的方法
  async postComment(parentId: number): Promise<void> {
    if(this.spot && this.spot.id){
      if(parentId === -1){
        this.commentService.postComment(this.commentInput, this.spot.id, this.userId, -1)
        this.commentList = this.commentService.topComments.slice(0, 3)
        this.totalCommentCount = this.commentService.topComments.length
        this.commentService.reset()
      }else{
        this.commentService.postComment(this.commentInput, this.spot.id, this.userId, parentId)

      }
      this.commentInput = ''
    }else{
      promptAction.showToast({ message: '评论失败[景点未定义]', duration: 2000 })
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

                Text(comment.replyTime ? formatTime(comment.replyTime?.toString()) : '')
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

        Image($r('app.media.ic_send'))
          .fillColor(Color.Gray)
          .width(24)
          .height(24)
          .onClick(() => this.postComment(-1))
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F6F7')
    }

    .margin({ top: 8 })
    .backgroundColor(Color.White)
  }
}
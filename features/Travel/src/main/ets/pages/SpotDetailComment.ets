import { BuilderNameConstants, RouterModule } from "routermodule"
import { spotComment } from "../model/spotComment"
import { promptAction } from "@kit.ArkUI"
import { Spot } from "../model/Spot"
import { CommentService } from "../service/CommentService"

@Component
struct SpotDetailComment {
  @Consume('appPathStack') appPathStack: NavPathStack
  @State commentService: CommentService = CommentService.getInstance()
  @State spot: Spot = new Spot()
  @State value: object = new Object()
  @State comments: spotComment[] = []
  @State currentUserAvatar: Resource = $r('app.media.avator')
  @State selectedTopComment: spotComment | null = null
  @State userName: string | undefined = '用户'
  @State isShowDialog: Array<boolean> = []

  aboutToAppear(): void {
    //this.spot.id = this.appPathStack.getParamByName('spotId')[0]
    this.spot = JSON.parse(JSON.stringify(this.value)).spot as Spot

    if( this.spot && this.spot.id){
      this.commentService.loadMoreComments(this.spot.id).then(() => {
        this.comments = this.commentService.comments
        this.isShowDialog = new Array<boolean>(this.commentService.topComments.length).fill(false);
      })
    }

  }


  // 获取某个顶级评论的回复列表
  getReplies(topCommentId: number): spotComment[] {
    return this.comments.filter(comment =>
    comment.spotId === this.spot.id && comment.parentId === topCommentId
    )
  }

  build() {
    NavDestination() {
      Column() {
        // 返回按钮
        Row() {
          Image($r('app.media.ic_back'))
            .width(40)
            .height(40)
            .onClick(() => this.appPathStack.pop())
          Text('全部评论')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ left: 12 })
        }
        .width('100%')
        .padding(16)

        // 评论列表
        List() {
          LazyForEach(this.commentService.topCommentsSource, (comment: spotComment, index: number) => {
            ListItem() {
              Column() {
                Column() {
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

                  Row() {
                    Text(comment.content || '')
                      .fontWeight(500)
                      .fontSize(16)
                      .margin({ top: 8 })
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.Start)
                  .margin({ left: 40 })
                }

                Row() {
                  Blank()
                  Text('回复')
                    .fontSize(14)
                    .fontColor(Color.Gray)
                    .margin({right: 10})
                  if (this.commentService.getReplies(comment.id!, this.spot.id!).length > 0) {
                    Badge({
                      count: this.commentService.getReplies(comment.id!, this.spot.id!).length,
                      style: { fontSize: 10, badgeColor: Color.Gray, borderColor: Color.Gray }
                    }) {
                      Image($r('app.media.ic_reply'))
                        .width(30)
                        .height(30)
                        .onClick(() => {
                          this.selectedTopComment = comment
                          this.isShowDialog[index] = true
                        })
                        .bindSheet(this.isShowDialog[index], this.replyDialogBuilder(), {
                          detents: [600, SheetSize.LARGE],
                          backgroundColor: '#ffe7e7e7',
                          blurStyle: BlurStyle.Thick,
                          showClose: false,
                          enableOutsideInteractive: true,
                          dragBar: true,
                          preferType: SheetType.BOTTOM,
                          onDisappear: () => {
                            this.isShowDialog[index] = false;
                          }
                        })
                    }
                    .margin({ right: 8 })
                  }
                }
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)
                .height(40)
                .width('100%')
                .margin({ top: 8 })

              }
              .width('100%')
              .padding(10)
              .margin({ bottom: 8 })
              .backgroundColor('#F5F6F7')
              .borderRadius(12)
            }
          }, (item: spotComment, index: number) => item.id + 'comment' + index)

        }
      }
    }
    .margin({ top: $r('app.float.header_height_page')})
    .hideTitleBar(true)
  }

  // 显示回复弹窗
  @Builder
  replyDialogBuilder() {
    Column() {
      Text(`${this.selectedTopComment?.id}的回复`)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      if (this.selectedTopComment) {
        List() {
          ForEach(this.commentService.getReplies(this.selectedTopComment.id!, this.spot.id!), (reply: spotComment) => {
            ListItem() {
              Column() {
                Row() {
                  Image(this.currentUserAvatar)
                    .width(40)
                    .height(40)
                    .borderRadius(20)
                    .margin({ right: 8 })
                  Column() {
                    Row() {
                      Text(reply.userId?.toString() || '')
                        .fontSize(16)
                        .fontWeight(FontWeight.Medium)
                    }

                    Text(reply.replyTime?.toLocaleString() || '')
                      .fontSize(12)
                      .fontColor(Color.Gray)
                  }
                }
                .justifyContent(FlexAlign.Start)
                .width('100%')

                Row() {
                  Text(reply.content || '')
                    .fontSize(16)
                    .fontWeight(500)
                    .margin({ top: 8 })
                }
                .justifyContent(FlexAlign.Start)
                .width('100%')
                .margin({ left: 30 })

              }
              .width('100%')
              .padding(10)
              .margin({ bottom: 8 })
              .backgroundColor('#F5F6F7')
              .borderRadius(12)
            }
          })
        }
        .height(300)
        .width('100%')
      }
    }
    .padding(16)
  }
}

@Builder
export function SpotDetailCommentPageBuilder(value: Object) {
  SpotDetailComment({ value: value })
}

// 注册路由
const builderName = BuilderNameConstants.TRAVEL_SPOTDETAILCOMMENT
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(SpotDetailCommentPageBuilder);
  RouterModule.registerBuilder(builderName, builder)
}
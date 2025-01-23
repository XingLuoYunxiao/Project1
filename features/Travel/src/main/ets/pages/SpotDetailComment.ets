import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule"
import { spotComment } from "../model/spotComment"
import { promptAction } from "@kit.ArkUI"
import { Spot } from "../model/Spot"
import { CommentService } from "../service/CommentService"
import { BreakpointConstants, LoadingStatus } from "utils"
import { User } from "../model/CommentModel"

// 时间格式化方法
export function formatTime(timeStr: string): string {
  try {
    const date = new Date(timeStr);
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    const hours = date.getHours().toString().padStart(2, '0');
    const minutes = date.getMinutes().toString().padStart(2, '0');
    return `${year}/${month}/${day} ${hours}:${minutes}`;
  } catch (error) {
    return timeStr;
  }
}

@Component
export struct SpotDetailComment {
  @Consume('appPathStack') appPathStack: NavPathStack
  @State commentService: CommentService = CommentService.getInstance()
  @StorageLink('personUid') userId: string = '';
  @StorageLink('personName') userName: string = ''
  @StorageLink('personPhoto') personPhoto: string = ''
  @State spot: Spot | undefined = undefined
  @State value: object = new Object()
  @State comments: spotComment[] = []
  @State currentUserAvatar: Resource = $r('app.media.avator')
  @State selectedTopComment: spotComment | null = null
  @State commentInput: string = ''
  @State isReplySheetShow: boolean = false

  // 新增：用于存储用户信息和照片URL的映射
  @StorageLink('userInfoMap') userInfoMap: Map<string, User> = new Map()
  @StorageLink('userPhotoUrlMap') userPhotoUrlMap: Map<string, string> = new Map()

  @State name: string = ''
  @State photo: string = ''
  @State replyCountMap: Map<number, number> = new Map()

  @StorageLink('currentWidthBreakpoint') currentWidthBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;


  // 获取用户头像URL的方法
  async getUserUrl(img: string): Promise<string> {
    // 如果已经缓存，直接返回
    if (this.userPhotoUrlMap.has(img)) {
      return this.userPhotoUrlMap.get(img)!;
    }

    try {
      const downloadURL = await this.commentService.getCloudUserUrl(img);
      if (downloadURL) {
        this.userPhotoUrlMap.set(img, downloadURL);
        return downloadURL;
      }
    } catch (error) {
      console.error('Failed to get user photo URL:', error);
    }

    return '';
  }


  // 异步获取并缓存用户信息
  async fetchUserInfo(userId: string): Promise<User | null> {
    // 如果已经缓存，直接返回
    if (this.userInfoMap.has(userId)) {
      return this.userInfoMap.get(userId)!;
    }

    // 获取用户信息
    const userInfo = await this.commentService.getUserinfo(userId);

    if (userInfo) {
      // 缓存用户信息
      this.userInfoMap.set(userId, userInfo);
      return userInfo;
    }

    return null;
  }

  async aboutToAppear(): Promise<void> {
    if (this.spot === undefined) {
      this.spot = JSON.parse(JSON.stringify(this.value)).spot as Spot
    }

    if (this.spot && this.spot.id) {
      await this.commentService.loadMoreComments(this.spot.id).then(async () => {
        this.comments = this.commentService.comments

        // 预加载顶层评论的用户信息和头像
        for (let comment of this.commentService.topComments) {
          if (comment.userId) {
            const userInfo = await this.fetchUserInfo(comment.userId.toString());
            if (userInfo?.userPhoto) {
              await this.getUserUrl(userInfo.userPhoto);
            }
          }
        }

        // 初始化回复数量映射
        this.commentService.topComments.forEach(comment => {
          if (comment.id) {
            this.replyCountMap.set(
              comment.id,
              this.commentService.getReplies(comment.id, this.spot!.id!).length
            )
          }
        })
      })
    }
  }
  aboutToDisappear(): void {
    this.commentService.reset()
  }

  async postComment(parentId: number): Promise<void> {
    if (this.spot && this.spot.id) {
      if (parentId === -1) {
        this.commentService.postComment(this.commentInput, this.spot.id, this.userId, -1)
        this.commentService.reset()
        await this.commentService.loadMoreComments(this.spot.id)
      } else if(parentId){
        this.commentService.postComment(this.commentInput, this.spot.id, this.userId, parentId)

        // 更新特定评论的回复数量
        if (parentId) {
          const currentCount = this.replyCountMap.get(parentId) || 0
          this.replyCountMap.set(parentId, currentCount + 1)
        }
      }
      this.commentInput = ''
      this.isReplySheetShow = false
    } else {
      promptAction.showToast({ message: '评论失败[景点未定义]', duration: 2000 })
    }
    /*//重新进入该页面
    setTimeout(()=>{
      RouterModule.replacePath(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_SPOTDETAILCOMMENT, new Object({ spot: this.spot }))
    },500)*/

  }

  @Builder
  replySheetBuilder() {
    Column() {
      Column() {
        Text(`回复: ${this.selectedTopComment?.content}`)
          .fontSize(16)
          .fontColor(Color.Gray)
          .margin({ bottom: 10 })

        // 回复列表
        List() {
          ForEach(this.commentService.getReplies(this.selectedTopComment?.id!, this.spot!.id!), (reply: spotComment) => {
            ListItem() {
              Row() {
                // 使用缓存的用户头像URL
                Image(this.userPhotoUrlMap.get(
                  this.userInfoMap.get(reply.userId?.toString() || '')?.userPhoto || ''
                ) || this.currentUserAvatar)
                  .width(40)
                  .height(40)
                  .borderRadius(20)
                  .margin({ right: 10 })

                Column() {
                  // 显示用户名
                  Text(this.userInfoMap.get(reply.userId?.toString() || '')?.userName || '匿名用户')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)

                  Text(reply.replyTime ? formatTime(reply.replyTime?.toString()) : '')
                    .fontSize(12)
                    .fontColor(Color.Gray)

                  Text(reply.content || '')
                    .fontSize(14)
                    .margin({ top: 5 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)
              }
              .padding(10)
              .borderRadius(12)
              .backgroundColor('#F5F6F7')
              .margin({ bottom: 8 })
            }
          })
        }
        .height(300)
        .width('100%')
        .padding({ bottom: 20 })
      }
      .width('100%')

      Row() {
        TextInput({ placeholder: '输入回复...', text: this.commentInput })
          .layoutWeight(1)
          .margin({ right: 10 })
          .onChange((value: string) => {
            this.commentInput = value
          })

        Image($r('app.media.ic_send'))
          .fillColor(Color.Gray)
          .width(24)
          .height(24)
          .onClick(() => {
            if (this.selectedTopComment?.id) {
              this.postComment(this.selectedTopComment?.id!)
            }
          })
      }
      .width('100%')
      .padding(10)
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('80%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius({ topLeft: 20, topRight: 20 })
  }

  build() {
    NavDestination() {
      Column() {
        // 顶部导航栏
        Row()
          {
          Image($r('app.media.ic_back'))
            .width(24)
            .height(24)
            .onClick(() => this.appPathStack.pop())
            .visibility(this.currentWidthBreakpoint === BreakpointConstants.BREAKPOINT_LG ? Visibility.None : Visibility.Visible)

          Text('全部评论')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          Blank()

          Text(`共 ${this.commentService.topComments.length} 条评论`)
            .fontSize(14)
            .fontColor(Color.Gray)
        }
        .width('100%')
        .height(56)
        .backgroundColor('#F5F6F7')
        .padding({ left: 16, right: 16 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // 评论列表
        List() {
          LazyForEach(this.commentService.topCommentsSource, (comment: spotComment) => {
            ListItem() {
              Column() {
                Row() {
                  // 使用缓存的用户头像URL
                  Image(this.userPhotoUrlMap.get(
                    this.userInfoMap.get(comment.userId?.toString() || '')?.userPhoto || ''
                  ) || this.currentUserAvatar)
                    .width(40)
                    .height(40)
                    .borderRadius(20)
                    .margin({ right: 10 })

                  Column() {
                    // 显示用户名
                    Text(this.userInfoMap.get(comment.userId?.toString() || '')?.userName || '匿名用户')
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)

                    Text(comment.replyTime ? formatTime(comment.replyTime?.toString()) : '')
                      .fontSize(12)
                      .fontColor(Color.Gray)
                  }
                }
                .width('100%')
                .margin({ bottom: 10 })

                Text(comment.content || '')
                  .fontSize(16)
                  .textAlign(TextAlign.Start)
                  .width('100%')
                  .margin({ bottom: 10 })

                Row() {
                  Blank()
                  Text('回复')
                    .fontSize(14)
                    .fontColor(Color.Gray)

                  Badge({
                    // 使用响应式的 replyCountMap
                    count: this.replyCountMap.get(comment.id!) || 0,
                    style: {
                      fontSize: 10,
                      badgeColor: Color.Gray,
                      borderColor: Color.Gray
                    }
                  }) {
                    Image($r('app.media.ic_reply'))
                      .width(30)
                      .height(30)
                  }
                  .margin({ right: 10 })
                }
                .width('100%')
                .onClick(() => {
                  this.selectedTopComment = comment
                  this.isReplySheetShow = true
                })
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#F5F6F7')
              .borderRadius(12)
              .margin({ bottom: 10 })
            }
          })
        }
        .width('100%')
        .height( this.currentWidthBreakpoint === BreakpointConstants.BREAKPOINT_LG ? '70%' :'80%')
        .padding(16)

        Blank()
          .visibility(this.currentWidthBreakpoint === BreakpointConstants.BREAKPOINT_LG ? Visibility.None : Visibility.Visible)

        Row() {
          TextInput({ placeholder: '说点什么...', text: this.commentInput })
            .margin({ right: 10 })
            .onChange((value: string) => {
              this.commentInput = value
            })
            .width('95%')

          Image($r('app.media.ic_send'))
            .fillColor(Color.Gray)
            .width(24)
            .height(24)
            .onClick(() => this.postComment(-1))
        }
        //.offset({bottom:16})
        .alignSelf(ItemAlign.End)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding(16)
        .backgroundColor('#F5F6F7')

      }
      .height('100%')
      .bindSheet(this.isReplySheetShow, this.replySheetBuilder(), {
        detents: [500],
        dragBar: true,
        backgroundColor: Color.White,
        showClose: true,
        preferType: SheetType.BOTTOM,
        onDisappear: () => {
          this.isReplySheetShow = false
          this.commentInput = ''
        }
      })
    }
    .margin({ top: this.currentWidthBreakpoint === BreakpointConstants.BREAKPOINT_LG ? 0 : $r('app.float.header_height_page') })
    .hideTitleBar(true)
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
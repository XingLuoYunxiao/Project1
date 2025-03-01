import { spotComment } from '../model/spotComment'
import { promptAction } from '@kit.ArkUI'
import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from 'routermodule'
import { Spot } from '../model/Spot'
import { CommentService } from '../service/CommentService'
import { formatTime } from '../pages/SpotDetailComment'
import { User } from '../model/CommentModel'

@Component
export struct SpotComment {
  @Prop spot: Spot
  @State commentService: CommentService = CommentService.getInstance()
  @StorageLink('personUid') userId: string = '';
  @State commentList: spotComment[] = []
  @State totalCommentCount: number = 0
  @StorageLink('personName') userName: string = ''
  @StorageLink('personPhoto') personPhoto: string = ''
  @State currentUserId: string = 'user123'
  @State commentInput: string = ''
  @State comments: spotComment[] = []
  @State selectedTopComment: spotComment | null = null

  // 新增：用于存储用户信息和照片URL的映射
  @StorageLink('userInfoMap') userInfoMap: Map<string, User> = new Map()
  @StorageLink('userPhotoUrlMap') userPhotoUrlMap: Map<string, string> = new Map()
  @State currentUserAvatar: Resource = $r('app.media.avator')

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

  // 初始化评论数据
  async aboutToAppear(): Promise<void> {
    await this.loadComments()
  }

  // 加载评论的方法
  async loadComments(): Promise<void> {
    try {
      if (this.spot && this.spot.id) {
        await this.commentService.loadMoreComments(this.spot.id)
      }
      // 筛选当前景点的顶级评论
      this.commentList = this.commentService.topComments.slice(0, 3)
      this.totalCommentCount = this.commentService.topComments.length

      // 预加载用户信息和头像
      for (let comment of this.commentList) {
        if (comment.userId) {
          const userInfo = await this.fetchUserInfo(comment.userId.toString());
          if (userInfo?.userPhoto) {
            await this.getUserUrl(userInfo.userPhoto);
          }
        }
      }
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
              // 使用缓存的用户头像URL
              Image(this.userPhotoUrlMap.get(
                this.userInfoMap.get(comment.userId?.toString() || '')?.userPhoto || ''
              ) || this.currentUserAvatar)
                .width(40)
                .height(40)
                .borderRadius(20)
                .margin({ right: 10 })

              Column() {
                Row() {
                  // 显示用户名
                  Text(this.userInfoMap.get(comment.userId?.toString() || '')?.userName || '匿名用户')
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
          buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_SPOTDETAILCOMMENT, new Object({ spot: this.spot }))
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
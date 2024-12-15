import { CommonConstants } from "../common/constants/commonConstants"
import { ChatMessageType, ROLE } from "../model/ChatMassageModel"


@Component
export struct MessageComponent {
  @Prop role: ROLE = ROLE.system
  @Prop msg: string
  @Prop roleHeadImg: ResourceStr = $r('app.media.ic_system_head')
  @Prop msgType: ChatMessageType = ChatMessageType.Text
  @Prop ImageURL?: string | ResourceStr

  build() {
    // 左边是用户头像，右边是用户姓名和信息

    if (this.role != ROLE.user) {
      Row() {
        //用户头像
        Column() {
          if (this.role === ROLE.IdiomSystem) {
            Image(CommonConstants.IdiomSystemHeadImg)
              .roleHeadImg()
          } else {
            Image(this.roleHeadImg)
              .roleHeadImg()
          }

        }
        .justifyContent(FlexAlign.Start)
        .width(60)

        //消息
        if (this.msgType === ChatMessageType.Text) {
          Text(this.msg)
            .borderRadius({ topRight: 20, bottomLeft: 20, bottomRight: 20 })
            .msg()
        } else {
          Image(this.msg)
        }

      }
      .justifyContent(FlexAlign.Start)
      .width('100%')

    } else {
      Row() {
        //消息
        if (this.msgType === ChatMessageType.Text) {
          Text(this.msg)
            .borderRadius({ topRight: 20, bottomLeft: 20, bottomRight: 20 })
            .msg()
        } else {
          Image(this.ImageURL)

        }


        //用户头像
        Column() {
          Image($r('app.media.ic_system_head'))
            .roleHeadImg()
        }
        .justifyContent(FlexAlign.Start)
        .width(60)

      }
      .justifyContent(FlexAlign.End)
      .width('100%')

    }

  }
}

@Extend(Text)
function msg() {
  .padding({
    left: 15,
    right: 15,
    top: 8,
    bottom: 8
  })
  .backgroundColor($r('app.color.massage_background'))
}

@Extend(Image)
function roleHeadImg() {
  .width(45)
  .borderRadius(100) //设置为圆形
  .margin(5)
}

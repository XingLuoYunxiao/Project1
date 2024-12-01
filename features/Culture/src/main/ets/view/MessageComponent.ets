import { CommonConstants } from "../common/constants/commonConstants"
import { ROLE } from "../model/ChatMassageModel"


@Component
export struct MessageComponent {
  @Prop role: ROLE = ROLE.system
  @Prop msg: string
  @Prop roleHeadImg: ResourceStr = $r('app.media.ic_system_head')

  build() {
    // 左边是用户头像，右边是用户姓名和信息

    if (this.role != ROLE.user) {
      Row() {
        //用户头像
        Column() {
          if (this.role === ROLE.IdiomSystem) {
            Image(CommonConstants.IdiomSystemHeadImg)
              .width(60)
              .borderRadius(100) //设置为圆形
          } else {
            Image(this.roleHeadImg)
              .width(60)
              .borderRadius(100) //设置为圆形
          }

        }
        .justifyContent(FlexAlign.Start)
        .width(60)

        //消息
        Text(this.msg)
          .borderRadius({ topRight: 20, bottomLeft: 20, bottomRight: 20 })
          .padding({
            left: 15,
            right: 15,
            top: 8,
            bottom: 8
          })

          .borderRadius({
            topLeft: 0,
            topRight: 20,
            bottomLeft: 20,
            bottomRight: 20
          })
          .backgroundColor($r('app.color.massage_background'))
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')

    } else {
      Row() {
        //消息
        Text(this.msg)
          .borderRadius({ topRight: 20, bottomLeft: 20, bottomRight: 20 })
          .borderRadius({ topRight: 20, bottomLeft: 20, bottomRight: 20 })
          .padding({
            left: 15,
            right: 15,
            top: 8,
            bottom: 8
          })

          .borderRadius({
            topLeft: 20,
            topRight: 0,
            bottomLeft: 20,
            bottomRight: 20
          })
          .backgroundColor($r('app.color.massage_background'))
        //用户头像
        Column() {
          Image($r('app.media.ic_system_head'))
            .width(60)
            .borderRadius(100) //设置为圆形
        }
        .justifyContent(FlexAlign.Start)
        .width(60)

      }
      .justifyContent(FlexAlign.End)
      .width('100%')

    }

  }
}
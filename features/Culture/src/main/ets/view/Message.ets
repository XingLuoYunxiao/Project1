import { ROLE } from "../common/constants/commonConstants"


@Component
export struct MessageComponent {
  @Prop role: ROLE = ROLE.system
  @Prop msg: string
  @Prop roleImgHead: ResourceStr = $r('app.media.ic_system_head')

  build() {
    // 左边是用户头像，右边是用户姓名和信息


    if (this.role != ROLE.user) {
      Row() {
        //用户头像
        Column() {
          Image(this.roleImgHead)
            .width(60)
        }
        .justifyContent(FlexAlign.Start)
        .width(60)

        //消息
        Text(this.msg)
          .borderRadius({ topRight: 20, bottomLeft: 20, bottomRight: 20 })
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')

    } else {
      Row() {
        //消息
        Text(this.msg)
          .borderRadius({ topRight: 20, bottomLeft: 20, bottomRight: 20 })

        //用户头像
        Column() {
          Image($r('app.media.ic_system_head'))
            .width(60)
        }
        .justifyContent(FlexAlign.Start)
        .width(60)
      }
      .justifyContent(FlexAlign.End)
      .width('100%')

    }

  }
}
import Constants from "../constants/Constants"

@Component
export struct NearbySpotLoadingSkeleton{

  build() {
    Row() {
      Column() {
        Row()
          .width('100%')
          .height(60)
          .backgroundColor($r('app.color.skeleton_color_deep'))

        Row()
          .height(20)
          .width("40%")
          .margin({ top: 5})
          .backgroundColor($r('app.color.skeleton_color_medium'))

      }
      .width('40%')
      .padding(8)
      .alignItems(HorizontalAlign.Center)

      Column() {
        Row()
          .height(20)
          .width("30%")
          .backgroundColor($r('app.color.skeleton_color_medium'))

        Row()
          .height(20)
          .width('80%')
          .padding({ top: 5 })
          .backgroundColor($r('app.color.skeleton_color_light'))

      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.End)

    }
    .borderRadius(Constants.BORDER_RADIUS_MD)
    .backgroundColor(Color.White)
    .height(100)
    .width('100%')
    .padding(5)
    .margin({ top: 5, bottom: 5, left: 10, right: 10})
  }
}
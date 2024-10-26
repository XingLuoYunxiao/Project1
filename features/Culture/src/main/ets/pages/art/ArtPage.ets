@Builder
export function ArtPageBuilder(name: string, param: Object) {
  ArtPage()
}

//@Preview

@Component
export struct ArtPage {
  @Consume('culturePathStack') culturePathStack: NavPathStack
  // 从 rawfile 资源文件夹加载 json data
  @State animationData?: Object = undefined

  // 无控制动画需求时 LottieController 可不传


  build() {
    NavDestination() {
      Stack() {
        Image($r('app.media.artPageBackground'))
          .width('100%')
          .height('100%')

        Column() {
          Text('中华美术')
            .fontSize(36)
            .fontFamily('wangxizhi')

          Text($r('app.string.artPage_show_introducion'))
            .fontSize(18)
            .margin(15)


        }
        .width('100%')
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(HorizontalAlign.Center)
      }

    }
    .hideTitleBar(true)

  }
}
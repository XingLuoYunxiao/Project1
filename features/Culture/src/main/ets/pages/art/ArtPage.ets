import { Lottie, LottieController } from "@jjr/lottie_component"
import { ttf } from "../../util/ttf"

@Builder
export function ArtPageBuilder(name: string, param: Object) {
  ArtPage()
}


@Component
export struct ArtPage {
  @Consume('culturePathStack') culturePathStack: NavPathStack
  // 从 rawfile 资源文件夹加载 json data
  @State @Watch('set') animationData?: Object = undefined
  private artController: LottieController = new LottieController()
  private swiperController: SwiperController = new SwiperController()

  // 无控制动画需求时 LottieController 可不传

  async aboutToAppear() {
    ttf('STXINGKAFont', 'STXINGKA.TTF')
    this.animationData = await LottieController.getRawFileAnimationData(getContext(this), 'sroll.json')


  }

  set() {
    if (this.animationData) {
      this.artController.setSpeed(0)
    }
  }

  build() {
    NavDestination() {
      Swiper(this.swiperController) {
        Stack() {
          Image($r('app.media.artPageBackground'))
            .width('100%')
            .height('100%')

          Column() {
            Text('中华美术')
              .fontSize(36)
              .fontFamily('wangxizhi')
              .fontFamily('STXINGKAFont')

            Text($r('app.string.artPage_show_introducion'))
              .fontSize(26)
              .margin(15)
              .fontFamily('STXINGKAFont')

            if (this.animationData) {

              Lottie({
                animationData: this.animationData,
                autoPlay: true,
                loop: true,
                controller: this.artController,
                contentMode: "Cover"
              })
                .width(120)
                .height(100)
                .margin(10)

            }
          }
          .width('100%')
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(HorizontalAlign.Center)
        }

        ArtType()
      }
      .indicatorInteractive(false)
      .vertical(true)

    }
    .hideTitleBar(true)

  }
}

@Component
struct ArtType {
  build() {
    Column() {
      Text('hello')
    }
    .width('100%')
    .height('100%')
  }
}
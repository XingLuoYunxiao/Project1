import { Lottie, LottieController } from "@jjr/lottie_component"
import { ttf } from "../../common/util/ttf"
import { MyButton } from "../../view/Mybutton"
import { PaintingDetails } from "./PaintingDetails"
import { cloudStorage } from '@kit.CloudFoundationKit';
import { cultureFileUtil } from "../../common/util/FileUtil";
import { FileUtil } from "utils/src/main/ets/puraUtils/FileUtil";
import { BusinessError, request } from "@kit.BasicServicesKit";
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule";


@Component
export struct ArtPage {
  @Consume('culturePathStack') culturePathStack: NavPathStack
  // 从 rawfile 资源文件夹加载 json data
  @State animationData?: Object = undefined
  private artController: LottieController = new LottieController()
  private swiperController: SwiperController = new SwiperController()

  // 无控制动画需求时 LottieController 可不传

  async aboutToAppear() {
    ttf('STXINGKAFont', 'STXINGKA.TTF')
    this.animationData = await LottieController.getRawFileAnimationData(getContext(this), 'sroll.json')
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

        calligraphyPage()
        PaintingPage()
      }
      .indicatorInteractive(false)
      .vertical(true)
      .loop(false)
      .displayArrow(null)
      .indicator(false)
    }
    .hideTitleBar(true)

  }
}

@Component
struct calligraphyPage {
  @Consume('culturePathStack') culturePathStack: NavPathStack
  t: string[] = ['书法如行云流水', "墨香似古木参天", "一笔一划皆风骨", "字字珠玑映心间"]
  @State intro: string = '中华书法，魅力非凡。它历经千年演变，从古老的甲骨文、金文，到篆书、隶书、楷书、行书、草书，种类丰富。每一种书体都有其独特风格，见证着中华文化的传承与发展。现在，让我们一同领略书法之美。'
  @State imageFileName: string = 'background.jpg' // 背景图片文件名
  @State imageDir: string = FileUtil.getFilesDirPath('context.cacheDir') // 图片目录路径
  @State imagePath: string = ''

  build() {
    Navigation(this.culturePathStack) {
      Stack() {
        Column() {


          Text(this.intro)
            .margin({ left: 200, right: 30 })
            .fontSize(26)


          Text("进入")
            .fontSize(24)
            .onClick(() => {

              buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.CULTURE_CALLIGRAPHY)
            })
            .fontColor(Color.White)
            .backgroundColor(Color.Black)
            .margin({ left: 40 })
            .padding(10)
            .borderRadius(20)

        }
        .backgroundImage($r('app.media.Calligrapy_background'))
        .backgroundImageSize(ImageSize.Cover)
        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(HorizontalAlign.Center)
        .width('100%')
        .height('100%')
      }
    }
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)

  }
}

@Component
struct PaintingPage {
  @Consume('culturePathStack') culturePathStack: NavPathStack
  @State intro: string = ' 中华绘画，博大精深。自古老的彩陶岩画逐步演变，涵盖工笔的精致、写意的奔放等多样风格，蕴含中华文化深厚内涵。让我们共同探寻绘画之妙。'

  build() {
    Navigation(this.culturePathStack) {
      Column() {
        Text(this.intro)
          .fontFamily('STXINGKAFont')
          .fontSize(30)


        Text("进入")
          .fontSize(24)
          .onClick(() => {
            buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.CULTURE_PAINTING)
          })
          .fontColor(Color.Black)
          .backgroundColor($r('app.color.poetryItem_background'))
          .margin({ left: 40 })
          .padding(10)
          .borderRadius(20)

      }
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .backgroundImage($r('app.media.painting_background'))
      .backgroundImageSize(ImageSize.Cover)
    }
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)
  }
}

@Builder
export function ArtPageBuilder() {
  ArtPage()
}

const builderName = BuilderNameConstants.CULTURE_ART
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ArtPageBuilder)
  RouterModule.registerBuilder(builderName, builder)
}
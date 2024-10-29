import { Lottie, LottieController } from "@jjr/lottie_component"
import { ttf } from "../../util/ttf"
import { MyButton } from "../../view/Mybutton"
import { PaintingDetails } from "./PaintingDetails"
import { cloudStorage } from '@kit.CloudFoundationKit';
import { cultureFileUtil } from "../../util/FileUtil";
import { FileUtil } from "utils/src/main/ets/utils/puraUtils/FileUtil";
import { BusinessError, request } from "@kit.BasicServicesKit";


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

        calligraphyPage()

        PaintingPage()
      }
      .indicatorInteractive(false)
      .vertical(true)
      .loop(false)
      .displayArrow(null)

    }
    .hideTitleBar(true)

  }
}

@Component
struct calligraphyPage {
  @Consume('culturePathStack') culturePathStack: NavPathStack
  t: string[] = ['书法如行云流水', "墨香似古木参天", "一笔一划皆风骨", "字字珠玑映心间"]
  @State imageFileName: string = 'background.jpg' // 背景图片文件名
  @State imageDir: string = FileUtil.getFilesDirPath('context.cacheDir') // 图片目录路径
  @State imagePath: string = ''

  build() {
    Stack() {


      Column() {
        List() {
          ForEach(this.t, (item: string) => {
            ListItem() {
              Row() {
                Text(item)
                  .fontFamily('STXINGKAFont')
                  .fontSize(30)
              }
              .width('100%')
              .justifyContent(FlexAlign.Center)

            }

          })

        }
        .width('100%')

        MyButton({ Text: "进入" })
          .onClick(() => {
            this.culturePathStack.pushPathByName("CalligraphyDetails", null)
          })

      }
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
    }

  }
}

@Component
struct PaintingPage {
  @Consume('culturePathStack') culturePathStack: NavPathStack

  build() {
    Column() {
      Text('笔底春风化雨来')
        .fontFamily('STXINGKAFont')
        .fontSize(30)
      Text('丹青妙手夺天工')
        .fontFamily('STXINGKAFont')
        .fontSize(30)
      MyButton({ Text: "进入" })
        .onClick(() => {
          this.culturePathStack.pushPathByName('PaintingDetails', null)
        })

    }
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .height('100%')
  }
}

import { FlyingFlowerOrderPage } from './FlyingFlowerOrderPage';
import { ttf } from '../util/ttf';
import { MasterpieceI, tsetMasterPieceIArr } from '../model/MasterpieceI';
import { AncientGames, tsetAncientGamesIArr } from '../model/AncientGamesI';
import { Lottie, LottieController } from '@jjr/lottie_component';

@Component
export struct CulturalHeritageStartPage {
  @Provide('culturePathStack') culturePathStack: NavPathStack = new NavPathStack();
  MasterpieceIArr: MasterpieceI[] = tsetMasterPieceIArr()
  AncientGameIArr: AncientGames[] = tsetAncientGamesIArr()
  // 从 rawfile 资源文件夹加载 json data
  @State animationData?: Object = undefined

  // 无控制动画需求时 LottieController 可不传

  async aboutToAppear() {
    ttf('STXINGKAFont', 'STXINGKA.TTF')


    this.animationData = await LottieController.getRawFileAnimationData(getContext(this), 'down.json')

  }

  build() {

    Navigation(this.culturePathStack) {
      Column() {
        //TODO 非遗天地
        Row() {
          Text('非遗天地')
            .fontSize(30)
            .fontFamily('STXINGKAFont')
            .letterSpacing(10)
        }
        .width('100%')
        .height(50)
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)

        Blank()
          .size({ height: 20 })

        //TODO 经典著作
        this.secondaryHeader('经典著作')
        Blank()

          .height(10)
        //TODO 经典著作格栅
        Grid() {
          ForEach(this.MasterpieceIArr, (MasterpieceI: MasterpieceI) => {
            GridItem() {

              Column({ space: 10 }) {
                // if (this.animationData) {
                //   Lottie({
                //     animationData: this.animationData,
                //     autoPlay: true,
                //     loop: true
                //   })
                //     .width(50)
                //     .height(50)
                //     .margin({ top: 30 })
                // }
                Image(MasterpieceI.img)
                  .size({ height: 40, width: 40 })
                  .backgroundColor(Color.Green)
                  .borderRadius(20)
                Text(MasterpieceI.id)
                  .fontSize(15)
              }
            }
            .onClick(() => {
              this.culturePathStack.pushPathByName(MasterpieceI.path, null)
            })
          })
        }
        .width('100%')
        .height(250)
        //TODO 经典著作栅格布局
        .columnsTemplate('1fr 1fr 1fr')
        .rowsTemplate('1fr 1fr')
        .backgroundColor(Color.White)
        .borderRadius(15)

        Blank()
          .size({ height: 20 })
        //TODO 游识古韵
        this.secondaryHeader('游识古韵')
        Blank()
          .height(10)
        //TODO 游识古韵格栅
        Grid() {
          ForEach(this.AncientGameIArr, (AncientGameI: AncientGames) => {
            GridItem() {
              Column({ space: 10 }) {
                Image(AncientGameI.img)
                  .size({ height: 40, width: 40 })
                  .backgroundColor(Color.Green)
                  .borderRadius(20)
                Text(AncientGameI.id)
                  .fontSize(15)
              }
            }
            .onClick(() => {
              console.log('testlog' + AncientGameI.path)
              this.culturePathStack.pushPathByName(AncientGameI.path, null)
            })
          })
        }
        .width('100%')
        .height(250)
        //TODO 游识古韵栅格布局
        .columnsTemplate('1fr 1fr 1fr')
        .rowsTemplate('1fr 1fr')
        .backgroundColor(Color.White)
        .borderRadius(15)
      }.width('95%')
      .height('100%')
      .backgroundColor('#F1F3F5')
    }
    .navDestination(this.travelStartRouter)
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
  }

  @Builder
  travelStartRouter(path: string) {
    if (path === 'PoetryPage') {
      // TODO 诗歌界面
    } else if (path === 'IntangibleCulturalHeritagePage') {
      //TODO 非遗界面
    } else if (path === 'FlyingFlowerOrderPage') {
      FlyingFlowerOrderPage()
    } else if (path === '...') {
      //TODO 其他界面
    }
  }

  //TODO 副标题
  @Builder
  secondaryHeader(msg: string) {
    Row() {
      Text(msg)
        .fontSize(35)
        .fontFamily('STXINGKAFont')
    }.width('100%')
    .justifyContent(FlexAlign.Start)
  }
}
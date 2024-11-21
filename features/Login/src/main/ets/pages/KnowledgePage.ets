import { BuilderNameConstants, RouterModule } from 'routermodule';
import { LottieUtil } from 'utils/src/main/ets/utils/LottieUtil';
import { AchieveImage, ACHIEVE_IMAGE_LIST } from '../model/AchievementModel';

@Component
export struct KnowledgePage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @StorageProp('pointMap') pointMap: Map<string,number> = new Map
  @State isShow: boolean = false;
  private mainRenderingSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private mainCanvasRenderingContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.mainRenderingSettings);

  getShowImg(item: AchieveImage): Resource | undefined {
    // if (this.learnedIds.includes(item.pathId)) {
      return item.activeImage;
    // }
    // return item.defaultImage;
  }

  build() {
    NavDestination(){
      Column() {
        Grid(){
          ForEach(ACHIEVE_IMAGE_LIST,(item:AchieveImage)=>{
            GridItem() {
              Image(this.getShowImg(item))
                .interpolation(ImageInterpolation.High)
                .width(100)
                .aspectRatio(1)
            }.onClick(()=>{
              // if (this.learnedIds.includes(item.pathId)) {
              //   this.clickedItem = item;
              //   this.isShow = true;
              // }
                    this.isShow = true;
              //   if(this.pointMap.get('poem')){
              //     if((this.pointMap.get('poem') as number)>20){
              //       this.isShow = true;
              //     }
            })
          })
        }
        .bindContentCover(
          this.isShow,
          this.playLottieBuilder(),
          {
            modalTransition: ModalTransition.ALPHA,
            onDisappear: () => {
              LottieUtil.destroy();
            }
          }
        )
        .width('100%')
        .columnsTemplate('1fr 1fr')
        .columnsGap(10)
        .rowsGap(10)
        .padding(5)
        .margin(6)
      }
      .width('100%')
      .height('100%')
    }
  }
  @Builder
  playLottieBuilder() {
    Column() {
      Column() {
        Canvas(this.mainCanvasRenderingContext)
          .height(50)
          .width(80)
          .onReady(() => {
            // if (this.clickedItem != null) {
              LottieUtil.loadAnimation({
                container: this.mainCanvasRenderingContext,
                renderer: 'canvas',
                loop: false,
                autoplay: true,
                name: 'p001',
                path: 'common/lottie/learning_path_1_lottie.json'
              })
            // }
          })
          .onClick(() => {
            this.isShow = false;
          })
      }

      Column() {
        Button($r('app.string.write_success'))
          .onClick(() => {
            this.isShow = false;
          })
      }
    }
    .justifyContent(FlexAlign.Center)
    .width(100)
    .height(100)
  }
}
@Builder
export function KnowledgePageBuilder() {
  KnowledgePage()
}

const builderName = BuilderNameConstants.LOGIN_KNOWLEDGEPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(KnowledgePageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
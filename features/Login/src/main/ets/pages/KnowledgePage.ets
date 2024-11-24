import { BuilderNameConstants, RouterModule } from 'routermodule';
import { LottieUtil } from 'utils/src/main/ets/utils/LottieUtil';
import { AchieveImage, ACHIEVE_IMAGE_LIST } from '../model/AchievementModel';
import { PreferencesUtil } from "utils/src/main/ets/utils/puraUtils/PreferencesUtil"
import { EXP } from 'culture';
import Constants from '../common/constants/Constants';

@Component
export struct KnowledgePage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @StorageProp('pointMap') pointMap: Map<string,number> = new Map
  @State isShow: boolean = false;
  private mainRenderingSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private mainCanvasRenderingContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.mainRenderingSettings);
  @State exp:EXP[]=[]

  aboutToAppear() {
    let EXPString: string = PreferencesUtil.getSync("EXP", "") as string
    this.exp= JSON.parse(EXPString) as EXP[]
  }
  getShowImg(item: AchieveImage): Resource | undefined {
    if(this.exp[0].value>1000){
      return item.activeImage;
    }
    return item.defaultImage;
  }

  build() {
    NavDestination(){
      Column() {
        Row(){
          Image($r('app.media.ic_back')).width($r('app.float.md_topic_width')).onClick(()=>{
            this.appPathStack.pop()
          })
        }
        .height(Constants.TOP_HEIGHT_PAGE)
        Grid(){
          ForEach(ACHIEVE_IMAGE_LIST,(item:AchieveImage)=>{
            GridItem() {
              Image(this.getShowImg(item))
                .interpolation(ImageInterpolation.High)
                .width(100)
                .aspectRatio(1)
            }.onClick(()=>{
              if(this.getShowImg(item)==item.activeImage){
                this.isShow = true;
              }
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
      .padding({left:Constants.PADDING_PAGE,right:Constants.PADDING_PAGE})
      .width('100%')
      .height('100%')
    }.margin({top:Constants.HEADER_HEIGHT_PAGE})
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
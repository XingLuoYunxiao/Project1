import { BuilderNameConstants, RouterModule } from 'routermodule';
import { LottieUtil } from 'utils/src/main/ets/utils/LottieUtil';
import { AchieveImage, ACHIEVE_IMAGE_LIST } from '../model/AchievementModel';
import { EXP } from 'culture';
import Constants from '../common/constants/Constants';
import { PreferencesUtil } from 'utils/src/main/ets/puraUtils/PreferencesUtil';
@Component
export struct KnowledgePage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @StorageProp('pointMap') pointMap: Map<string,number> = new Map
  @State isShow: boolean = false;
  //canvas是否开启抗锯齿
  private mainRenderingSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private mainCanvasRenderingContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.mainRenderingSettings);
  @State exp:EXP[]=[]
  @State EXPString:string=''
  @State clickedItem: AchieveImage | null = null;


  aboutToAppear() {
    this.EXPString= PreferencesUtil.getSync("EXP", "") as string
    this.exp= JSON.parse(this.EXPString) as EXP[]
  }
  getShowImg(item: AchieveImage,len:number): Resource | undefined {
    if(this.EXPString!==''){
      while (len>0) {
         switch (this.exp[len-1].key) {
            case 'knowledge':
              if (item.pathId === '1') {
                return this.exp[len-1].value > 100 ? item.activeImage : item.defaultImage;
              }else if(item.pathId==='2'){
                return this.exp[len-1].value > 1500? item.activeImage : item.defaultImage;
              }
              break;
            case 'culture':
              if (item.pathId === '3') {
                return this.exp[len-1].value > 100 ? item.activeImage : item.defaultImage;
              }else if(item.pathId==='4'){
                return this.exp[len-1].value > 1500? item.activeImage : item.defaultImage;
              }
              break;
            case 'game':
              if (item.pathId === '5') {
                return this.exp[len-1].value > 100 ? item.activeImage : item.defaultImage;
              }else if(item.pathId==='6'){
                return this.exp[len-1].value > 1500? item.activeImage : item.defaultImage;
              }
              break;
         }
         len--;
      }
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
          Text('知识等级')
        }.width('100%')
        .justifyContent(FlexAlign.Start)
        .height(Constants.TOP_HEIGHT_PAGE)
        Grid(){
          ForEach(ACHIEVE_IMAGE_LIST,(item:AchieveImage)=>{
            GridItem() {
              Image(this.getShowImg(item,this.exp.length))
                //缓解图片在缩放时的锯齿问题
                .interpolation(ImageInterpolation.High)
                .width(100)
                //组件的宽高比,仅设置width、aspectRatio时，height=width/aspectRatio
                .aspectRatio(1)
            }.onClick(()=>{
              if(this.getShowImg(item,this.exp.length)==item.activeImage){
                this.clickedItem = item;
                this.isShow = true;
              }
            })
          })
        }
        .bindContentCover(
          this.isShow,
          this.playLottieBuilder(),
          {
            //全屏模态透明度渐变动画
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
      .padding({left:Constants.PADDING_PAGE,right:Constants.PADDING_PAGE,top:Constants.PADDING_PAGE})
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(true)
    .margin({top:Constants.HEADER_HEIGHT_PAGE})
  }
  @Builder
  playLottieBuilder() {
    Column() {
      Column() {
        Canvas(this.mainCanvasRenderingContext)
          .height(200)
          .width(200)
          //Canvas组件初始化完成时或者Canvas组件发生大小变化时的事件回调
          .onReady(() => {
              LottieUtil.loadAnimation({
                container: this.mainCanvasRenderingContext,
                renderer: 'canvas',
                loop: false,
                autoplay: true,
                name: this.clickedItem?.pathId,
                path: this.clickedItem?.lottiePath
              })
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
    .width('100%')
    .height('100%')
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
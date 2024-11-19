import lottie from '@ohos/lottie'
import { LottieUtil } from '@ohos/utils';
import { AchieveImage, ACHIEVE_IMAGE_LIST } from '../model/AchievementModel';
import { UserModel } from '../model/UserModel';

@Builder
export function KnowledgePageBuilder() {
  KnowledgePage()
}
@Component
export struct KnowledgePage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @State isShow: boolean = false;
  private mainRenderingSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private mainCanvasRenderingContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.mainRenderingSettings);

  getShowImg(item: AchieveImage): Resource | undefined {
    // if (this.learnedIds.includes(item.pathId)) {
    //   return item.activeImage;
    // }
    return item.defaultImage;
  }
  // startLottieAnimation() {
  //   const animationItem = LottieUtil.loadAnimation({
  //     container: this.mainCanvasRenderingContext,
  //     renderer: 'canvas',
  //     loop: false,
  //     autoplay: false,
  //     // name: this.articleId + this.type,
  //     path: this.isClicked ? this.cancelAnimationPath : this.clickAnimationPath
  //   });
  //   animationItem.addEventListener('complete', () => {
  //     this.playingAnimation = false;
  //     LottieUtil.destroy(this.articleId + this.type);
  //   });
  //   animationItem.addEventListener('error', () => {
  //     this.playingAnimation = false;
  //     LottieUtil.destroy(this.articleId + this.type);
  //   });
  //   LottieUtil.play(this.articleId + this.type);
  //
  //   this.isClicked = !this.isClicked;
  //   this.onClicked?.();
  // }
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
            })
          })
        }
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
}
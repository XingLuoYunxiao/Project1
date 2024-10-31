import { Lottie, LottieController } from "@jjr/lottie_component"


//测试用的
@Component
export struct testTwo {
  @State a: boolean = true
  // 从 rawfile 资源文件夹加载 json data
  @State animationData?: Object = undefined
  private artController: LottieController = new LottieController()

  async aboutToAppear() {
    this.animationData = await LottieController.getRawFileAnimationData(getContext(this), 'down.json')
  }

  build() {
    Column() {
      this.lottieConp()
    }
    .height(200)
  }

  @Builder
  lottieConp() {
    Column() {
      if (this.a) {
        Lottie({
          animationData: this.animationData,
          autoPlay: true,
          loop: true,
          controller: this.artController,
          contentMode: "Cover"
        })
          .width(120)
          .height(90)
          .margin(10)
      } else {
        Text('呵呵')
      }


    }
    .height(200)
    .width('100%')
  }
}

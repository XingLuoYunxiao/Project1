import { LoadParams } from "../pages/FamousPlacePage";

@Component
export struct LoadingAnimation {
  @State currentStep: number = 0
  @Consume('travelPathStack') travelPathStack: NavPathStack;
  private steps: string[] = ['正在为您智能规划路径', '正在生成虚拟人为您讲解', '已完成']
  private intervalID: number = -1



  aboutToAppear() {
    let object = this.travelPathStack.getParamByName('LoadingAnimation')[0] as LoadParams

    this.intervalID = setInterval(() => {
      if (this.currentStep < this.steps.length - 1) {
        this.currentStep++
      } else {
        clearInterval(this.intervalID)
        this.travelPathStack.replacePathByName(object.param1, object.param2)
      }
    }, 1000)  // 每秒更新一次，总共3秒
  }

  aboutToDisappear() {
    clearInterval(this.intervalID)
  }

  build() {
    NavDestination(){
      Column() {
        Progress({
          value: ((this.currentStep + 1) * 100) / this.steps.length,
          total: 100,
          type: ProgressType.Linear
        })
          .color('#ff62eae8')
          .width('80%')
          .height(20)
          .style({strokeWidth:10})
          .margin({ bottom: 20 })

        Row() {
          if (this.currentStep < this.steps.length - 1) {
            LoadingProgress()
              .color(Color.White)
              .width(30)
              .height(40)
              .margin({ right: 10 })
          } else {
            Image($r('app.media.check'))
              .width(20)
              .height(20)
              .margin({ right: 10 })
          }
          Text(this.steps[this.currentStep])
            .fontSize(18)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
        }
        .width('80%')
        .justifyContent(FlexAlign.Start)
      }
      .width('100%')
      .height('100%')
      .backgroundImage($r("app.media.load_background"))
      .backgroundImageSize({width:'100%',height:'100%'})
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.Center)

    }
    .hideTitleBar(true)
  }
}


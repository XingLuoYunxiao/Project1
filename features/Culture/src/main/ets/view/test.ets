import lottie, { AnimationItem } from "@ohos/lottie";
// 测试用的
@Component
export struct testOne {
  private mainRenderingSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private mainCanvasRenderingContext: CanvasRenderingContext2D =
    new CanvasRenderingContext2D(this.mainRenderingSettings)
  private animateItem: AnimationItem | null = null;
  private animateName: string = "down";

  aboutToAppear(): void {
    lottie.destroy(this.animateName)
    this.animateItem = lottie.loadAnimation({
      container: this.mainCanvasRenderingContext,
      renderer: 'canvas', // canvas 渲染模式
      loop: 10,
      autoplay: true,
      name: this.animateName,
      contentMode: 'Contain',
      path: "common/lottie/down.json", // 路径加载动画只支持entry/src/main/ets 文件夹下的相对路径
    })
  }

  build() {
    Column() {
      Canvas(this.mainCanvasRenderingContext)
        .width(200)
        .height(200)
        .backgroundColor(Color.White)
        .onReady(() => {
          // 可在此生命回调周期中加载动画，可以保证动画尺寸正确
          //抗锯齿的设置
          this.mainCanvasRenderingContext.imageSmoothingEnabled = true;
          this.mainCanvasRenderingContext.imageSmoothingQuality = 'medium'
          this.animateItem?.resize();
        })
        .onDisAppear(() => {
          lottie.destroy(this.animateName);
        })


      Button('加载down')
        .onClick(() => {
          lottie.destroy(this.animateName)
          this.animateItem = lottie.loadAnimation({
            container: this.mainCanvasRenderingContext,
            renderer: 'canvas', // canvas 渲染模式
            loop: 10,
            autoplay: true,
            name: this.animateName,
            contentMode: 'Contain',
            path: "common/lottie/down.json", // 路径加载动画只支持entry/src/main/ets 文件夹下的相对路径
          })
        })

      Button('销毁down')
        .onClick(() => {
          lottie.destroy(this.animateName)
        })
    }

  }
}
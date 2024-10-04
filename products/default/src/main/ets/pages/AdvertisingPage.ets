import router from '@ohos.router'
/*
* 广告页面
* */
@Entry
@Component
struct AdvertisingPage {
  @State countDownSeconds: number = 4
  private timeId: number = 0
  /**
   * 跳转到 APP 首页面
   */
  jumpToAppHomePage() {
    router.replaceUrl({
      url: 'pages/Index'
    })
  }

  judgeToCount(){
    this.countDownSeconds -= 1
    if( this.countDownSeconds === 0){
      this.jumpToAppHomePage()
    }
  }

  //页面显示
  onPageShow() {
    //setInterval()重复调用一个函数，在每次调用之间具有固定的时间延迟。
    this.timeId = setInterval( () => {
      this.judgeToCount()
    }, 1000)

  }

  //页面隐藏
  onPageHide() {
    //清除所有历史页面并仅保留堆栈顶部的当前页面
    //取消通过 setInterval()设置的重复定时任务
    clearInterval(this.timeId)
  }

  build() {
    //层叠布局
    Stack({ alignContent: Alignment.Top }) {
      Image($r("app.media.advertise_image"))
        .objectFit(ImageFit.Fill)
      Row(){
        Text(`跳过 ${this.countDownSeconds}`)
          .padding({left:18})
          .width(100)
          .borderRadius(10)
          .border({style:BorderStyle.Solid})
          .borderWidth(1)
          .fontSize(20)
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .padding({right:10, top:20})
      .margin({top:10})
    }
    .onClick( () => {
      router.replaceUrl({url:'pages/Index'})
      clearInterval(this.timeId)
    })
  }
}
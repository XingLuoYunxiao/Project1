import { LoadParams } from "../pages/FamousPlacePage"; // 导入LoadParams类型，用于接收路径参数

@Component
export struct LoadingAnimation {  // 定义LoadingAnimation组件
  @State currentStep: number = 0  // 使用@State装饰器定义一个当前步骤的状态变量，初始值为0
  @Consume('travelPathStack') travelPathStack: NavPathStack;  // 使用@Consume注解，获取导航路径栈
  private steps: string[] = ['正在为您智能规划路径', '正在生成虚拟人为您讲解', '已完成']  // 定义路径规划的不同阶段文本
  private intervalID: number = -1  // 定义定时器ID，用于管理计时器

  // 生命周期方法，在组件即将出现时调用
  aboutToAppear() {
    // 从路径栈中获取传递的参数对象
    let object = this.travelPathStack.getParamByName('LoadingAnimation')[0] as LoadParams

    // 设置一个定时器，每秒更新一次当前步骤
    this.intervalID = setInterval(() => {
      if (this.currentStep < this.steps.length - 1) {  // 如果当前步骤小于最大步骤
        this.currentStep++  // 当前步骤递增
      } else {
        clearInterval(this.intervalID)  // 完成所有步骤后清除定时器
        this.travelPathStack.replacePathByName(object.param1, object.param2)  // 完成后替换路径
      }
    }, 1000)  // 每秒执行一次
  }

  // 生命周期方法，在组件即将消失时调用
  aboutToDisappear() {
    clearInterval(this.intervalID)  // 清除定时器，避免内存泄漏
  }

  // 构建UI界面
  build() {
    NavDestination() {  // 定义一个导航目标容器
      Column() {  // 使用Column布局
        Progress({  // 显示进度条
          value: ((this.currentStep + 1) * 100) / this.steps.length,  // 根据当前步骤计算进度
          total: 100,
          type: ProgressType.Linear  // 设置进度条为线性类型
        })
          .color('#ff62eae8')  // 设置进度条颜色
          .width('80%')  // 设置进度条宽度
          .height(20)  // 设置进度条高度
          .style({strokeWidth:10})  // 设置进度条的线宽
          .margin({ bottom: 20 })  // 设置进度条底部边距

        Row() {  // 使用Row布局，用于显示文本和加载动画
          if (this.currentStep < this.steps.length - 1) {  // 如果尚未完成最后一步
            LoadingProgress()  // 显示加载动画
              .color(Color.White)  // 设置加载动画颜色
              .width(30)  // 设置加载动画宽度
              .height(40)  // 设置加载动画高度
              .margin({ right: 10 })  // 设置右边距
          } else {
            Image($r('app.media.check'))  // 显示完成图标
              .width(20)  // 设置图标宽度
              .height(20)  // 设置图标高度
              .margin({ right: 10 })  // 设置右边距
          }
          Text(this.steps[this.currentStep])  // 显示当前步骤对应的文本
            .fontSize(18)  // 设置字体大小
            .fontColor(Color.White)  // 设置字体颜色
            .fontWeight(FontWeight.Bold)  // 设置字体粗细
        }
        .width('80%')  // 设置Row布局宽度
        .justifyContent(FlexAlign.Start)  // 内容对齐到左侧
      }
      .width('100%')  // 设置Column布局宽度
      .height('100%')  // 设置Column布局高度
      .backgroundImage($r("app.media.load_background"))  // 设置背景图
      .backgroundImageSize({width:'100%',height:'100%'})  // 设置背景图大小
      .backgroundColor(Color.White)  // 设置背景颜色为白色
      .justifyContent(FlexAlign.Center)  // 内容居中显示
    }
    .hideTitleBar(true)  // 隐藏标题栏
  }
}

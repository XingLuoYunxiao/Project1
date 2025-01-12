// 定义一个用于水波纹效果的按钮组件
import { Scale } from '@kit.ArkUI';
import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from 'routermodule';

//@Preview
@Component
export struct ButtonWithWaterRipples {
  // 使用 @Link 装饰器连接到外部的 isListening 状态。
  // 当外部组件中的 isListening 值变化时，此处的 isListening 也会同步更新。
  @Link isListening: boolean;
  // 使用 @State 装饰器定义 immediatelyOpacity 状态。
  // 这个状态用于控制按钮被点击时立即的透明度反应，初始值设为0.8。
  // 状态变化将导致组件重新渲染。
  @State immediatelyOpacity: number = 0.8;
  // 使用 @State 装饰器定义 immediatelyScale 状态。
  // 这个状态用于控制按钮被点击时立即的缩放效果，初始比例为 { x: 1, y: 1 }，表示无缩放。
  // 状态变化将导致组件重新渲染。
  @State immediatelyScale: Scale = { x: 1, y: 1 };
  // 使用 @State 装饰器定义 delayOpacity 状态。
  // 这个状态用于控制按钮被点击后延迟发生的透明度变化，初始值同样设为0.8。
  // 状态变化将导致组件重新渲染。
  @State delayOpacity: number = 0.8;
  // 使用 @State 装饰器定义 delayScale 状态。
  // 这个状态用于控制按钮被点击后延迟发生的缩放效果，初始比例为 { x: 1, y: 1 }，表示无缩放。
  // 状态变化将导致组件重新渲染。
  @State delayScale: Scale = { x: 1, y: 1 };
  private readonly BUTTON_SIZE: number = 72; // 按钮大小常量
  private readonly BUTTON_CLICK_SCALE: number = 0.8; // 按钮点击时的缩放比例
  private readonly ANIMATION_DURATION: number = 1000; // 动画持续时间

  @Styles
  ripplesStyle() {
    // 定义水波纹的样式
    .width(this.BUTTON_SIZE * this.BUTTON_CLICK_SCALE)
    .height(this.BUTTON_SIZE * this.BUTTON_CLICK_SCALE)
    .borderRadius(this.BUTTON_SIZE * this.BUTTON_CLICK_SCALE / 2)
    .backgroundColor(Color.Black) // 设置背景色为白色
  }

  build() {
    // 构建按钮的堆叠布局
    Stack() {
      Stack()
        .ripplesStyle()// 应用水波纹样式
        .opacity(this.immediatelyOpacity)// 设置透明度
        .scale(this.immediatelyScale) // 设置缩放
      Stack()
        .ripplesStyle()// 应用水波纹样式
        .opacity(this.delayOpacity)// 设置透明度
        .scale(this.delayScale) // 设置缩放
      Row() {
        Text('进入')
          .width(100)
          .fontColor(Color.White)
          .opacity(this.immediatelyOpacity)
          .margin({ left: 20 })
          .fontFamily('STXINGKAFont')
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .opacity(this.immediatelyOpacity + 0.2)
      .clickEffect({ level: ClickEffectLevel.HEAVY, scale: this.BUTTON_CLICK_SCALE }) // 设置点击效果
      .backgroundColor(Color.Black) // 设置按钮背景颜色
      .borderRadius(100)
      .width(this.BUTTON_SIZE) // 设置按钮宽度
      .height(this.BUTTON_SIZE) // 设置按钮高度
      .zIndex(1) // 设置堆叠顺序
      .onClick(() => {
        // 点击事件处理函数
        this.isListening = !this.isListening; // 切换监听状态
        if (this.isListening) {
          // 如果开始监听，启动动画
          animateTo({
            duration: this.ANIMATION_DURATION,
            iterations: 1,
            curve: Curve.EaseOut
          }, () => {
            this.immediatelyOpacity = 0.5;
            this.immediatelyScale = {
              x: 24,
              y: 24
            };
          })
          // animateTo({
          //   duration: this.ANIMATION_DURATION,
          //   iterations: 1,
          //   curve: Curve.EaseInOut,
          //   delay: 200
          // }, () => {
          //   this.delayOpacity = 0;
          //   this.delayScale = {
          //     x: 6,
          //     y: 6
          //   };
          // })
        }

        setTimeout(() => {
          buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.CULTURE_CALLIGRAPHY)
          this.immediatelyOpacity = 1
          this.immediatelyScale = {
            x: 1,
            y: 1
          };
          this.isListening = !this.isListening
        }, this.ANIMATION_DURATION)

      })
    }

  }
}
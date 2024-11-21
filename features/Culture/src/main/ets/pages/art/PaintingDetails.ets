// 引入所需的模块和数据模型
import { paintingData } from "../../model/art/DrawingModel"
import { PaintingModel, paintingModelList } from "../../model/art/PaintingModel"
import { ttf } from "../../common/util/ttf"
import { addExp } from "../../common/util/addExp"

// 创建PaintingDetailsBuilder方法，生成PaintingDetails组件
@Builder
export function PaintingDetailsBuilder(name: string, param: Object) {
  PaintingDetails() // 创建并渲染PaintingDetails组件
}

// PaintingDetails组件的主体部分
@Component
export struct PaintingDetails {
  // 组件即将出现时的生命周期函数
  aboutToAppear(): void {
    console.log('这是PaintingDetails') // 控制台输出信息，便于调试
  }

  // build方法构建组件的UI
  build() {
    NavDestination() { // 导航目标组件容器
      Column() { // 使用Column布局
        List({ space: 15 }) { // 列表组件，项目间距为15
          ForEach(paintingModelList, (item: PaintingModel) => { // 遍历绘画模型列表
            ListItem() {
              this.paintingItem(item) // 调用paintingItem方法渲染每个列表项
            }
          })
        }
        .onReachEnd(() => {
          addExp('Painting')

        })

      }
    }
    .hideTitleBar(true) // 隐藏标题栏
  }

  // paintingItem方法，负责渲染单个绘画项目
  @Builder
  paintingItem(item: PaintingModel) {
    Column({ space: 15 }) { // 使用Column布局
      Row() {
        Text(item.name)// 显示绘画名称
          .fontSize(30) // 设置字体大小
      }
      .justifyContent(FlexAlign.Center) // 水平居中对齐
      .width('100%') // 宽度占满

      Column() { // 嵌套Column显示绘画详细信息
        Text("简介：" + item.introduction) // 显示简介
        Text('起源:' + item.originPeriod) // 显示起源

        Text("特征：" + item.characteristics) // 显示特征
        Text("代表画家：" + item.famousArtists.toString()) // 显示代表画家
        List({ space: 10 }) { // 用于展示绘画的图片列表
          ForEach(item.ImageArr, (item: paintingData, index: number) => {
            ShowPainting({ painting: item }) // 渲染每幅绘画图片
          })
        }
        .onReachEnd(() => {

        })
      }
      .padding(10) // 内边距设置为10
      .alignItems(HorizontalAlign.Start) // 水平左对齐
      .backgroundColor('#cecde5d1') // 背景色
      .width('100%') // 宽度占满
    }
    .width('100%') // 外层宽度占满
    .justifyContent(FlexAlign.SpaceBetween) // 元素间均匀分布
  }
}

// ShowPainting组件，显示单幅绘画的详情和展开动画
@Component
struct ShowPainting {
  @Prop painting: paintingData // 接收的绘画数据作为属性
  @State spread: boolean = false // 控制显示详情的状态
  spreadDuration: number = 1500 // 展开动画持续时间
  closeTime: number = 300 // 收起动画持续时间

  aboutToAppear(): void {
    ttf('STXINGKAFont', 'STXINGKA.TTF') // 注册字体
  }

  build() {
    Column({ space: 15 }) {
      Row() {
        Text(this.painting.name)// 显示绘画名称
          .padding(10)// 内边距
          .fontSize(26)// 字体大小
          .fontFamily('STXINGKAFont') // 使用自定义字体
      }
      .onClick(() => {
        this.spread = !this.spread // 切换spread状态，控制展开收起
      })
      .justifyContent(FlexAlign.Center) // 水平居中
      .width('100%') // 宽度占满
      .borderRadius(20) // 设置圆角
      .backgroundImage(this.spread ? null : $r('app.media.painting_title')) // 背景图片

      Column() { // 展开后显示内容的容器
        Scroll() {
          Image(this.painting.path)// 展示绘画图片
            .height(260) // 设置图片高度
        }
        .scrollable(ScrollDirection.Horizontal) // 可水平滚动

        Text(this.painting.explain)// 显示绘画的详细描述
          .fontSize(18)// 字体大小
          .margin({ top: 20 }) // 顶部边距

        Row() { // 收起按钮
          Text('收起')
            .fontSize(16)
            .onClick(() => {
              this.spread = !this.spread // 点击切换spread状态
            })
            .margin({ top: 40 }) // 顶部边距
        }
      }
      .margin({ top: 30 }) // 顶部边距
      .visibility(this.spread ? Visibility.Visible : Visibility.None) // 控制可见性
      .justifyContent(FlexAlign.Center) // 内容居中
      .width('100%') // 宽度占满
      .animation({
        duration: this.spread ? this.spreadDuration : this.closeTime, // 根据spread状态设置动画时长
        curve: Curve.FastOutLinearIn // 动画曲线
      })
    }
    .width('100%') // 外层宽度
    .borderRadius(30) // 外层圆角
    .backgroundColor("#ffe2dad4") // 背景色
    .justifyContent(FlexAlign.SpaceBetween) // 内容均匀分布
  }
}

import { Drawing } from "../../model/art/DrawingModel"
import { paintingMap, PaintingModel, paintingModelList } from "../../model/art/PaintingModel"
import { ttf } from "../../util/ttf"

@Builder
export function PaintingDetailsBuilder(name: string, param: Object) {
  PaintingDetails()
}

// @Preview
@Component
export struct PaintingDetails {
  aboutToAppear(): void {
    console.log('这是PaintingDetails')
  }

  build() {
    NavDestination() {
      Column() {
        List({ space: 15 }) {
          ForEach(paintingModelList, (item: PaintingModel) => {
            ListItem() {
              this.paintingItem(item)
            }
          })
        }
      }
    }
    .hideTitleBar(true)

  }

  @Builder
  paintingItem(item: PaintingModel) {
    Column({ space: 15 }) {
      Row() {
        Text(item.name)
          .fontSize(30)
      }

      .justifyContent(FlexAlign.Center)
      .width('100%')

      Column() {
        Text("简介：" + item.introduction)
        Text('起源:' + item.originPeriod)

        Text("特征：" + item.characteristics)
        Text("代表画家：" + item.famousArtists.toString())
        List({ space: 10 }) {
          ForEach(item.ImageArr, (item: Drawing, index: number) => {
            ShowPainting({ painting: item })
          })
        }

      }
      .padding(10)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor('#cecde5d1')
      .width('100%')

    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)

  }
}

@Component
struct ShowPainting {
  @Prop painting: Drawing
  @State spread: boolean = false
  spreadDuration: number = 1500
  closeTime: number = 300

  aboutToAppear(): void {
    ttf('STXINGKAFont', 'STXINGKA.TTF')
  }

  build() {
    Column({ space: 15 }) {
      Row() {
        Text(this.painting.name)
          .padding(10)
          .fontSize(26)
          .fontFamily('STXINGKAFont')
      }
      .onClick(() => {
        this.spread = !this.spread
      })
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .borderRadius(20)
      .backgroundImage(this.spread ? null : $r('app.media.painting_title'))

      Column() {
        Scroll() {
          Image(this.painting.path)
            .height(180)

        }
        .scrollable(ScrollDirection.Horizontal)

        Text(this.painting.explain)
          .fontSize(18)
          .margin({ top: 20 })

        Row() {
          Text('收起')
            .fontSize(16)
            .onClick(() => {
              this.spread = !this.spread
            })
            .margin({ top: 40 })
        }
      }
      .margin({ top: 30 })
      .visibility(this.spread ? Visibility.Visible : Visibility.None)
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .animation({
        duration: this.spread ? this.spreadDuration : this.closeTime,
        curve: Curve.FastOutLinearIn
      }) // 设置动画效果

    }
    .width('100%')
    .borderRadius(30)
    .borderRadius(20)
    .backgroundColor("#ffe2dad4")
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

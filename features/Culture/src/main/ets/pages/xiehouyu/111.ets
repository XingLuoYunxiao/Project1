// xxx.ets
@Entry
@Component
struct AlphabetIndexerSample {
  @State isNeedAutoCollapse: boolean = false;
  @State indexerHeight: string = '75%';
  private arrayA: string[] = ['安']
  private arrayB: string[] = ['卜', '白', '包', '毕', '丙']
  private arrayC: string[] = ['曹', '成', '陈', '催']
  private arrayJ: string[] = ['嘉', '贾']
  private value: string[] = ['#', 'A', 'B', 'C', 'D', 'E', 'F', 'G',
    'H', 'I', 'J', 'K', 'L', 'M', 'N',
    'O', 'P', 'Q', 'R', 'S', 'T', 'U',
    'V', 'W', 'X', 'Y', 'Z']

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row() {
        List({ space: 20, initialIndex: 0 }) {
          ForEach(this.arrayA, (item: string) => {
            ListItem() {
              Text(item)
                .width('80%')
                .height('5%')
                .fontSize(30)
                .textAlign(TextAlign.Center)
            }
          }, (item: string) => item)

          ForEach(this.arrayB, (item: string) => {
            ListItem() {
              Text(item)
                .width('80%')
                .height('5%')
                .fontSize(30)
                .textAlign(TextAlign.Center)
            }
          }, (item: string) => item)

          ForEach(this.arrayC, (item: string) => {
            ListItem() {
              Text(item)
                .width('80%')
                .height('5%')
                .fontSize(30)
                .textAlign(TextAlign.Center)
            }
          }, (item: string) => item)

          ForEach(this.arrayJ, (item: string) => {
            ListItem() {
              Text(item)
                .width('80%')
                .height('5%')
                .fontSize(30)
                .textAlign(TextAlign.Center)
            }
          }, (item: string) => item)
        }
        .width('50%')
        .height('100%')

        Column() {
          Column() {
            AlphabetIndexer({ arrayValue: this.value, selected: 0 })
              .autoCollapse(this.isNeedAutoCollapse)// 开启或关闭自适应折叠模式
              .height(this.indexerHeight)// 索引条高度
              .enableHapticFeedback(false)// 关闭触控反馈
              .selectedColor(0xFFFFFF)// 选中项文本颜色
              .popupColor(0xFFFAF0)// 提示弹窗一级索引文本颜色
              .selectedBackgroundColor(0xCCCCCC)// 选中项背景颜色
              .popupBackground(0xD2B48C)// 提示弹窗背景颜色
              .usingPopup(true)// 索引项被选中时显示提示弹窗
              .selectedFont({ size: 16, weight: FontWeight.Bolder })// 选中项文本样式
              .popupFont({ size: 30, weight: FontWeight.Bolder })// 提示弹窗内容的文本样式
              .itemSize(28)// 每一项的尺寸大小
              .alignStyle(IndexerAlign.Right)// 提示弹窗在索引条左侧弹出
              .popupTitleBackground("#D2B48C")// 设置提示弹窗一级索引项背景颜色
              .popupSelectedColor(0x00FF00)// 提示弹窗二级索引未选中项文本颜色
              .popupUnselectedColor(0x0000FF)// 提示弹窗二级索引选中项文本颜色
              .popupItemFont({ size: 30, style: FontStyle.Normal })// 提示弹窗二级索引项文本样式
              .popupItemBackgroundColor(0xCCCCCC)// 提示弹窗二级索引项背景颜色
              .onSelect((index: number) => {
                console.info(this.value[index] + ' Selected!');
              })
              .onRequestPopupData((index: number) => {
                // 当选中A时，提示弹窗里面的二级索引文本列表显示A对应的列表arrayA，选中B、C、L时也同样
                // 选中其余索引项时，提示弹窗二级索引文本列表为空，提示弹窗会只显示一级索引项
                if (this.value[index] == 'A') {
                  return this.arrayA;
                } else if (this.value[index] == 'B') {
                  return this.arrayB;
                } else if (this.value[index] == 'C') {
                  return this.arrayC;
                } else if (this.value[index] == 'J') {
                  return this.arrayJ;
                } else {
                  return [];
                }
              })
              .onPopupSelect((index: number) => {
                console.info('onPopupSelected:' + index);
              })
          }
          .height('80%')
          .justifyContent(FlexAlign.Center)

          Column() {
            Button('切换成折叠模式')
              .margin('5vp')
              .onClick(() => {
                this.isNeedAutoCollapse = true;
              })
            Button('切换索引条高度到30%')
              .margin('5vp')
              .onClick(() => {
                this.indexerHeight = '30%';
              })
            Button('切换索引条高度到70%')
              .margin('5vp')
              .onClick(() => {
                this.indexerHeight = '70%';
              })
          }.height('20%')
        }
        .width('50%')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(720)
    }
  }
}
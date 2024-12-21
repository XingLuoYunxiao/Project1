import { Xiehouyu, XiehouyuPinMap } from "../../model/Xiehouyu";
import { util } from "@kit.ArkTS";
import { BasicDataSource } from "../../model/poetryModel/PoetryModel";
import { BuilderNameConstants, RouterModule } from "routermodule";
import { i18n } from "@kit.LocalizationKit";


function bufferToString(buffer: ArrayBufferLike): string {
  let textDecoder = util.TextDecoder.create('utf-8', {
    ignoreBOM: true
  });
  let resultPut = textDecoder.decodeToString(new Uint8Array(buffer), {
    stream: true
  });
  return resultPut;
}

@Component
export struct XiehouyuListPage {
  @State data: XiehouyuModel = new XiehouyuModel()
  @State pinMap: Map<string, number> = new Map<string, number>()
  private value: string[] = ['#', 'A', 'B', 'C', 'D', 'E', 'F', 'G',
    'H', 'I', 'J', 'K', 'L', 'M', 'N',
    'O', 'P', 'Q', 'R', 'S', 'T', 'U',
    'V', 'W', 'X', 'Y', 'Z']
  private scroller: ListScroller = new ListScroller()

  aboutToAppear(): void {
    console.log('XiehouyuListPage,aboutToAppear()')
    this.getArticleModelObjFromJSON()
  }

  // 提取汉字拼音的第一个字母
  getPinYinFirstChar(chinese: string): string {
    let transliterator = i18n.Transliterator.getInstance('Any-Latn');
    let res: string = transliterator.transform(chinese); // 第一个汉字的拼音

    let transliterator2 = i18n.Transliterator.getInstance('Latin-ASCII');
    let res2 = transliterator2.transform(res);

    // 获取拼音的第一个字母，并转为大写
    let firstLetter = res2 ? res2[0].toUpperCase() : '#';
    return /^[A-Z]$/.test(firstLetter) ? firstLetter : '#';
  }

  getArticleModelObjFromJSON() {
    getContext(this).resourceManager.getRawFileContent('xiehouyu.json').then(value => {
      let jsonObj = JSON.parse(bufferToString(value.buffer)) as Xiehouyu[];

      jsonObj.forEach((res: Xiehouyu, index: number) => {
        this.data?.pushData(res);

        // 获取谜面第一个汉字的拼音首字母
        // if (res.riddle && res.riddle.length > 0) {
        //   let pinFirstChar = this.getPinYinFirstChar(res.riddle[0]);
        //
        //   // 如果 map 中还没有这个拼音首字母，则添加进去，并设置对应的索引
        //   if (!this.pinMap.has(pinFirstChar)) {
        //     this.pinMap.set(pinFirstChar, index);
        //   }
        // }
      });
    });
  }

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.End }) {

        Column() {
          List({ space: 10, scroller: this.scroller }) {
            LazyForEach(this.data, (item: Xiehouyu) => {
              ListItem() {
                Row() {
                  Text(item.riddle)
                    .fontSize(16)
                  Text('——' + item.answer)
                    .fontSize(16)
                }
                .backgroundColor($r('app.color.main_background'))
                .width('100%')
                .padding(20)
                .borderRadius(20)

              }
            }, (item: Xiehouyu) => item.id.toString())
          }
          .edgeEffect(EdgeEffect.Spring)
          .cachedCount(20)
          .width('100%')
          .height('100%')
        }
        .width('100%')


        Column() {
          AlphabetIndexer({ arrayValue: this.value, selected: 0 })
            .autoCollapse(true)// 关闭自适应折叠模式
            .enableHapticFeedback(false)// 关闭触控反馈
            .selectedColor(0xFFFFFF)// 选中项文本颜色
            .popupColor(0xFFFAF0)// 提示弹窗一级索引文本颜色
            .selectedBackgroundColor(0xCCCCCC)// 选中项背景颜色
            .popupBackground(0xD2B48C)// 提示弹窗背景颜色
            .usingPopup(true)// 索引项被选中时显示提示弹窗
            .selectedFont({ size: 16, weight: FontWeight.Bolder })// 选中项文本样式
            .popupFont({ size: 30, weight: FontWeight.Bolder })// 提示弹窗一级索引的文本样式
            .itemSize(28)// 索引项的尺寸大小
            .alignStyle(IndexerAlign.Right)// 提示弹窗在索引条右侧弹出
            .popupItemBorderRadius(24)// 设置提示弹窗索引项背板圆角半径
            .itemBorderRadius(14)// 设置索引项背板圆角半径
            .popupBackgroundBlurStyle(BlurStyle.NONE)// 设置提示弹窗的背景模糊材质
            .popupTitleBackground(0xCCCCCC)// 设置提示弹窗一级索引项背景颜色
            .popupSelectedColor(0x00FF00)// 提示弹窗二级索引未选中项文本颜色
            .popupUnselectedColor(0x0000FF)// 提示弹窗二级索引选中项文本颜色
            .popupItemFont({ size: 30, style: FontStyle.Normal })// 提示弹窗二级索引项文本样式
            .popupItemBackgroundColor(0xCCCCCC)// 提示弹窗二级索引项背景颜色
            .onSelect((index: number) => {
              console.info(this.value[index] + ' Selected!')
              let firstIndex: number | undefined = XiehouyuPinMap.get(this.value[index])
              if (firstIndex) {
                this.scroller.scrollToIndex(firstIndex)
              }
              // this.pinMap.forEach((value, key) => {
              //   console.log(`Key: ${key}, Value: ${value}`);
              // });
            })
          // .onRequestPopupData((index: number) => {
          //   // 当选中A时，提示弹窗里面的二级索引文本列表显示A对应的列表arrayA，选中B、C、L时也同样
          //   // 选中其余索引项时，提示弹窗二级索引文本列表为空，提示弹窗会只显示一级索引项
          //
          // })
          // .onPopupSelect((index: number) => {
          //   console.info('onPopupSelected:' + index)
          // })
        }
        .height('80%')
        .justifyContent(FlexAlign.Center)

      }
      .width('100%')
      .height('100%')
    }

  }
}


class XiehouyuModel extends BasicDataSource<Xiehouyu> {
  data: Array<Xiehouyu> = []; // 诗歌数据数组

  // 获取指定索引的数据
  public getData(index: number): void | Xiehouyu {
    if (index === this.data.length - 1) {
    }
    return this.data[index];
  }
}


@Builder
export function XiehouyuListPageBuilder() {
  XiehouyuListPage()
}

const builderName = BuilderNameConstants.CULTURE_XIEHOUYULIST
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(XiehouyuListPageBuilder)
  RouterModule.registerBuilder(builderName, builder)
}




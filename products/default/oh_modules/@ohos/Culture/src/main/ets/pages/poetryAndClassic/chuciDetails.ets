import { BasicDataSource } from "../../model/poetryModel/PoetryModel";
import { cultureFileUtil } from "../../util/FileUtil";
import { AppreciateView } from "../../view/Appreciate";
import { TranslateView } from "../../view/Translate";

const TAG: string = 'details';

@Builder
export function chuciDetailsBuilder(name: string, param: Object) {
  details({ param: param as string });
}

@Component
export struct details {
  @State param: string = ''
  @State chuciList: Array<chuci> = [];

  aboutToAppear(): void {
    console.debug("这是details页面");

    getChuciData()
  }

  build() {
    NavDestination() {
      Column() {
        List({ space: 10 }) {
          LazyForEach(chuciData, (item: chuci, index: number) => {
            ListItem() {
              this.poetyrItem(item)
            }
          }, (item: chuci, index: number) => index.toString())
        }.cachedCount(10)
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
    }
    .hideTitleBar(true);
  }

  @Builder
  poetyrItem(item: chuci) {
    Column() {
      Text(item.title).poetryItemStyle()
      Row({ space: 10 }) {
        TranslateView({ importContent: item.content })
        AppreciateView({ importContent: item.content })
      }
      .margin({ top: 8, bottom: 8 })
      .width('100%')
      .justifyContent(FlexAlign.End)

      Text(item.author).poetryItemStyle()
        .margin(10)

      Text(item.content.toString()).poetryItemStyle()
    }
    .backgroundColor($r('app.color.poetryItem_background')) // 将背景色更改为和论语相同的背景颜色
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .borderRadius(20)
    .padding(12)
  }
}

@Extend(Text)
function poetryItemStyle() {
  .fontSize(24)
  .fontWeight(FontWeight.Medium)
}


class chuciModel extends BasicDataSource<chuci> {
  data: Array<chuci> = [];

  public getData(index: number): void | chuci {
    if (index === this.data.length - 1) {
      // 动态加载更多数据时调用
    }
    return this.data[index];
  }
}

const chuciData: chuciModel = new chuciModel();

async function getChuciData() {
  try {
    let chuciArr: chuci[] = await cultureFileUtil.getDataFromRawfile<chuci>('chuci.json');

    chuciArr.forEach(item => {
      chuciData.pushData(item);
    });
  } catch (error) {
    console.error("Error loading chuci data: ", error);
  }
}

interface chuci {
  title: string;
  section: string;
  author: string;
  content: string[];
}
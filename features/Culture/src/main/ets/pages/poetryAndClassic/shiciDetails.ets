import { BasicDataSource } from "../../model/poetryModel/PoetryModel";
import { cultureFileUtil } from "../../common/util/FileUtil";
import { AppreciateView } from "../../view/Appreciate";

import { TranslateView } from "../../view/Translate";

const TAG: string = 'shiciDetails';

@Builder
export function shiciDetailsBuilder(name: string, param: Object) {
  details({ param: param as string });
}


@Component
export struct details {
  @State param: string = ''
  @State shiciList: Array<shici> = [];

  aboutToAppear(): void {
    console.debug("这是 shici details 页面");

    // 加载诗词数据
    getShiciData()
  }

  build() {
    NavDestination() {
      Column() {
        List({ space: 10 }) {
          LazyForEach(shiciData, (item: shici, index: number) => {
            ListItem() {
              this.poetryItem(item)
            }
          }, (item: shici, index: number) => index.toString())
        }.cachedCount(10)
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
    }
    .hideTitleBar(true);
  }

  @Builder
  poetryItem(item: shici) {
    Column() {

      Text(item.title)
        .fontSize($r('app.float.poetry_title_fontSize'))
      Row({ space: 10 }) {
        TranslateView({ importContent: item.content })
        AppreciateView({ importContent: item.content })
      }
      .margin({ top: 8, bottom: 8 })
      .width('100%')
      .justifyContent(FlexAlign.End)

      Text(item.dynasty)
        .fontSize($r('app.float.poetry_fontSize'))
      Text(item.auth)
        .fontSize($r('app.float.poetry_fontSize'))
        .margin(10)
      Text(item.content.toString())
        .fontSize($r('app.float.poetry_fontSize'))
      //contentBuilder(item.content)
      //testOne()
      //testTwo()
    }
    .backgroundColor($r('app.color.poetryItem_background'))
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .borderRadius(20)
    .padding(12)
  }
}

@Builder
function contentBuilder(sentences: string[]) {
  Column() {
    Grid() {
      ForEach(sentences, (sentence: string, index: number) => {
        GridItem() {
          Text(sentence).fontSize(16)
        }
      }, (sentence: string, index: number) => index.toString())
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(8)
    .width('100%')
    .height('100%')
  }

}

class shiciModel extends BasicDataSource<shici> {
  data: Array<shici> = [];

  public getData(index: number): void | shici {
    if (index === this.data.length - 1) {
      // 可以在这里加载更多数据
    }
    return this.data[index];
  }
}

const shiciData: shiciModel = new shiciModel();

async function getShiciData() {
  try {
    let shiciArr: shici[] = await cultureFileUtil.getDataFromRawfile<shici>('shici.json');

    shiciArr.forEach(item => {
      shiciData.pushData(item);
    });
  } catch (error) {
    console.error("Error loading shici data: ", error);
  }
}

interface shici {
  title: string;
  dynasty: string;
  auth: string;
  content: string[];
}

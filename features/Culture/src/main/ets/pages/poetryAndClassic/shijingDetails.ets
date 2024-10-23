import { common } from "@kit.AbilityKit";
import { util } from "@kit.ArkTS";
import { BusinessError } from '@kit.BasicServicesKit';
import { BasicDataSource } from "../../model/poetryModel/poetryModel";
import { FileUtil } from "../../util/FileUtil";

const TAG: string = 'shijingDetails';

@Builder
export function shijingDetailsBuilder(name: string, param: Object) {
  details({ param: param as string });
}

@Component
export struct details {

  @State param: string = ''

  @State shijingList: Array<shijing> = [];

  aboutToAppear(): void {
    console.debug("这是 shijing details 页面");

    // 加载《诗经》数据
    getShijingData()
  }

  build() {
    NavDestination() {
      Column() {
        List({space: 10}) {
          LazyForEach(shijingData, (item: shijing, index: number) => {
            ListItem() {
              this.poetryItem(item)
            }
          }, (item: shijing, index: number) => index.toString())
        }.cachedCount(10)
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
    }
    .hideTitleBar(true);
  }

  @Builder
  poetryItem(item: shijing) {
    Column() {
      Text(item.title)
        .fontSize($r('app.float.poetry_title_fontSize'))
      Text(item.chapter)
        .fontSize($r('app.float.poetry_fontSize'))
      Text(item.section).margin(10)
        .fontSize($r('app.float.poetry_fontSize'))
      Text(item.content.toString())
        .fontSize($r('app.float.poetry_fontSize'))
    }
    .backgroundColor($r('app.color.poetryItem_background'))
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .borderRadius(20)
    .padding(12)
  }
}



class shijingModel extends BasicDataSource<shijing> {
  data: Array<shijing> = [];

  public getData(index: number): void | shijing {
    if (index === this.data.length - 1) {
      // 可以在这里加载更多数据
    }
    return this.data[index];
  }
}

const shijingData: shijingModel = new shijingModel();

async function getShijingData() {
  try {
    let shijingArr: shijing[] = await FileUtil.getDataFromRawfile<shijing>('shijing.json');

    shijingArr.forEach(item => {
      shijingData.pushData(item);
    });
  } catch (error) {
    console.error("Error loading shijing data: ", error);
  }
}
interface shijing {
  title: string;
  chapter: string;
  section: string;
  content: string[];
}

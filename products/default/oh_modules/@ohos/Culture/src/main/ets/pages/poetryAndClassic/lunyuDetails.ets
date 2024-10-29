import { BasicDataSource } from "../../model/poetryModel/PoetryModel";
import { cultureFileUtil } from "../../util/FileUtil";
import { TranslateView } from "../../view/Translate";

const TAG: string = 'lunyuDetails';

@Builder
export function lunyuDetailsBuilder(name?: string, param?: Object) {
  details({ param: param as string });
}

@Component
export struct details {
  @State param: string = ''
  @State lunyuList: Array<lunyu> = [];

  aboutToAppear(): void {
    console.debug("这是论语 details 页面");

    // 加载论语数据
    getLunyuData()
  }

  build() {
    NavDestination() {
      Text('论语').lunyuItemStyle()

      Column() {
        List({ space: 12 }) {
          LazyForEach(lunyuData, (item: lunyu, index: number) => {
            ListItem() {
              lunyuItem({ lunyu: item })
                .margin({ right: 15 })
            }
          }, (item: lunyu, index: number) => index.toString())
        }
        .cachedCount(10)

      }
      .backgroundColor($r('app.color.poetryItem_background'))
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .hideTitleBar(true);
  }
}


@Extend(Text)
function lunyuItemStyle() {
  .fontWeight(FontWeight.Medium)
}

class lunyuModel extends BasicDataSource<lunyu> {
  data: Array<lunyu> = [];

  public getData(index: number): void | lunyu {
    if (index === this.data.length - 1) {
      //getLunyuDataFromRawfile();
    }
    return this.data[index];
  }
}

const lunyuData: lunyuModel = new lunyuModel();

async function getLunyuData() {
  try {
    let lunyuArr: lunyu[] = await cultureFileUtil.getDataFromRawfile<lunyu>('lunyu.json');

    lunyuArr.forEach(item => {
      lunyuData.pushData(item);
    });
  } catch (error) {
    console.error("Error loading lunyu data: ", error);
  }
}

interface lunyu {
  chapter: string;
  paragraphs: string[];
}

@Component
struct lunyuItem {
  @State spread: boolean = false
  @Prop lunyu: lunyu
  spreadDuration: number = 2000
  closeTime: number = 300

  build() {

    Column({ space: 8 }) {
      Text(this.lunyu.chapter).lunyuItemStyle()
        .fontSize($r('app.float.poetry_title_fontSize'))


        .onClick(() => {
          this.spread = !this.spread
        })
      Column() {
        List() {
          ListItem() {
            Row({ space: 10 }) {
              TranslateView({ importContent: this.lunyu.paragraphs })
            }
            .margin({ top: 8, bottom: 8 })
            .width('100%')
            .justifyContent(FlexAlign.End)
          }

          ForEach(this.lunyu.paragraphs, (prgp: string) => {
            ListItem() {
              Text(prgp)
                .fontSize($r('app.float.poetry_fontSize'))
            }
          })
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
    .backgroundColor($r('app.color.poetry_background'))
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .margin({ left: 10, right: 10 })
    .borderRadius(20)
    .padding(10)

  }
}
import { BasicDataSource } from "../../model/poetryModel/PoetryModel";
import { cultureFileUtil } from "../../common/util/FileUtil";
import { TranslateView } from "../../view/Translate";

const TAG: string = 'mengziDetails';

@Builder
export function mengziDetailsBuilder(name?: string, param?: Object) {
  details({ param: param as string });
}

@Component
export struct details {
  @State param: string = ''
  @State mengziList: Array<mengzi> = [];

  aboutToAppear(): void {
    console.debug("这是孟子 details 页面");

    // 加载孟子数据
    getMengziData()
  }

  build() {
    NavDestination() {
      Text('孟子').lunyuItemStyle()

      Column() {
        List({ space: 12 }) {
          LazyForEach(mengziData, (item: mengzi, index: number) => {
            ListItem() {
              mengziItem({ mengzi: item })
                .margin({ right: 15 })
            }
          }, (item: mengzi, index: number) => index.toString())
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

class mengziModel extends BasicDataSource<mengzi> {
  data: Array<mengzi> = [];

  public getData(index: number): void | mengzi {
    if (index === this.data.length - 1) {
      //getMengziDataFromRawfile();
    }
    return this.data[index];
  }
}

const mengziData: mengziModel = new mengziModel();

async function getMengziData() {
  try {
    let mengziArr: mengzi[] = await cultureFileUtil.getDataFromRawfile<mengzi>('mengzi.json');

    mengziArr.forEach(item => {
      mengziData.pushData(item);
    });
  } catch (error) {
    console.error("Error loading mengzi data: ", error);
  }
}

interface mengzi {
  chapter: string;
  paragraphs: string[];
}

@Component
struct mengziItem {
  @State spread: boolean = false
  @Prop mengzi: mengzi
  spreadDuration: number = 2000
  closeTime: number = 300

  build() {

    Column({ space: 8 }) {

      Text(this.mengzi.chapter).lunyuItemStyle()
        .fontSize($r('app.float.poetry_title_fontSize'))


        .onClick(() => {
          this.spread = !this.spread
        })
      Column() {
        List() {
          ListItem() {
            Row({ space: 10 }) {
              TranslateView({ importContent: this.mengzi.paragraphs })
            }
            .margin({ top: 8, bottom: 8 })
            .width('100%')
            .justifyContent(FlexAlign.End)
          }

          ForEach(this.mengzi.paragraphs, (prgp: string) => {
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
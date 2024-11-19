import { realIdiom } from "../../model/Idiom/RealIdiom"

import { cloudDatabase } from "@kit.CloudFoundationKit"
import { getIdiomFormCloud } from "../../common/constants/CloundDb/getIdiomDataFormCloudDb"
import { deepCopy } from "../../util/deepCopy"
import { LogUtil } from "@ohos/Utils/src/main/ets/utils/puraUtils/LogUtil"
import { async } from "@hw-agconnect/cloud/src/main/ets/storage/upload/task"

@Builder
export function IdiomPageBuilder() {
  IdiomPage()
}

@Component
export struct IdiomPage {
  @State idiom: realIdiom | undefined = new realIdiom()
  @State changeValue: string = ''

  build() {

    NavDestination() {

      Column() {

        Search({ value: this.changeValue, placeholder: '搜你想搜的成语吧' })
          .searchButton('SEARCH')
          .width('95%')
          .height(40)
          .backgroundColor('#F5F5F5')
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 14, weight: 400 })
          .textFont({ size: 14, weight: 400 })
          .onSubmit(async (value: string) => {
            LogUtil.debug('点击了搜索事件')
            let temp: realIdiom | undefined = await getIdiomFormCloud.fetchIdiomByWord(value)
            if (temp) {
              this.idiom = deepCopy(temp) //深拷贝

              LogUtil.debug('获取成语：' + JSON.stringify(temp))
              LogUtil.debug('获取成语：' + JSON.stringify(this.idiom))
            } else {

            }

          })
          .onChange((value: string) => {
            this.changeValue = value
          })
          .margin(20)

        Row() {
          Column() {
            Row() {
              Text('随机一语')
              Image($r('app.media.ic_random'))
                .width(20)
            }.width('80%')
            .margin({ right: 25 })
            .justifyContent(FlexAlign.End)

          }
          .height(40)
          .onClick(async () => {
            let rand: number = Math.floor(Math.random() * (49000 - 1) + 1); //获取随机数，49000是成语在数据库的数量
            let temp: realIdiom | undefined = await getIdiomFormCloud.fetchIdiomById(rand)
            if (temp) {
              this.idiom = deepCopy(temp) //深拷贝
              LogUtil.debug('获取成语：' + JSON.stringify(temp))
              LogUtil.debug('获取成语：' + JSON.stringify(this.idiom))
            }
          })
        }
        .justifyContent(FlexAlign.End)
        .width('100%')

        realIdiomComp({ idiom: this.idiom })

      }
      .width('100%')
    }

  }
}

@Component
struct realIdiomComp {
  @Prop idiom: realIdiom

  build() {
    Scroll() {
      Column({ space: 20 }) {


        Text(this.idiom.data.pinyin)
          .fontSize($r('app.float.title_text_size'))
        Text(this.idiom.word)
          .generalize()

        Row() {
          Text('解释:')
            .generalize()

          Text(this.idiom.data.explanation)
            .fontSize($r('app.float.title_text_size'))
        }
        .padding({ right: 30 })
        .margin({ right: 40 })
        .width('80%')


        Row() {
          Text('出处:')
            .generalize()
          Text(this.idiom.data.sourceText)
            .fontSize($r('app.float.title_text_size'))
            .width('80%')
        }
        .padding({ right: 30 })
        .margin({ right: 40 })
        .width('80%')
        .justifyContent(FlexAlign.Start)

        Row() {
          Text("——" + this.idiom.data.sourceBook)
            .fontSize($r('app.float.title_text_size'))
        }
        .width('80%')
        .justifyContent(FlexAlign.End)

        if (this.idiom.data.exampleText !== '' && this.idiom.data.exampleText !== undefined) {
          Row() {
            Text('用例:')
              .generalize()

            Text(this.idiom.data.exampleText)
              .fontSize($r('app.float.title_text_size'))
          }
          .padding({ right: 30 })
          .margin({ right: 40 })
          .width('80%')
          .justifyContent(FlexAlign.Start)
        }


        Row() {
          Text("——" + this.idiom.data.exampleBook)
            .fontSize($r('app.float.title_text_size'))
        }
        .width('80%')
        .justifyContent(FlexAlign.End)

        if (this.idiom.data.story !== '' && this.idiom.data.story !== undefined) {
          Row() {
            Text('典故：')
              .generalize()
            Text(this.idiom.data.story)
              .fontSize($r('app.float.title_text_size'))
          }
          .padding({ right: 30 })
          .margin({ right: 40 })
          .width('80%')
          .justifyContent(FlexAlign.Start)

        }


      }
      .backgroundColor($r('app.color.main_background'))
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .padding(20)
      .borderRadius(20)
    }
    .padding(15)

  }
}

@Extend(Text)
function generalize() {
  .fontSize(24)
  .fontWeight(FontWeight.Medium)

}

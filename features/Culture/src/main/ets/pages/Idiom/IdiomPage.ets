import { realIdiom } from "../../model/Idiom/RealIdiom"
import { CloudIdiomService } from "../../service/CloudIdiomService"
import { deepCopy } from "../../common/util/deepCopy"
import { LogUtil } from "utils/src/main/ets/puraUtils/LogUtil"
import { addExp } from "../../common/util/addExp"
import { BuilderNameConstants, RouterModule } from "routermodule"
import { CommonConstants } from "../../common/constants/commonConstants"
import { promptAction } from "@kit.ArkUI"

let addEXPId: number = 0

@Component
export struct IdiomPage {
  @Prop value: object = new Object()
  @State idiom: realIdiom | undefined = new realIdiom()
  @State changeValue: string = ''

  aboutToAppear(): void {

    this.idiom = JSON.parse(JSON.stringify(this.value))
    //每10秒浏览页面加5经验
    addEXPId = setTimeout(() => {
      addExp(CommonConstants.expTypeKnowledge, 5)
    }, 10000)

  }

  aboutToDisappear(): void {
    // 退出页面时取消对经验值的添加
    clearTimeout(addEXPId)
  }

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
            let temp: realIdiom | undefined = await CloudIdiomService.fetchIdiomByWord(value)
            if (temp) {
              this.idiom = deepCopy(temp) //深拷贝

              LogUtil.debug('获取成语：' + JSON.stringify(temp))
              LogUtil.debug('获取成语：' + JSON.stringify(this.idiom))
            } else {
              LogUtil.debug('没有该成语哟')
              promptAction.showToast({
                message: "没有这个成语",
                duration: 2000
              })
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
            let temp: realIdiom | undefined = await CloudIdiomService.fetchIdiomById(rand)
            if (temp) {
              this.idiom = deepCopy(temp) //深拷贝
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
          Text('解释: ')
            .generalize()


          Text(this.idiom.data.explanation)
            .fontSize($r('app.float.title_text_size'))
        }
        .padding({ right: 20 })
        .margin({ right: 20 })
        .width('80%')

        if (this.idiom.data.sourceText) {
          Row() {
            Text('出处: ')
              .generalize()

            Text(this.idiom.data.sourceText)
              .fontSize($r('app.float.title_text_size'))
              .width('80%')
          }
          .padding({ right: 20 })
          .margin({ right: 20 })
          .width('80%')
          .justifyContent(FlexAlign.Start)


          Row() {
            Text("——" + this.idiom.data.sourceBook)
              .fontSize($r('app.float.title_text_size'))
          }
          .width('80%')
          .justifyContent(FlexAlign.End)
        }


        if (this.idiom.data.exampleText !== '' && this.idiom.data.exampleText !== undefined) {
          Row() {
            Text('用例: ')
              .generalize()

            Text(this.idiom.data.exampleText)
              .fontSize($r('app.float.title_text_size'))
          }
          .padding({ right: 20 })
          .margin({ right: 20 })
          .width('80%')
          .justifyContent(FlexAlign.Start)
        }

        if (this.idiom.data.exampleBook) {
          Row() {
            Text("——" + this.idiom.data.exampleBook)
              .fontSize($r('app.float.title_text_size'))
          }
          .width('80%')
          .justifyContent(FlexAlign.End)
        }


        if (this.idiom.data.story !== '' && this.idiom.data.story !== undefined) {
          Row() {
            Text('典故：')
              .generalize()
            Text(this.idiom.data.story)
              .fontSize($r('app.float.title_text_size'))
          }
          .padding({ right: 20 })
          .margin({ right: 20 })
          .width('80%')
          .justifyContent(FlexAlign.Start)
        }

      }
      .backgroundColor($r('app.color.main_background'))
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .padding(10)
      .borderRadius(20)
    }
    .padding(15)

  }
}

@Extend(Text)
function generalize() {
  .fontSize(24)
  .fontWeight(FontWeight.Medium)
  .margin({ left: 10 })
}

@Builder
export function IdiomPageBuilder(value: object) {
  IdiomPage({ value: value })
}

const builderName = BuilderNameConstants.CULTURE_IDIOM
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(IdiomPageBuilder)
  RouterModule.registerBuilder(builderName, builder)
}
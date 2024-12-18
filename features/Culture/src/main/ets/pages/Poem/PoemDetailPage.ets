import { BuilderNameConstants, RouterModule } from "routermodule"
import { CloudPoemService } from "../../service/CloudPoemService"
import { addExp } from "../../common/util/addExp"
import { Poem } from "../../model/Poem"
import { Writer } from "../../model/Writer"
import { CommonConstants } from '../../common/constants/commonConstants';
import { LogUtil } from "utils/src/main/ets/puraUtils/LogUtil"
import { talk } from "./talk"

let addEXPId: number = 0

@Component
export struct PoemDetailPage {
  @Prop poem: Poem = new Poem()
  @State value: object = new Object()
  @State writer: Writer = new Writer()

  async aboutToAppear(): Promise<void> {
    //LogUtil.debug("获取参数value：", JSON.stringify(this.value))
    this.poem = JSON.parse(JSON.stringify(this.value))
   // LogUtil.debug("当前的poem:" + JSON.stringify(this.poem))

    let poets: Writer[] | undefined = await CloudPoemService.fetchWriterData(this.poem.writer)
    if (poets) {
      this.writer = poets[0]
    }

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
      Scroll() {
        Column({ space: 12 }) {

          Row() {
            Image($r('app.media.ic_back'))
              .width(40)
              .onClick(() => {

              })

            talk({ poem: this.poem })

          }
          .margin({ top: 50 })
          .justifyContent(FlexAlign.Start)
          .width('100%')


          Row({ space: 10 }) {
            if (this.poem && this.poem.writer) {
              Text(this.poem.writer)
            }
            if (this.poem && this.poem.dynasty) {
              Text(this.poem.dynasty)
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)


          //正文
          if (this.poem && this.poem.title) {
            Text(this.poem.title)
              .fontWeight(FontWeight.Medium)
              .margin({ top: 20 })
          }

          //正文
          if (this.poem && this.poem.content) {
            Text(this.poem.content)
          }

          //注解
          if (this.poem && this.poem.remark) {
            Text(this.poem.remark)
          }

          //诗人简介
          Text('诗人简介')
            .fontSize($r('app.float.title_text_size'))
            .fontWeight(FontWeight.Medium)
            .margin({ top: 20 })
          if (this.writer) {
            Text(this.writer.simpleIntro)
          }

          Text('译文')
            .fontSize($r('app.float.title_text_size'))
            .fontWeight(FontWeight.Medium)
            .margin({ top: 20 })
          if (this.poem && this.poem.translation) {
            Text(this.poem.translation)
          }

          Text('赏析')
            .fontSize($r('app.float.title_text_size'))
            .fontWeight(FontWeight.Medium)
            .margin({ top: 20 })
          if (this.poem && this.poem.shangxi) {
            Text(this.poem.shangxi)
              .margin({ bottom: 10 })
          }


        }
        .alignItems(HorizontalAlign.Center)
        .width('100%')
        .backgroundColor('#fff5eee6')
        .padding(15)
      }

    }
    .hideTitleBar(true)

  }
}

@Builder
export function PoemDetailPageBuilder(params: object) {

  PoemDetailPage({ value: params })
}


const buildName = BuilderNameConstants.CULTURE_POEMDETAIL
if (!RouterModule.getBuilder(buildName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(PoemDetailPageBuilder)
  RouterModule.registerBuilder(buildName, builder)
}


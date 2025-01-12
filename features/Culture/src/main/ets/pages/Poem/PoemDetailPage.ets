import { BuilderNameConstants, RouterModule, RouterNameConstants } from "routermodule"
import { CloudPoemService } from "../../service/CloudPoemService"
import { addExp } from "../../common/util/addExp"
import { Poem } from "../../model/Poem"
import { Writer } from "../../model/Writer"
import { CommonConstants } from '../../common/constants/commonConstants';
import { httpToAI } from "../../common/util/httpUtil"
import { promptMap, PromptWords } from "../../model/promptWords"
import { lvMarkdownIn } from "@luvi/lv-markdown-in"
import { Header } from "../../view/poemDetail/Header"

let addEXPId: number = 0

@Component
export struct PoemDetailPage {
  @Prop poem: Poem = new Poem()
  @State value: object = new Object()
  @State writer: Writer = new Writer()
  @State AITranslation: string = ''
  @State AIShangxi: string = ''
  @State isGetAITranslation: boolean = false
  @State isGetAIAIShangxi: boolean = false
  //
  @State showTranslation: boolean = true
  @State showShangxi: boolean = true
  @State showRemark: boolean = true

  async aboutToAppear(): Promise<void> {
    this.poem = JSON.parse(JSON.stringify(this.value))
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


          Header({
            poem: this.poem,
            showTranslation: this.showTranslation,
            showShangxi: this.showShangxi,
            showRemark: this.showRemark
          })

          //诗人简介
          if (this.writer) {
            Row() {
              Text('诗人简介')
                .fontSize($r('app.float.title_text_size'))
                .fontWeight(FontWeight.Medium)
                .margin({ top: 20 })
            }.width('100%')
            .justifyContent(FlexAlign.Start)

            Text(this.writer.simpleIntro)
          }
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

          if (this.showRemark) {
            //注解
            if (this.poem && this.poem.remark) {
              Row() {
                Text('注解')
                  .fontSize($r('app.float.title_text_size'))
                  .fontWeight(FontWeight.Medium)
                  .margin({ top: 20 })
                  .align(Alignment.Start)
              }.width('100%')
              .justifyContent(FlexAlign.Start)

              Text(this.poem.remark)
            }
          }

          if (this.showTranslation) {
            //译文
            if (this.poem && this.poem.translation) {
              Row() {
                Text('译文')
                  .fontSize($r('app.float.title_text_size'))
                  .fontWeight(FontWeight.Medium)
                  .margin({ top: 20 })
              }
              .width('100%')
              .justifyContent(FlexAlign.Start)

              Text(this.poem.translation)
            } else {
              Text('获取AI译文')
                .fontSize($r('app.float.title_text_size'))
                .fontWeight(FontWeight.Medium)
                .margin({ top: 20 })
                .onClick(() => {
                  if (!this.isGetAITranslation) {
                    this.isGetAITranslation = true
                    httpToAI.askAI(this.poem.content, promptMap.get('译') as PromptWords, (chunk: string) => {
                      this.AITranslation += chunk
                    })
                  }

                }
                )
              if (this.isGetAITranslation === true && this.AITranslation === '') {
                LoadingProgress()
                  .width(50)
              } else {
                lvMarkdownIn({ text: this.AITranslation })
              }

            }
          }


          //赏析
          if (this.showShangxi) {
            if (this.poem && this.poem.shangxi) {
              Row() {
                Text('赏析')
                  .fontSize($r('app.float.title_text_size'))
                  .fontWeight(FontWeight.Medium)
                  .margin({ top: 20 })
              }
              .width('100%')
              .justifyContent(FlexAlign.Start)

              Text(this.poem.shangxi)
                .margin({ bottom: 10 })
            } else {
              Text('获取AI赏析')
                .fontSize($r('app.float.title_text_size'))
                .fontWeight(FontWeight.Medium)
                .margin({ top: 20 })
                .onClick(() => {
                  if (this.isGetAIAIShangxi === false) {
                    this.isGetAIAIShangxi = true
                    httpToAI.askAI(this.poem.content, promptMap.get('赏') as PromptWords, (chunk: string) => {
                      this.AIShangxi += chunk
                    })
                  }
                }
                )
              if (this.isGetAIAIShangxi === true) {
                if (this.AIShangxi === '') {
                  LoadingProgress()
                    .width(50)
                }
              }
              lvMarkdownIn({ text: this.AIShangxi })
            }
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


import { httpToAI } from "../util/httpUtil"
import { PromptWords, promptMap } from "../model/promptWords";
import { lvMarkdownIn, lvText } from "@luvi/lv-markdown-in";
import { ttf } from "../util/ttf";
import { Lottie, LottieController } from "@jjr/lottie_component";

// @Preview
@Component
export struct baseFuncViewComponent {
  @Prop importContent: string[]
  @State isShow: boolean = false
  @State responseText: string = ''
  @Prop funcView: PromptWords
  // 从 rawfile 资源文件夹加载 json data
  @State animationData?: Object = undefined
  private artController: LottieController = new LottieController()

  async aboutToAppear() {
    lvText.setTextSize(16)
    ttf('STXINGKAFont', 'STXINGKA.TTF')
    this.animationData = await LottieController.getRawFileAnimationData(getContext(this), 'waiting.json')

  }

  build() {
    Column() {
      Text(this.funcView.text)
        .fontSize(20)
        .borderRadius(100)
        .borderWidth(1.5)
        .onClick(() => {
          this.isShow = !this.isShow

        })
        .bindSheet($$this.isShow, this.detail(this.funcView.fulltext), {
          height: 600,
          showClose: true,
          onWillAppear: () => {
            if (this.responseText === '') {
              httpToAI.askAI(JSON.stringify(this.importContent), promptMap.get(this.funcView.text), (chunk: string) => {
                this.responseText += chunk
              })
            }
          }
        })

    }
  }

  @Builder
  detail(text: string) {
    Column() {
      Text(text)
        .fontSize(36)

      Scroll() {
        Column() {
          if (this.responseText === '') {
            Lottie({
              animationData: this.animationData,
              autoPlay: true,
              loop: true,
              controller: this.artController,
              contentMode: "Cover"
            })
              .width(120)
              .height(100)
              .margin(10)
          } else {
            lvMarkdownIn({ text: this.responseText })
          }


        }
        .height(550)
        .width('100%')
      }
      .backgroundColor($r('app.color.baseFuncView_detail_background'))
      .edgeEffect(EdgeEffect.Spring)
      .scrollable(ScrollDirection.Vertical)
    }
    .backgroundColor($r('app.color.baseFuncView_detail_background'))

  }
}


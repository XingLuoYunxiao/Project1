import { httpToAI } from "../util/httpUtil"
import { PromptWords,promptMap } from "../model/promptWords";
import { lvMarkdownIn, lvText } from "@luvi/lv-markdown-in";

// @Preview
@Component
export struct baseFuncViewComponent{

  aboutToAppear(): void {
    lvText.setTextSize(16)
  }

  @Prop importContent:string[]
  @State isShow:boolean =false
  @State responseText:string =''

  @Prop funcView:PromptWords
  build() {
    Column(){
      Text(this.funcView.text)
        .fontSize(20)
        .borderRadius(100)
        .borderWidth(1.5)
        .onClick(()=>{
          this.isShow =!this.isShow

        })
        .bindSheet($$this.isShow,this.detail(this.funcView.fulltext),{
          height:600,
          showClose:true,
          onWillAppear: ()=>{
            if(this.responseText ==='')
              httpToAI.askAI(JSON.stringify(this.importContent),promptMap.get(this.funcView.text),(chunk: string)=>{
                this.responseText +=chunk
              })
          }
        })

    }
  }

  @Builder
  detail(text:string){
    Column(){
      Text(text)
        .fontSize(36)

      Scroll(){
        Column(){
          lvMarkdownIn({ text: this.responseText })
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


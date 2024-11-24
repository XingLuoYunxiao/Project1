import { BuilderNameConstants, RouterModule } from "routermodule"
import Constants from "../common/constants/Constants"

const question:string[]=['如何退款','在哪里领取优惠券','大唐芙蓉园什么时间段可以预约','查看更多']
@Preview
@Component
//客服
export struct CusServicePage {
  @State curtalk:string=''
  @State QuesItemList:string[] = []
  @Consume('appPathStack') appPathStack: NavPathStack
  wordLibrary: Set<string> = new Set(['退款', '预约', '优惠券']);
  answers:Set<string> = new Set(['好的,已帮您退款', '预约', '优惠券在首页右上角']);
  checkSentence(sentence: string): string {
    const processedSentence = sentence.replace(/[\p{P}\p{S}]/gu, '');
    for (const word of this.wordLibrary) {
      if (processedSentence.includes(word)) {
        for (const answer of this.answers) {
          if(answer.includes(word)){
            return answer;
          }
        }
      }
    }
    return '';
  }

  build() {
  NavDestination(){
    Column(){
      Row(){
        Image($r('app.media.ic_back')).width($r('app.float.md_topic_width')).onClick(()=>{
          this.appPathStack.pop()
        })
        Image($r('app.media.defaultphoto')).width(50)
        Column(){
          Text('古韵游踪客服')
            .fontSize(16)
            .fontWeight(700)
          Text('提供专业服务')
            .fontSize(12)
        }
      }
      .width('100%')
      .height(Constants.TOP_HEIGHT_PAGE)
      .justifyContent(FlexAlign.Start)
      .margin({bottom:15})
      Text('Hi,古古很高兴为您服务').fontSize(16)
        .backgroundColor($r('app.color.dialog_background_blue'))
        .borderRadius($r('app.float.small_border_radius'))
        .padding($r('app.float.md_padding_margin'))
        .margin({bottom:10})
      Column(){
        Text('猜你想问')
          .fontSize(20)
          .margin({bottom:10})
          .fontWeight(500)
        List({space:Constants.SMALL_SPACE}){
          ForEach(question,(ques:string,inx)=>{
            ListItem(){
              Row(){
                Text(ques)
                Blank()
                Image($r('app.media.ic_arrow')).width(15)
              }.onClick(()=>{
                this.QuesItemList.push(ques)
              })
            }
          })
        }
        .width(260)
        .height(120)
      }
      .padding($r('app.float.md_padding_margin'))
      .borderRadius($r('app.float.small_border_radius'))
      .backgroundColor($r('app.color.dialog_background_blue'))
      .alignItems(HorizontalAlign.Start)

      List(){
        ForEach(this.QuesItemList,(quesitem:string)=>{
            ListItem(){
                Column(){
                  Row(){
                    Text(quesitem)
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.End)
                  Row(){
                    if(this.checkSentence(quesitem)){
                      Text(this.checkSentence(quesitem))
                    }else{
                      Text('为匹配更合适的客服解决您的问题,请选择您要咨询的业务~')

                    }
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.Start)
                }
            }
        })
      }
      .backgroundColor($r('app.color.dialog_background_yellow'))
      Row({ space: 10 }) {
        TextArea({ placeholder: '请简单描述您的问题', text: this.curtalk })
          .fontSize(16)
          .width('80%')
          .onChange((val) => {
            this.curtalk = val
          })

        Button('发送')
          .backgroundColor($r('app.color.link_blue'))
          .fontColor(Color.White)
          .width('20%')
          .onClick(() => {
            if (this.curtalk.length > 0) {
              this.QuesItemList.push(this.curtalk)
              this.curtalk = ''
            }
          })
      }
      .backgroundColor("#f1f1f1")
      .padding({ bottom: 20 })
      .width('100%')
      .height(80)
    }
    .padding({left:Constants.PADDING_PAGE,right:Constants.PADDING_PAGE,top:Constants.PADDING_PAGE})
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.app_background_color'))
  }
  .margin({top:Constants.HEADER_HEIGHT_PAGE})
  .hideTitleBar(true)
  }
}

@Builder
export function CusServicePageBuilder() {
  CusServicePage()
}

const builderName = BuilderNameConstants.LOGIN_CUSSERVICEPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(CusServicePageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
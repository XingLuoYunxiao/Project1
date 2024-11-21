import { BuilderNameConstants, RouterModule } from "routermodule"

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
        Image($r('app.media.ic_back')).width(30).onClick(()=>{
          this.appPathStack.pop()
        })
        Image($r('app.media.miaosha')).width(50)
        Column(){
          Text('ICT客服')
          Text('提供专业服务')
        }
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')
      Text('Hi,II很高兴为您服务').width('100%').padding({left:120})
      Text('猜你想问')
      List(){
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
      .margin({left:20})
      .width(260)
      .height(200)
      .backgroundColor($r('app.color.white'))

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
      Row({ space: 20 }) {
        TextArea({ placeholder: '请简单描述您的问题', text: this.curtalk })
          .fontSize(16)
          .width(300)
          .position({ left: '2%', bottom: 0 })
          .onChange((val) => {
            this.curtalk = val
          })

        Button('发送')
          .backgroundColor(Color.Yellow)
          .fontColor(Color.White)
          .position({ bottom: 0, right: '2%' })
          .onClick(() => {
            if (this.curtalk.length > 0) {
              this.QuesItemList.push(this.curtalk)
              this.curtalk = ''
              // inputMethod.getController().stopInputSession()
            }
          })

      }
      .backgroundColor("#f1f1f1")
      .padding({ bottom: 20 })
      .width('100%')
      .height(80)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.app_background_color'))
  }
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
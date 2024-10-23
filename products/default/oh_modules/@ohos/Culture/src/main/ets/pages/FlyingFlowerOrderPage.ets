import { ChatI } from '../model/ChatI'
import { inputMethod } from '@kit.IMEKit'
import { font } from '@kit.ArkUI'
import { ttf } from '../util/ttf'

@Component
export struct FlyingFlowerOrderPage {
  @State isListNull: boolean = true
  @State ChatItemList: ChatI[] =
    [new ChatI('我们来玩飞花令吧！\n我来第一句！\n花近高楼伤客心', 1), new ChatI('落花时节又逢君', 0),
      new ChatI('春江花朝秋月夜', 1)]
  @State InputMessage: string = ''
  @Consume('travelPathStack') travelPathStack: NavPathStack;

  aboutToAppear(): void {
    if (this.ChatItemList.length > 0) {
      this.isListNull = false
      console.log('testlog' + this.ChatItemList.length)
    }
    let inputMethodController = inputMethod.getController();
    ttf('STXINGKAFont', 'STXINGKA.TTF')


  }

  build() {
    NavDestination(){
      Column() {

        Row() {
          Text('飞花令')
            .fontSize(55)
            .fontFamily('STXINGKAFont')
            .letterSpacing(15)
        }
        .justifyContent(FlexAlign.Center)
        .height(100)
        .width('100%')
        .margin({ bottom: 20 })
        .backgroundColor("#f1f1f1")
        .expandSafeArea([SafeAreaType.KEYBOARD])
        .zIndex(999)
        .layoutWeight(1)

        Text('输入开始飞花令来跟AI进行诗词储量比拼吧!')
          .fontSize(16)
          .fontColor(Color.Gray)
          .visibility(this.isListNull ? Visibility.Visible : Visibility.None)
          .expandSafeArea([SafeAreaType.KEYBOARD])
          .zIndex(999)
        List() {
          ForEach(this.ChatItemList, (item: ChatI) => {
            if (item.id == 0) {
              ListItem() {
                Row({ space: 15 }) {
                  Image($r('app.media.avatar1'))
                    .size({ height: 50, width: 50 })
                  Text(item.message)
                    .fontSize(21)
                    .backgroundColor('rgba(207, 207, 207, 0.44)')
                    .lineHeight(25)
                    .borderRadius(5)

                }
                .width('100%')
                .justifyContent(FlexAlign.Start)
              }
              .margin({ bottom: 20, left: 15 })

            } else {
              ListItem() {
                Row({ space: 15 }) {
                  Text(item.message)
                    .fontSize(21)
                    .backgroundColor('rgba(42, 134, 255, 0.69)')
                    .lineHeight(25)
                    .borderRadius(5)
                  Image($r('app.media.avatar2'))
                    .size({ height: 50, width: 50 })
                }.padding({ left: 15 })
                .width('95%')
                .justifyContent(FlexAlign.End)
              }
              .margin({ bottom: 20 })

            }
          })
        }.width('100%')
        .layoutWeight(2)
        .height(500)
        .width('100%')


        Row({ space: 20 }) {
          TextArea({ placeholder: 'Ask me anything...', text: this.InputMessage })
            .fontSize(16)
            .width(300)
            .position({ left: '2%', bottom: 0 })
            .onChange((val) => {
              this.InputMessage = val
            })

          Button('发送')
            .backgroundColor('#00bd12')
            .fontColor(Color.White)
            .position({ bottom: 0, right: '2%' })
            .onClick(() => {
              if (this.InputMessage.length > 0) {
                this.ChatItemList.push(new ChatI(this.InputMessage, 1))
                this.InputMessage = ''
                inputMethod.getController().stopInputSession()
              }
            })

        }
        .backgroundColor("#f1f1f1")
        .padding({ bottom: 20 })
        .width('100%')
        .height(80)

      }
    }
    .height('100%')
    .width('100%')
  }
}
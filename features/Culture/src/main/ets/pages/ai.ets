import { LogUtil } from "utils/src/main/ets/puraUtils/LogUtil";
import { ResponseParams, TalkTo_XUNFEI_AI } from "../api/chat";
import { httpToAI } from "../common/util/httpUtil";
import { AIMsg, ChatMsg, ROLE } from "../model/ChatMassageModel";
import { MessageComponent } from "../view/MessageComponent";
import { ChatMsgModel } from "../viewmodel/MessageViewModel";

@Component
export struct TalkToAI {
  @State inputText: string = ''; // 输入框的文本状态
  controller: TextInputController = new TextInputController(); // 控制输入框的控制器
  @State sid: string = ''
  @State MessageDataModel: ChatMsgModel = new ChatMsgModel();

  aboutToAppear(): void {
    let msg: AIMsg = new AIMsg(ROLE.user, "你是一个非常厉害的汉学家，精通中华文化,回答我接下来的问题");
    TalkTo_XUNFEI_AI(msg).then((value: ResponseParams) => {
      console.log(value.choices[0].message.content);
      this.sid = value.sid
    }).catch((error: Error) => {
      console.error(error.name, error.message);
    });
  }

  handleMsg(msg: string) {
    let Msg: AIMsg = new AIMsg(ROLE.user, msg, this.sid)
    TalkTo_XUNFEI_AI(Msg).then((value: ResponseParams) => {
      console.log(value.choices[0].message.content);
      this.sid = value.sid
      this.MessageDataModel.pushData(new ChatMsg(ROLE.assistant, value.choices[0].message.content))
    }).catch((error: Error) => {
      console.error(error.name, error.message);
    });
  }

  build() {
    NavDestination() {
      Column() {
        Column() {
          // 聊天页面
          List({ space: 10 }) {
            LazyForEach(this.MessageDataModel, (item: ChatMsg) => {
              ListItem() {
                MessageComponent({ role: item.role, content: item.content });
              }
            });
          }
          .cachedCount(20);
        }
        .height('80%')

        Row() { // 输入框和发送按钮的行布局
          TextInput({
            controller: this.controller,
            text: this.inputText
          })
            .width('80%')
            .height(40)
            .margin(20)
            .fontSize(14)
            .fontColor(Color.Black)
            .enterKeyType(EnterKeyType.Send)// 设置回车键类型为发送
            .onChange((value: string) => {
              this.inputText = value; // 更新输入框文本
            })
            .onSubmit(async (enterKey: EnterKeyType, event: SubmitEvent) => {
              let tempText = this.inputText;
              this.inputText = '';
              this.MessageDataModel.pushData(new ChatMsg(ROLE.user, tempText)); //输入到聊天界面

              this.handleMsg(tempText)
            });
        }
        .width('100%')
        .margin({ bottom: 40 })
        .padding(10)
      }
      .height('100%')
      .justifyContent(FlexAlign.Center)

    }

  }
}


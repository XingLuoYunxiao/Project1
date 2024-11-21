import { ZhiPuImage2 } from "../../api/ApiService"; // 导入生成图片的 API 服务
import { ChatMessageType, ChatMsgModel } from "../../model/AIChatListModel"; // 导入聊天消息类型和模型
import { MessageType } from "@hw-agconnect/cloud/src/main/ets/database/sync/utils/MessageType"; // 导入消息类型定义

@Builder
export function AIPaintingPageBuilder(name: string, param: Object) {
  AIPaintingPage(); // 创建 AIPaintingPage 组件
}

@Component
export struct AIPaintingPage {
  @State inputText: string = ''; // 输入框的文本状态
  controller: TextInputController = new TextInputController(); // 控制输入框的控制器
  @State showImage: boolean = false; // 控制图片显示的状态
  @State ImageUrl: string = ''; // 存储生成的图片 URL
  @State chatList: ChatMsgModel[] = []; // 存储聊天消息的列表

  build() {
    NavDestination() {
      Column() { // 主列布局
        List({ space: 12 }) { // 聊天消息列表
          ForEach(this.chatList, (item: ChatMsgModel, index) => {
            ListItem() {
              this.messageBuilder(item); // 渲染每一条消息
            }
          }, (item: ChatMsgModel, index: number) => index.toString());
        }
        .width('100%')
        .height('80%');

        Blank(); // 空白占位符

        Row() { // 输入框和发送按钮的行布局
          TextInput({ controller: this.controller, text: this.inputText })
            .width('80%')
            .height(60)
            .margin(20)
            .fontSize(14)
            .fontColor(Color.Black)
            .enterKeyType(EnterKeyType.Send)// 设置回车键类型为发送
            .onChange((value: string) => {
              this.inputText = value; // 更新输入框文本
            })
            .onSubmit(async (enterKey: EnterKeyType, event: SubmitEvent) => {
              console.log("trigger richeditor onsubmit" + enterKey);
              let tempText = this.inputText
              this.inputText = ''
              if (tempText !== '') {
                // 添加用户消息
                this.chatList.push(new ChatMsgModel("user", tempText, ChatMessageType.Text));
                // 调用 API 生成图片
                this.ImageUrl = await ZhiPuImage2(tempText);

                if (this.ImageUrl !== '') {
                  // 添加系统消息（图片）
                  this.chatList.push(new ChatMsgModel("system", this.ImageUrl, ChatMessageType.Image));
                  this.showImage = !this.showImage; // 切换图片显示状态
                }

              }
              this.inputText = ''; // 确保输入框清空
            });
        }
        .width('100%')
        .margin({ bottom: 40 })
        .padding(10);
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceBetween) // 组件间距
      .margin({ top: 20, bottom: 20 });
    }
    .hideTitleBar(true); // 隐藏标题栏
  }

  @Builder
  messageBuilder(item: ChatMsgModel) {
    Column({ space: 10 }) { // 消息列布局
      // 头像和用户名
      Row() {
        Image(item.authorImage)// 用户头像
          .height(30)
          .width(30)
          .borderRadius(100)// 头像圆形
          .alt('');
        Text(item.author); // 用户名
      }
      .justifyContent(FlexAlign.Start); // 左对齐

      // 消息内容
      Column() {
        if (item.messageType === ChatMessageType.Text) {
          // 文本消息
          Text(item.message)
            .borderRadius(25)
            .backgroundColor('#ff71e7d9')// 设置背景色
            .padding({
              top: 8,
              bottom: 8,
              left: 12,
              right: 12
            });
        } else {
          // 图片消息
          Image(item.message)
            .width(280); // 设置图片宽度
        }
      }
      .margin({ left: 35 }); // 左侧边距
    }
    .alignItems(HorizontalAlign.Start) // 左对齐
    .width('100%'); // 宽度占满
  }
}

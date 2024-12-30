import { ChatMessageType, ChatMsg, ROLE } from "../../model/ChatMassageModel"; // 导入聊天消息类型和模型
import { MessageType } from "@hw-agconnect/cloud/src/main/ets/database/sync/utils/MessageType"; // 导入消息类型定义
import { BuilderNameConstants, RouterModule } from "routermodule";
import { MessageComponent } from "../../view/MessageComponent";
import { LogUtil } from "utils/src/main/ets/puraUtils/LogUtil";
import { ChatMsgModel } from "../../viewmodel/MessageViewModel";
import { CreateImage } from "../../common/util/createImage";
import { AIPaintingPromptMap } from "../../model/promptWords";


@Component
export struct AIPaintingPage {
  @State inputText: string = ''; // 输入框的文本状态
  @State MessageDataModel: ChatMsgModel = new ChatMsgModel();
  controller: TextInputController = new TextInputController(); // 控制输入框的控制器
  @State showImage: boolean = false; // 控制图片显示的状态
  @State ImageUrl: string = ''; // 存储生成的图片 URL
  @State chatList: ChatMsg[] = []; // 存储聊天消息的列表
  @State preViewPicture: ResourceStr = $r('app.media.beforeCreate')
  @State searchLabel: string = "水墨画"
  @State index: number = 0
  @State arrowPosition: ArrowPosition = ArrowPosition.END
  private scroller: ListScroller = new ListScroller()

  async createImage(view: string) {
    let s = AIPaintingPromptMap.get(this.searchLabel)
    let url: string = await CreateImage.ZhiPuImage("“请创作一幅" + this.searchLabel +
      "风格的画作，描绘" + view + ",运用" + AIPaintingPromptMap.get(this.searchLabel))
    this.MessageDataModel.pushData(new ChatMsg(ROLE.system, url, ChatMessageType.Image)); //输入到聊天界面
    this.scroller.scrollBy(0, 400)
  }

  build() {
    NavDestination() {
      Column() {

        Column() {
          // 聊天页面
          List({ space: 10, scroller: this.scroller }) {
            LazyForEach(this.MessageDataModel, (item: ChatMsg) => {
              ListItem() {
                MessageComponent({
                  role: item.role,
                  roleHeadImg: item.roleHeadImg,
                  msg: item.message,
                  msgType: item.messageType
                })
              }
            })
          }
          .width('100%')
          .height('80%')
          .padding(10)
          .cachedCount(20);
        }

        Column() {
          Row() {
            Select([
              { value: '水墨画' },
              { value: '写意画' },
              { value: '工笔画' },
              { value: '青绿山水' },
              { value: '白描画' },
              { value: '没骨画' },
              { value: '文人画' },
            ])
              .selected(this.index)
              .value(this.searchLabel)
              .font({ size: 16, weight: 500 })
              .fontColor('#182431')
              .selectedOptionFont({ size: 16, weight: 400 })
              .optionFont({ size: 16, weight: 400 })
              .arrowPosition(this.arrowPosition)
              .menuAlign(MenuAlignType.START, { dx: 0, dy: 0 })
              .optionWidth(200)
              .optionHeight(300)
              .onSelect((index: number, text?: string | undefined) => {
                console.info('Select:' + index)
                this.index = index;
                if (text) {
                  this.searchLabel = text;
                }
              })
          }
          .width('80%')
          .justifyContent(FlexAlign.Start)

          Row() { // 输入框和发送按钮的行布局
            TextInput({
              controller: this.controller,
              text: this.inputText,
              placeholder: "快来输入你想要绘画的画面吧"
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
                LogUtil.debug("触发输入框提交: " + enterKey);
                let tempText = this.inputText;
                this.inputText = '';
                this.MessageDataModel.pushData(new ChatMsg(ROLE.user, tempText)); //输入到聊天界面
                this.scroller.scrollBy(0, 20)
                this.createImage(tempText)
              });
          }

        }
        .margin({ bottom: 40 })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .height('100%')
      .width('100%')
    }

  }
}

@Builder
export function AIPaintingPageBuilder() {
  AIPaintingPage();
}

const builderName = BuilderNameConstants.CULTURE_AIPainting
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(AIPaintingPageBuilder)
  RouterModule.registerBuilder(builderName, builder)
}

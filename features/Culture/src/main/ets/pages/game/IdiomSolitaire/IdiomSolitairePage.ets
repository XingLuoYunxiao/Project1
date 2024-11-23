import { LogUtil } from "utils/src/main/ets/puraUtils/LogUtil";
import { CloudIdiomService } from "../../../service/CloudIdiomService";
import { ChatMsg, ROLE } from "../../../model/ChatMassageModel";
import { realIdiom } from "../../../model/Idiom/RealIdiom";
import { MessageComponent } from "../../../view/MessageComponent";
import { ChatMsgModel } from "../../../viewmodel/MessageViewModel";
import { BuilderNameConstants, RouterModule } from "routermodule";
import { GameRuleDialog } from "../../../view/Dialog/gameRuleDialog";
import { GameOverDialog } from "../../../view/IdiomSolitaire/GameOver";


const TAG: string = 'IdiomSolitaire.ets ';
let MessageDataModel: ChatMsgModel = new ChatMsgModel();

@Component
export struct IdiomSolitairePage {
  @State inputText: string = ''; // 输入框的文本状态
  controller: TextInputController = new TextInputController(); // 控制输入框的控制器
  @State showImage: boolean = false; // 控制图片显示的状态
  @State IdiomList: realIdiom[] = []; // 存储接龙成语的的列表
  @State lastChar: string = ''; // 当前接龙的汉字
  textTimerController: TextTimerController = new TextTimerController();
  @State format: string = 'mm:ss.SS';
  @State isCountDown: boolean = true;
  dialogController: CustomDialogController = new CustomDialogController({
    builder: GameRuleDialog({ str: $r('app.string.IdiomSolitaireRule') }),
  })
  GameOverDialogController: CustomDialogController = new CustomDialogController({
    builder: GameOverDialog({
      count: this.IdiomList.length / 2,
      regame: this.resetGame,
      cancel: () => {
      }

    }),
  })

  resetGame() {
    // 清空成语列表
    this.IdiomList = [];
    // 清空最后一个字
    this.lastChar = '';
    // 重置计时器
    this.textTimerController.reset();

    MessageDataModel.data.length === 0


  }

  async aboutToAppear(): Promise<void> {
    LogUtil.info(TAG, '这是成语接龙页面')
    if (MessageDataModel.data.length === 0) {
      try {
        let temp: realIdiom | undefined = await CloudIdiomService.fetchIdiomByRandom();
        if (temp) {
          this.IdiomList.push(temp);
          this.lastChar = temp.word[temp.word.length - 1];
          MessageDataModel.pushData(new ChatMsg(ROLE.IdiomSystem, temp.word));
        }
      } catch (error) {
        console.error("初始化成语失败:", error.message);
      }
    }

    this.textTimerController.start()
  }

  build() {
    NavDestination() {
      Column() {
        Column() {

          Row() {

            Text('游戏规则')
              .fontSize($r('app.float.title_text_size'))
              .onClick(() => {
                this.dialogController.open()
              })

            Text('当前接龙汉字：' + this.lastChar)
              .fontSize($r('app.float.title_text_size'))
            // 计时器
            TextTimer({ controller: this.textTimerController, isCountDown: this.isCountDown, count: 20000 })
              .format(this.format)
              .fontColor(Color.Black)
              .fontSize(24)
              .onTimer((utc: number, elapsedTime: number) => {
                LogUtil.info(`textTimer notCountDown utc is：${utc}, elapsedTime: ${elapsedTime}`);
                if (elapsedTime === 2000) {
                  this.GameOverDialogController.open()
                }
              })

          }
          .height(50)
          .width('100%')
          .justifyContent(FlexAlign.SpaceAround)

          // 聊天页面
          List({ space: 10 }) {
            LazyForEach(MessageDataModel, (item: ChatMsg) => {
              ListItem() {
                MessageComponent({ role: item.role, roleHeadImg: item.roleHeadImg, msg: item.message });
              }
            });
          }
          .cachedCount(20);
        }.height('80%')


        Row() { // 输入框和发送按钮的行布局
          TextInput({
            controller: this.controller,
            text: this.inputText
          })
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
              LogUtil.debug(TAG, "触发输入框提交: " + enterKey);
              let tempText = this.inputText;
              this.inputText = '';
              MessageDataModel.pushData(new ChatMsg(ROLE.user, tempText));
              this.isValue(tempText);
            });
        }
        .width('100%')
        .margin({ bottom: 40 })
        .padding(10)

      }
      .margin($r('app.float.header_height_page'))
      .justifyContent(FlexAlign.SpaceBetween)

    }
    .hideTitleBar(true); // 隐藏标题栏
  }

  async systemAddIdiom() {
    try {
      let temp: realIdiom | undefined = await CloudIdiomService.fetchIdiomByFirstChar(this.lastChar);
      if (temp) {
        this.IdiomList.push(temp);
        this.lastChar = temp.word[temp.word.length - 1];
        MessageDataModel.pushData(new ChatMsg(ROLE.IdiomSystem, temp.word));

      }
    } catch (error) {
      console.error("系统添加成语失败:", error.message);
    }
  }

  isValue(idiom: string) {
    if (idiom !== '') {
      if (idiom.length !== 4) {
        MessageDataModel.pushData(new ChatMsg(ROLE.IdiomSystem, "只接受4字成语哟"));
        return;
      }

      if (idiom[0] !== this.lastChar) {
        MessageDataModel.pushData(new ChatMsg(ROLE.IdiomSystem, `你首字的“${this.lastChar}”呢？`));
        return;
      }

      CloudIdiomService.isIdiom(idiom).then(isIdiom => {
        if (isIdiom) {
          this.lastChar = idiom[3];

          this.textTimerController.reset()

          this.systemAddIdiom();

        } else {
          console.log("这不是一个成语");
          MessageDataModel.pushData(new ChatMsg(ROLE.IdiomSystem, "这不是一个成语"));
        }
      }).catch((error: Error) => {
        console.error("检查成语失败:", error.message);
        MessageDataModel.pushData(new ChatMsg(ROLE.IdiomSystem, "系统出错，请稍后再试"));
      });
    }
  }

  aboutToDisappear(): void {
    LogUtil.info(TAG, '退出成语接龙页面');

    // 清理状态和资源
    this.textTimerController.reset();
    this.dialogController.close();
    this.GameOverDialogController.close();
    MessageDataModel.data = []
  }
}

@Builder
export function IdiomSolitaireBuilder() {
  IdiomSolitairePage()
}

const builderName = BuilderNameConstants.CULTURE_IdiomSolitaire
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(IdiomSolitaireBuilder)
  RouterModule.registerBuilder(builderName, builder)
}
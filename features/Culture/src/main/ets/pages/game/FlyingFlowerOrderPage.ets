import { Poem } from "../../model/Poem";
import { LogUtil } from "utils/src/main/ets/puraUtils/LogUtil";
import { GameRuleDialog } from "../../Diaog/gameRuleDialog";
import { BuilderNameConstants, RouterModule } from "routermodule";
import { ChatMsgModel } from "../../viewmodel/MessageViewModel";
import { ChatMsg, ROLE } from "../../model/ChatMassageModel";
import { MessageComponent } from "../../view/MessageComponent";
import { CloudPoemService } from "../../service/CloudPoemService";
import { addExp } from "../../common/util/addExp";
import { CommonConstants } from '../../common/constants/commonConstants';
import { RandomUtil } from "utils/src/main/ets/puraUtils/RandomUtil";
import { BreakpointTypeEnum } from "utils";

const TAG: string = ' FlyingFlowerOrderPage ';
let MessageDataModel: ChatMsgModel = new ChatMsgModel();
let addEXPId: number = 0
const lingCi: string[] = [
  "花", "春", "秋", "风", "月",
  "水", "山", "雪", "夜", "心",
  "人", "日", "江", "梅", "竹",
  "松", "柳", "雨", "云", "桃",
  "梨", "兰", "菊", "河", "海",
  "楼", "庭", "林", "桥"
];

@Component
export struct FlyingFlowerOrderPage {
  @State inputText: string = ''; // 输入框的文本状态
  controller: TextInputController = new TextInputController(); // 控制输入框的控制器
  //
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointTypeEnum.MD;
  @State format: string = 'mm:ss.SS';
  @State isCountDown: boolean = true;
  textTimerController: TextTimerController = new TextTimerController();
  //
  @State PoemList: Poem[] = []; // 存储诗词的的列表
  @State commonWord: string = '月'; // 当前每句诗词必须包含的汉字
  @State poemMap: Map<string, Poem> = new Map<string, Poem>()
  @State StartId: number = 0
  @State gameOver: boolean = false
  @State ansArr: string[] = []
  @State count: number = 0 //用户回答的次数统计
  //
  dialogController: CustomDialogController = new CustomDialogController({
    builder: GameRuleDialog({ str: $r('app.string.FlyingFlowerOrderRule') }),
  })

  aboutToAppear(): void {
    let index: number = RandomUtil.randomLimit(29)
    this.commonWord = lingCi[index]
    //每10秒浏览页面加5经验
    addEXPId = setTimeout(() => {
      addExp(CommonConstants.expTypeGame, 5)
    }, 10000)


    if (this.PoemList.length === 0) {
      this.systemAddSentence()

    } else {
      LogUtil.debug('this.PoemList.length !== 0')
    }
  }

  aboutToDisappear(): void {
    this.PoemList = []
    this.poemMap.clear()
    MessageDataModel.data = []
    MessageDataModel.notifyDataReload()
    //退出页面，取消对经验值的添加
    clearTimeout(addEXPId)
  }

  async systemAddSentence() {
    let tempPoem: Poem | undefined = await CloudPoemService.fetchPoemSentenceByChar(this.commonWord, this.StartId)
    if (tempPoem) {
      let res: string | undefined = CloudPoemService.extractSentence(tempPoem, this.commonWord)
      if (res) {
        if (!this.ansArr.includes(res)) {
          this.PoemList.push(tempPoem)
          this.ansArr.push(res)
          MessageDataModel.pushData(new ChatMsg(ROLE.IdiomSystem, res));

          this.StartId = tempPoem.id
        }
      }
    }
    this.textTimerController.reset()
    this.textTimerController.start()

  }

  build() {
    NavDestination() {
      Flex({ direction: FlexDirection.Row, wrap: FlexWrap.NoWrap }) {

        Stack() {
          Image($r('app.media.game_flyFlower'))
            .objectFit(ImageFit.Cover)
            .opacity(0.7)
          Column() {
            Column() {
              // 头部
              Row() {

                Text('游戏规则')
                  .fontSize($r('app.float.title_text_size'))
                  .onClick(() => {
                    this.dialogController.open()
                  })

                Text('今日令词：' + this.commonWord)
                  .fontSize($r('app.float.title_text_size'))
                // 计时器
                TextTimer({ controller: this.textTimerController, isCountDown: this.isCountDown, count: 60000 })
                  .format(this.format)
                  .fontColor(Color.Black)
                  .fontSize(24)
                  .onTimer((utc: number, elapsedTime: number) => {
                    LogUtil.info(`textTimer notCountDown utc is：${utc}, elapsedTime: ${elapsedTime}`);
                    if (elapsedTime === 6000) {
                      this.gameOver = true
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
            }

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
                  LogUtil.debug(TAG, "触发输入框提交: " + enterKey);
                  let tempText = this.inputText;
                  this.inputText = '';
                  MessageDataModel.pushData(new ChatMsg(ROLE.user, tempText)); //输入到聊天界面
                  CloudPoemService.isPoemSentence(tempText).then(async isPoSen => {
                    if (isPoSen > 0) { //是诗词
                      if (!this.ansArr.includes(tempText)) {
                        this.ansArr.push(tempText)
                        let poem: Poem | undefined = await CloudPoemService.fetchDataById(isPoSen)
                        if (poem) {
                          this.poemMap.set(tempText, poem)
                          this.ansArr.push(tempText)
                        }
                        this.systemAddSentence()
                      }

                    } else {
                      MessageDataModel.pushData(new ChatMsg(ROLE.IdiomSystem, "这看起来不是一句诗句"));
                      MessageDataModel.pushData(new ChatMsg(ROLE.IdiomSystem, "我接着继续"));
                      this.systemAddSentence()
                    }
                  })

                });
            }
            .width('100%')
            .margin({ bottom: 40 })
            .padding(10)

          }
          .backgroundImageSize(ImageSize.Cover)
          .margin({ top: $r('app.float.header_height_page') })
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .visibility((this.gameOver === true && this.currentBreakpoint !== BreakpointTypeEnum.LG) ?
        Visibility.None : Visibility.Visible)

        // if (this.currentBreakpoint === BreakpointTypeEnum.LG || this.gameOver === true) {
        Column() {
          if (this.gameOver) {
            Text('游戏结束，你本次共接上了' + this.count + '句')
              .fontSize($r('app.float.normal_text_size1'))
              .margin(40)
          }
          ForEach(this.ansArr, (item: string) => {
            Text(item)
              .fontSize($r('app.float.normal_text_size1'))
            Divider()
              .width('80%')
              .margin(5)
          })
        }
        .visibility((this.currentBreakpoint === BreakpointTypeEnum.LG || this.gameOver === true) ?
        Visibility.Visible : Visibility.None)
        .width('100%')
        .margin({ top: 50 })
        .animation({
          duration: 2000,
          curve: Curve.EaseOut,
          iterations: 1,
          playMode: PlayMode.Normal
        })


        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(HorizontalAlign.Center)
      }

    }
    .margin({ top: $r('app.float.header_height_page') })
    .hideTitleBar(true)
  }
}

@Builder
export function FlyingFlowerOrderPageBuilder() {
  FlyingFlowerOrderPage()
}

const builderName = BuilderNameConstants.CULTURE_FlyingFlowerOder
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(FlyingFlowerOrderPageBuilder)
  RouterModule.registerBuilder(builderName, builder)
}
import { async } from "@hw-agconnect/cloud/src/main/ets/storage/upload/task";
import { BuilderNameConstants, RouterModule } from "routermodule";
import { LogUtil } from "utils/src/main/ets/puraUtils/LogUtil";
import { Sentence } from "../../model/Sentence";
import { CloudPoemService } from "../../service/CloudPoemService";
import { EditableTitleBar } from "@ohos.arkui.advanced.EditableTitleBar";
import { gameOverComponent } from "../../view/game/GapFilling/gameOverComponent";

@Preview
@Component
export struct GapFillingPage {
  @State inputText: string = ''; // 输入框的文本状态
  controller: TextInputController = new TextInputController(); // 控制输入框的控制器
  @State sentenceList: Sentence[] = [];
  @State sentenceId: number[] = [];
  @State curSentence: Sentence = new Sentence();
  @State firstPart: string = ''; // 用于存储第一部分诗句
  @State secondPart: string = ''; // 用于存储第二部分诗句
  @State feedback: string = ''; // 用户反馈信息
  @State curIndex: number = 0;
  @State isRight: boolean[] = Array(10).fill(false)
  @State question: string[][] = []
  @State isGameOver: boolean = false

  async aboutToAppear(): Promise<void> {
    LogUtil.debug('这是GapFillingPage');
    await this.randGet10Sentences().then(() => {
      if (this.sentenceList.length > 0) {
        this.curSentence = this.sentenceList[0];
        this.splitSentence();
      } else {
        LogUtil.debug('this.sentenceList.length===0');
      }
    });
  }

  splitSentence() {
    const punctuationPattern = /[，。！？]/g;
    const matches = this.curSentence.text.match(punctuationPattern);

    if (matches && matches.length > 1) {
      // 找到最后一个标点符号的位置
      const lastPunctuationIndex = this.curSentence.text.lastIndexOf(matches[matches.length - 1]);
      // 找到倒数第二个标点符号的位置
      const secondLastPunctuationIndex =
        this.curSentence.text.lastIndexOf(matches[matches.length - 2], lastPunctuationIndex - 1);

      if (secondLastPunctuationIndex !== -1) {
        this.firstPart = this.curSentence.text.substring(0, secondLastPunctuationIndex + 1).trim(); // 第一部分
        this.secondPart = this.curSentence.text.substring(secondLastPunctuationIndex + 1).trim(); // 剩余部分
      } else {
        // 如果找不到倒数第二个标点符号，使用最后一个标点符号进行分割
        this.firstPart = this.curSentence.text.substring(0, lastPunctuationIndex + 1).trim(); // 第一部分
        this.secondPart = this.curSentence.text.substring(lastPunctuationIndex + 1).trim(); // 剩余部分
      }
    } else {
      // 如果没有找到足够的标点符号，整句作为第一部分
      this.firstPart = this.curSentence.text; // 第一部分
      this.secondPart = ''; // 第二部分为空
    }

    this.question.push([this.firstPart, this.secondPart]);
    LogUtil.debug('Split sentence:', this.firstPart, this.secondPart);
    LogUtil.debug('Current question list:', this.question.toString());
  }

  // 获取10条数据
  async randGet10Sentences() {
    const rand = Math.floor(Math.random() * 9990) + 1;
    const sen: Sentence[] | undefined = await CloudPoemService.fetchSentencesAfterId(rand);
    if (sen) {
      this.sentenceList = sen;
    }
  }

  nextSentence() {
    if (this.curIndex < this.sentenceList.length - 1) {
      this.curIndex++;
      this.curSentence = this.sentenceList[this.curIndex];
      this.splitSentence();
    } else {
      LogUtil.warn("No more sentences to display.");
      this.isGameOver = true
    }
  }

  build() {
    NavDestination() {
      Stack() {
        Column() {
          if (this.feedback) {
            Text(this.feedback)
              .fontSize(20)
              .fontColor(this.feedback === '回答正确' ? Color.Green : Color.Red)
              .margin({ bottom: 10 });
          }

          Row() {
            Text(' ')

            Text((this.curIndex + 1).toString() + "/" + '10')

            Text('跳过')
              .fontSize(20)
              .onClick(() => {
                this.nextSentence();
              });
          }
          .width('80%')
          .justifyContent(FlexAlign.SpaceBetween);

          Column() {
            Row() {
              Text(this.firstPart).fontSize(20).margin({ bottom: 10 });
              Column() {
                Text(this.inputText).fontSize(20).margin({ bottom: 10 });
                Divider()
                  .width(this.secondPart.length * 25);
              }
            }
            .justifyContent(FlexAlign.Center)
            .width('100%');

            Text('——' + this.curSentence.from)
              .fontSize(20)
              .margin(20);
          }

          Row() { // 输入框和发送按钮的行布局
            TextInput({ controller: this.controller, text: this.inputText })
              .width('90%')
              .height(40)
              .margin(20)
              .fontSize(14)
              .fontColor(Color.Black)
              .enterKeyType(EnterKeyType.Send)// 设置回车键类型为发送
              .onChange((value: string) => {
                this.inputText = value; // 更新输入框文本
              })
              .onSubmit(async (enterKey: EnterKeyType, event: SubmitEvent) => {
                if (this.inputText[this.inputText.length - 1] !== '。') {
                  this.inputText += '。';
                }
                if (this.inputText.trim() === this.secondPart.trim()) {
                  this.feedback = '回答正确';
                  this.inputText = ''; // 清空输入框
                  this.isRight[this.curIndex] = true
                  setTimeout(() => {
                    this.feedback = '';
                  }, 2000); // 2秒后清除反馈
                  this.nextSentence();
                } else {
                  this.feedback = '回答错误';
                  setTimeout(() => {
                    this.feedback = '';
                  }, 2000); // 2秒后清除反馈
                }
              });
          }
          .width('100%')
          .margin({ bottom: 20 })
          .padding(10);
        }
        .height('90%')
        .margin({ top: $r('app.float.header_height_page') })
        .justifyContent(FlexAlign.SpaceAround)
        .visibility(this.isGameOver ? Visibility.Hidden : Visibility.Visible)

        gameOverComponent({
          sentenceList: this.sentenceList,
          isRight: this.isRight,
          question: this.question,
          isGameOver: this.isGameOver
        })


      }

    }
  }
}

@Builder
export function GapFillingPageBuilder() {
  GapFillingPage();
}

const buildName = BuilderNameConstants.CULTURE_GapFillingPage;
if (!RouterModule.getBuilder(buildName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(GapFillingPageBuilder);
  RouterModule.registerBuilder(buildName, builder);
}
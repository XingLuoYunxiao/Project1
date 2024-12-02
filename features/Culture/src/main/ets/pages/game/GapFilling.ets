import { BuilderNameConstants, RouterModule } from "routermodule";
import { LogUtil } from "utils/src/main/ets/puraUtils/LogUtil";
import { Sentence } from "../../model/Sentence";
import { CloudPoemService } from "../../service/CloudPoemService";

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

  aboutToAppear(): void {
    LogUtil.debug('这是GapFillingPage')
    this.randGetSentence();
  }

  // 获取数据
  async randGetSentence() {
    const maxAttempts = 10; // 尝试次数上限
    let attempts = 0;
    while (attempts < maxAttempts) {
      const rand = Math.floor(Math.random() * 9999) + 1;
      if (!this.sentenceId.includes(rand)) {
        try {
          const sen: Sentence | undefined = await CloudPoemService.fetchSentenceById(rand);
          if (sen) {
            this.curSentence = sen;
            LogUtil.print(sen);
            // 根据逗号分割诗句
            const parts = this.curSentence.text.split('，');
            this.firstPart = parts[0]; // 第一部分
            this.secondPart = parts[1] || ''; // 第二部分，如果没有则为空
            this.sentenceId.push(rand); // 记录已使用的句子ID
            break;
          }
        } catch (error) {
          LogUtil.error("Failed to fetch sentence: ", error);
        }
      }
      attempts++;
    }
    if (attempts >= maxAttempts) {
      LogUtil.warn("Exceeded maximum attempts to fetch a unique sentence.");
    }
  }

  build() {
    NavDestination() {
      Column() {
        // if (this.feedback) {
        //   Text(this.feedback)
        //     .fontSize(20)
        //     .fontColor(this.feedback === '回答正确' ? Color.Green : Color.Red)
        //     .margin({ bottom: 10 });
        // }
        Row() {
          Text(this.firstPart).fontSize(20).margin({ bottom: 10 });
          Text(this.inputText).fontSize(20).margin({ bottom: 10 });
        }

        Row() { // 输入框和发送按钮的行布局
          TextInput({ controller: this.controller, text: this.inputText })
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
              if (this.inputText.trim() === this.secondPart.trim()) {
                this.feedback = '回答正确';
                this.inputText = ''; // 清空输入框
                setTimeout(() => {
                  this.feedback = '';
                }, 2000); // 2秒后清除反馈
                this.randGetSentence();
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
        .padding(10)
      }
    }

  }
}

@Builder
export function GapFillingPageBuilder() {
  GapFillingPage()
}

const buildName = BuilderNameConstants.CULTURE_GapFillingPage
if (!RouterModule.getBuilder(buildName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(GapFillingPageBuilder)
  RouterModule.registerBuilder(buildName, builder)
}

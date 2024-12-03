import { Sentence } from "../../../model/Sentence"

@Component
export struct gameOverComponent {
  @Prop sentenceList: Sentence[]
  @Prop isRight: boolean[]
  @Prop question: string[][]
  @Prop isGameOver: boolean

  build() {

    Column() {
      Text('本轮填空详情')
        .fontSize(20)
        .margin(20)

      List({ space: 10 }) {
        ForEach(this.sentenceList, (item: Sentence, index: number) => {
          ListItem() {
            Column() {
              if (!this.isRight[index]) {
                Row() {
                  if (this.question && this.question.length > 0 && this.question[index]) {
                    // 确保 question 和 question[index] 都不是 null 或 undefined

                    Column() {
                      Row() {
                        Text(this.question[index][0])
                        Divider()
                          .width(this.question[index][1].length * 20)
                          .margin({ top: 10 })
                      }

                      Row() {
                        Text('正确答案:')
                          .fontColor(Color.Red)
                        Text(this.question[index][1])
                      }

                    }

                  } else {
                    // 如果 question 或 question[index] 无效，显示默认文本
                    Text('数据加载中...')
                  }
                }
              } else {
                Text(this.sentenceList[index].text)
                Text('回答正确')
                  .fontColor(Color.Green)
              }

            }
            .width('100%')
            .height(40)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }
        })
      }

    }
    .width('100%')
    .height('100%')
    .visibility(this.isGameOver ? Visibility.Visible : Visibility.Hidden)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .margin({ top: $r('app.float.header_height_page') })
  }
}
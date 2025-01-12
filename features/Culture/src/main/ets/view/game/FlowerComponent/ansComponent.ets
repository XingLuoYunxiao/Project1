import { BreakpointTypeEnum } from "utils"
import { Poem } from "../../../model/Poem"
import { HighLightText } from "../../HighLightText"

@Component
export struct ansComponent {
  @Link gameOver: boolean
  @Link count: number
  @Link ansArr: string[]
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointTypeEnum.MD;
  @Link poemMap: Map<string, Poem>
  @Link commonWord: string
  @State isShow: boolean = false;
  @State isShowMap: Map<string, boolean> = new Map();
  @State currentPoem: string = ''

  @Builder
  myBuilder(totalStr: string, highLight: string) {
    Column() {

      HighLightText({ totalString: totalStr, highLightStr: highLight })
        .margin({ top: 50 })

    }
  }

  getAllPoem(sub: string): string {
    return this.poemMap.get(sub)?.content as string
  }

  build() {
    Column() {
      if (this.gameOver) {
        Text('游戏结束，你本次共接上了' + this.count + '句')
          .fontSize($r('app.float.normal_text_size1'))
          .margin(40)
      }
      List() {
        ForEach(this.ansArr, (item: string) => {
          ListItem() {
            Column() {
              HighLightText({ totalString: item, highLightStr: this.commonWord })
                .margin(20)
                .onClick(() => {
                  this.currentPoem = item
                  this.isShow = !this.isShow
                })

              Divider()
                .width('80%')
                .margin(5)
            }

          }
        })
      }
      .bindSheet($$this.isShow, this.myBuilder(this.getAllPoem(this.currentPoem), this.currentPoem), {
        height: 500,
        backgroundColor: $r('app.color.main_background'),
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
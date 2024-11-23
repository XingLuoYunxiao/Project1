import { calligraphyItem, calligraphyItemList } from "../../model/art/CalligraphyModel"
import { PreferencesUtil } from "utils/src/main/ets/puraUtils/PreferencesUtil"
import { EXP } from "../../model/EXP"
import { LogUtil } from "utils/src/main/ets/puraUtils/LogUtil"
import { addExp } from "../../common/util/addExp"
import { BuilderNameConstants, RouterModule } from "routermodule"


const TAG: string = 'CalligraphyDetails  '
let addEXPId: number = 0

@Component
export struct CalligraphyDetails {
  @State pageIntroduction: string = '书法是中华文化的载体，接下来让我们以时间的尺度，探究中华书法的演变，体会书法的魅力'
  @State historyBackground: string = '书法，作为中国传统文化的重要组成部分，经历了数千年的发展，承载着丰富的历史和文化信息。'
  @State modernApplication: string = '在现代社会，书法不仅是一种艺术表现形式，也在设计、教育等领域得到了广泛应用。'

  aboutToAppear(): void {
    //每10秒浏览页面加5经验
    addEXPId = setTimeout(() => {
      addExp('Painting', 5)
    }, 10000)
  }

  aboutToDisappear(): void {
    // 退出页面时取消对经验值的添加
    clearTimeout(addEXPId)
  }

  build() {
    NavDestination() {
      Column() {
        List() {
          ListItem() {
            Text(this.pageIntroduction)
              .fontSize(22)
              .padding(10)
              .margin(15)
          }

          ListItem() {
            Text(this.historyBackground)
              .fontSize(20)
              .padding(10)
              .margin(10)
          }

          ListItem() {
            Text(this.modernApplication)
              .fontSize(20)
              .padding(10)
              .margin(10)
          }

          ListItem() {
            Text('以下是主流的书法类型的介绍：')
              .fontSize(24)
              .padding(10)
              .margin(10)
              .fontWeight(FontWeight.Medium)
          }

          ForEach(calligraphyItemList, (item: calligraphyItem) => {
            ListItem() {
              ItemBuilder({ calli: item })
            }
          })

          ListItem() {
            Text("著名书法家：" + "王羲之、颜真卿、欧阳询等，他们的作品深刻影响了书法艺术的发展。")
              .fontSize(20)
              .padding(10)
              .margin(10)

          }
        }

        .onReachEnd(() => {

          addExp('art')


        });

      }


      .width('100%')
    }
    .hideTitleBar(true)
  }
}

@Component
struct ItemBuilder {
  @Prop calli: calligraphyItem

  build() {
    Column() {
      List() {
        ListItem() {
          Text(this.calli.name)
            .fontSize(18)
            .padding(5)
            .margin(5)
        }

        ListItem() {
          Text("简介：" + this.calli.introduction)
            .fontSize(16)
            .padding(5)
            .margin(5)
        }

        ListItem() {
          Text("起源：" + this.calli.originPeriod)
            .fontSize(16)
            .padding(5)
            .margin(5)
        }

        ListItem() {
          if (this.calli.famousCalligraphers.length > 0) {
            Text("著名书法家：" + this.calli.famousCalligraphers.join(', '))
              .fontSize(16)
              .padding(5)
              .margin(5)
          }
        }

        ListItem() {
          Image(this.calli.Images)
            .margin({ right: 15 })
            .width('98%')
            .objectFit(ImageFit.Cover)
        }
      }
    }
    .width('100%')
  }
}

@Builder
export function CalligraphyDetailsBuilder() {
  CalligraphyDetails()
}

const builderName = BuilderNameConstants.CULTURE_CALLIGRAPHY
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(CalligraphyDetailsBuilder)
  RouterModule.registerBuilder(builderName, builder)
}

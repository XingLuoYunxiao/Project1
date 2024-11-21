import { addExp } from "../../common/util/addExp"
import { Custom, Festival } from "../../model/tradictionFestival/festivalModel"
import { FestivalInstance, FestivalProject } from "../../model/tradictionFestival/tradFestProject"


@Builder
export function FestivalPageBuilder() {
  FestivalPage()
}

let addEXPId: number = 0

@Component
export struct FestivalPage {
  @State FestivalInstance: FestivalProject = FestivalInstance

  // 组件即将出现时的生命周期函数
  aboutToAppear(): void {

    //每10秒浏览页面加5经验
    addEXPId = setTimeout(() => {
      addExp('Festival', 5)
    }, 10000)
  }

  aboutToDisappear(): void {
    // 退出页面时取消对经验值的添加
    clearTimeout(addEXPId)
  }

  build() {
    NavDestination() {
      Swiper() {
        Column({ space: 10 }) {
          Text(FestivalInstance.getName())
            .fontSize(24)

          Text(FestivalProject.introduction)
            .fontSize(24)
          //.align(Alignment.Center)

          Text('    接下来，让我们重新了解我们的传统节日')
            .fontSize(26)

        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .padding(30)
        .height('100%')

        ForEach(this.FestivalInstance.festivals, (item: Festival) => {
          this.festivalItem(item)

        })
      }
      .vertical(true)

    }

  }

  @Builder
  festivalItem(festival: Festival) {

    Column({ space: 10 }) {
      Text(festival.getSummary())
        .padding(30)
        .fontSize(24)
      Text(festival.name + "的习俗有:")
        .padding(30)
        .fontSize(24)
      ForEach(festival.customs, (cust: Custom) => {
        CustomBuilder({ cust: cust })
      })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
export struct CustomBuilder {
  @Prop cust: Custom
  @State handlePopup: boolean = false

  build() {
    Column() {
      Text(this.cust.name)
        .fontSize(18)
        .onClick(() => {
          this.handlePopup = !this.handlePopup
        })
        .bindPopup(this.handlePopup, {
          message: this.cust.description,
        })
    }
    .width('100%')
    .height(100)
  }
}





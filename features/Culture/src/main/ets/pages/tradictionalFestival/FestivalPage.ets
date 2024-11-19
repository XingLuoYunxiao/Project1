import { Festival } from "../../model/tradictionFestival/festivalModel"
import { FestivalInstance, FestivalProject } from "../../model/tradictionFestival/tradFestProject"

@Builder
export function FestivalPageBuilder() {
  FestivalPage()
}


@Component
export struct FestivalPage {
  @State FestivalInstance: FestivalProject = FestivalInstance

  build() {
    NavDestination() {
      Swiper() {
        Column() {
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
        .padding(10)

        ForEach(this.FestivalInstance.festivals, (item: Festival) => {
          this.festivalItem(item)
        })
      }
      .vertical(true)

    }

  }

  @Builder
  festivalItem(festival: Festival) {

    Column() {
      Text(festival.getSummary())

      Text(festival.name + "的习俗有:" + festival.customs.forEach(item => {
        item.name
      }))


    }
    .width('100%')
  }
}


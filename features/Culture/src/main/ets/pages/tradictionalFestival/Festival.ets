import { BuilderNameConstants, RouterModule } from "routermodule"
import { CommonConstants } from "../../common/constants/commonConstants"
import { addExp } from "../../common/util/addExp"
import { Custom, Festival } from "../../model/tradictionFestival/festivalModel"
import { FestivalInstance, FestivalProject } from "../../model/tradictionFestival/tradFestProject"
import { FestivalPage } from "./FestivalPage"


let addEXPId: number = 0

@Preview
@Component
export struct FestivalPage2 {
  @State FestivalInstance: FestivalProject = FestivalInstance

  // 组件即将出现时的生命周期函数
  aboutToAppear(): void {

    //每10秒浏览页面加5经验
    addEXPId = setTimeout(() => {
      addExp(CommonConstants.expTypeCulture, 5)
    }, 10000)
  }

  aboutToDisappear(): void {
    // 退出页面时取消对经验值的添加
    clearTimeout(addEXPId)
  }

  build() {
    NavDestination() {
      Column() {
        Swiper() {
          ForEach(this.FestivalInstance.festivals, (item: Festival) => {
            this.festivalItem(item)

          },
            (item: Festival) => item.name)
        }

        .loop(true)

      }
    }

  }

  // 自定义方式2：使用系统提供的多种默认效果(平移、缩放、透明度等)
  pageTransition() {
    PageTransitionEnter({ duration: 200 })
      .slide(SlideEffect.Right) //Right
    PageTransitionExit({ delay: 100 })
      .slide(SlideEffect.END) //Right
  }

  @Builder
  festivalItem(festival: Festival) {
    Stack() {
      Image(festival.path)
        .objectFit(ImageFit.Cover)
        .width('100%')
        .opacity(0.6)
      Column({ space: 10 }) {
        Text(festival.getSummary())
          .padding(30)
          .fontSize(24)
        Row() {
          Text(festival.name + "习俗:")
            .padding(30)
            .fontSize(24)

          Row() {
            ForEach(festival.customs, (cust: Custom) => {
              CustomBuilder({ cust: cust })
            })
          }

        }

      }
      .width('100%')
      .height('100%')
    }

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
    .justifyContent(FlexAlign.Center)
    .width('20%')
    .height(100)
  }
}


@Builder
export function FestivalPageBuilder2() {
  FestivalPage2()
}

const builderName = BuilderNameConstants.CULTURE_FestivalPage2
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(FestivalPageBuilder2)
  RouterModule.registerBuilder(builderName, builder)
}



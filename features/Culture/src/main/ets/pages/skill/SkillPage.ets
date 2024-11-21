import { ArtForm, TraditionalCraft } from '../../model/skill/skillModel'
import { skillItance as skillInstance, skillProject } from '../../model/skill/skillProject'


@Builder
export function SkillPageBuilder() {
  SkillPage()
}


@Component
export struct SkillPage {
  @State skillInstance: skillProject = skillInstance

  build() {
    NavDestination() {

      Swiper() {
        Column({ space: 10 }) {
          Text(skillInstance.getName())
            .fontSize(20)
            .padding(15)
          Text($r('app.string.skill_show_introduction'))
            .fontSize(20)
            .padding(15)

        }
        .height('100%')
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)

        Tabs() {
          TabContent() {
            CraftItem({ craft: skillInstance.skills[0] })
          }
          .tabBar('陶瓷')

          TabContent() {
            CraftItem({ craft: skillInstance.skills[1] })
          }
          .tabBar('丝绸')

          TabContent() {
            CraftItem({ craft: skillInstance.skills[2] })
          }
          .tabBar('金属工艺')
        }
      }
      .vertical(true)
      .loop(false)
      .displayArrow(null)

    }
    .hideTitleBar(true)
  }
}

@Component
struct CraftItem {
  @Prop craft: TraditionalCraft
  scrollerForList: Scroller = new Scroller()

  build() {
    Scroll() {
      Column({ space: 16 }) {

        Text(this.craft.description[0])
          .fontSize(20)
        Text(this.craft.description[1])
          .fontSize(20)
        Text(this.craft.defineAndOrigin)
          .fontSize(20)

        ForEach(this.craft.artForms, (item: ArtForm, index: number) => {
          this.ArtFormBuilder(item, index)
        })

      }
      .height("auto")
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)
      .width('100%')
    }
    .scrollable(ScrollDirection.Vertical) // 滚动方向纵向
    .scrollBar(BarState.Off) // 滚动条常驻显示
    .scrollBarColor(Color.Gray) // 滚动条颜色
    .scrollBarWidth(1) // 滚动条宽度
    .width('100%')
    .friction(0.6)
    .edgeEffect(EdgeEffect.None)
  }

  @Builder
  ArtFormBuilder(Art: ArtForm , index: number) {
    Row() {
      if (index % 2 === 0) {
        Image(Art.Image)
          .alt($r('app.media.alt'))
          .width('48%')
        Column() {
          Text(Art.name)
          Text(Art.description)
        }
        .justifyContent(FlexAlign.SpaceAround)
        .width('48%')
      } else {
        Column() {
          Text(Art.name)
          Text(Art.description)
        }
        .justifyContent(FlexAlign.SpaceAround)
        .width('48%')

        Image(Art.Image)
          .alt($r('app.media.alt'))
          .width('48%')

      }
    }
    .padding(20)
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')

  }
}
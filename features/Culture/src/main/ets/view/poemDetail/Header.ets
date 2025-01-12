import { RouterModule, RouterNameConstants } from "routermodule"
import { Poem } from "../../model/Poem"
import { talk } from "../poem/talk"

@Component
export struct Header {
  @Link showTranslation: boolean
  @Link showShangxi: boolean
  @Link showRemark: boolean
  @Prop poem: Poem

  build() {
    Row() {
      Image($r('app.media.ic_back'))
        .width(40)
        .onClick(() => {
          RouterModule.pop(RouterNameConstants.ENTRY_HAP)
        })

      Row({ space: 10 }) {
        //收藏
        Image($r('app.media.ic_poemDetail_collection'))
          .width(30)
          .onClick(() => {

          })
        //译文
        Image($r('app.media.ic_poemDetail_yi'))
          .width(40)
          .onClick(() => {
            this.showTranslation = !this.showTranslation
          })
        //注释
        Image($r('app.media.ic_poemDetail_zhu'))
          .width(35)
          .onClick(() => {
            this.showRemark = !this.showRemark
          })
        // 赏析
        Image($r('app.media.ic_poemDetail_shang'))
          .width(30)
          .onClick(() => {
            this.showShangxi = !this.showShangxi
          })
        //朗诵
        talk({ poem: this.poem })
      }

    }
    .margin({ top: 50 })
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
  }
}
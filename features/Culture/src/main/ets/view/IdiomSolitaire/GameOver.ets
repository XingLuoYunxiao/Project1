import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule"

@CustomDialog
export struct GameOverDialog {
  @Prop count: number
  controller?: CustomDialogController
  cancel: () => void = () => {
  }
  regame: () => void = () => {
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_back'))
          .width(40)
          .onClick(() => {
            if (this.controller != undefined) {
              this.controller.close()
            }
            RouterModule.pop(RouterNameConstants.ENTRY_HAP)
          })
      }.width('100%')
      .justifyContent(FlexAlign.End)

      Text('成语接龙')

      Text(`您本局一共接住了${Math.floor(this.count)}` + '句')

    }
    .justifyContent(FlexAlign.SpaceAround)
    .width(300)
    .height(300)
  }
}
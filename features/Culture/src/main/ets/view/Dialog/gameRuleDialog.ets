@CustomDialog
export struct GameRuleDialog {
  @Prop str: ResourceStr
  controller: CustomDialogController = new CustomDialogController({
    builder: GameRuleDialog({}),
  })

  build() {
    Column() {

      Text(this.str)
        .fontSize(20)
        .margin({ top: 10, bottom: 10 })

      Button('确认')
        .onClick(() => {
          this.controller.close()
        })
    }
    .width(280)
    .height(240)
  }
}
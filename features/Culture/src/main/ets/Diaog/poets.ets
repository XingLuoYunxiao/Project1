import { poets } from '../common/constants/poemType'

@CustomDialog
export struct PoetsCustomDialog {
  @Link poets: string
  controller: CustomDialogController

  build() {
    Column() {
      Flex({ wrap: FlexWrap.Wrap, alignContent: FlexAlign.Start }) {
        ForEach(poets, (item: string) => {
          Text(item)
            .fontSize(20)
            .margin(8)
            .onClick(() => {
              this.poets = item
              this.controller.close()
            })
        })
      }
    }
  }
}
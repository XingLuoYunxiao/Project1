import { TypeList } from '../common/constants/poemType'

@CustomDialog
export struct CustomDialogType {
  @Link type: string
  cancel?: () => void
  confirm?: () => void
  controller: CustomDialogController

  build() {
    Column() {
      Flex({ wrap: FlexWrap.Wrap, alignContent: FlexAlign.Start }) {
        ForEach(TypeList, (item: string) => {
          Text(item)
            .fontSize(20)
            .margin(8)
            .onClick(() => {
              this.type = item
              this.controller.close()
            })
        })
      }
    }
  }
}
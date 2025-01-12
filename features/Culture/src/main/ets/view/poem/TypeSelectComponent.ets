import { CacheUtil } from "utils"
import { TypeList } from "../../common/constants/poemType"
import { PoetsCustomDialog } from "../../Diaog/poets"
import { CustomDialogType } from "../../Diaog/type"
import { Poem } from "../../model/Poem"

@Component
export struct selectComponent {
  @Link curPoemType: string
  @Link curPoets: string
  @Link curDynasty: string
  @Link curDynastyIndex: number | number[]
  @Prop dynastyList: string[]
  TypeDialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogType({
      type: this.curPoemType
    }),
  })
  PoetDialogController: CustomDialogController = new CustomDialogController({
    builder: PoetsCustomDialog({
      poets: this.curPoets
    }),
  })

  build() {
    Row() {
      Text('类型： ' + this.curPoemType)
        .fontSize(20)
        .onClick(() => {
          this.TypeDialogController.open()
        })

      Text('诗人：' + this.curPoets)
        .fontSize(20)
        .onClick(() => {

        })

      Text('朝代：' + this.curDynasty)
        .fontSize(20)
        .onClick(() => {
          TextPickerDialog.show({
            // 建议使用 this.getUIContext().showTextPickerDialog()接口
            range: this.dynastyList,
            selected: this.curDynastyIndex,
            textStyle: { color: Color.Black, font: { size: 20, weight: FontWeight.Normal } },
            selectedTextStyle: { color: Color.Blue, font: { size: 30, weight: FontWeight.Bolder } },
            onAccept: (value: TextPickerResult) => {
              // 设置select为按下确定按钮时候的选中项index，这样当弹窗再次弹出时显示选中的是上一次确定的选项
              this.curDynastyIndex = value.index
              this.curDynasty = this.dynastyList[this.curDynastyIndex as number]
              console.log(this.curDynastyIndex + '')
            },
            onCancel: () => {
              console.info("TextPickerDialog:onCancel()")
            }
          })
        })
    }
    .margin({ bottom: 30 })
    .justifyContent(FlexAlign.SpaceAround)
    .width('100%')
  }
}
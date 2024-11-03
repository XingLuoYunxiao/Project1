import Constants from "../../constants/Constants";
import { Spot } from "../../model/Spot";

@Component
export struct AttractionCard {
  @ObjectLink item: Spot;

  build() {
    Row() {
      Image($r(`${this.item.image}`))
        .width(160)
        .height(200)
        .borderRadius(Constants.BORDER_RADIUS)

      Column() {
        Text(this.item.name)
          .fontSize(Constants.FONT_TITLE)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: Constants.MARGIN_SM })
        Text(this.item.summary)
          .fontSize(Constants.FONT_CONTENT)
          .width(Constants.FULL_WIDTH)
          .margin({ top: Constants.MARGIN_SM })



        Text(this.item.rating.toString())
          .fontSize(Constants.FONT_CONTENT)
          .fontColor(Color.White)
          .width(40)
          .borderRadius(10)
          .textAlign(TextAlign.Center)
          .backgroundColor('#807055b5')
          .margin({top: Constants.MARGIN_SM, bottom: Constants.MARGIN_SM})

        Text(this.item.address)
          .fontSize(Constants.FONT_CAPTION)
          .fontColor(Constants.COLOR_TEXT)

        Text(this.item.openingHours)
          .fontSize(Constants.FONT_CAPTION)
          .fontColor(Constants.COLOR_TEXT_LIGHT)
          .margin({ left: Constants.MARGIN_SM })


        Row() {
          Text(`¥${this.item.ticketPrice}起`)
            .fontSize(Constants.FONT_TITLE)
            .fontColor(Constants.COLOR_DANGER)
            .fontWeight(FontWeight.Bold)
            .margin({ top: Constants.MARGIN_SM })
        }
        .width(Constants.FULL_WIDTH)
        .justifyContent(FlexAlign.End)
        .margin({ left: Constants.MARGIN_MD })

      }
      .alignItems(HorizontalAlign.Start)
      .padding({ left: Constants.MARGIN_LG })
      .layoutWeight(1)
    }
    .height(200)
    .width(Constants.FULL_WIDTH)
    .padding(Constants.CARD_PADDING)
    .backgroundColor(Color.White)
    .margin({ bottom: Constants.MARGIN_LG })
  }
}
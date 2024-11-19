import { CollectionAdd } from "../model/CollectionAdd"
import { HistoryAdd } from "../model/HistoryAdd"

@Component
export struct CollectHistoryItem {
  @ObjectLink item:CollectionAdd|HistoryAdd
  build() {
    Row() {
      Image($r(this.item.spot_img)).width(80).height(80)
        Text(this.item.spotname)
        Text('15km')
    }.borderRadius(20)
    .width('100%')
    .backgroundColor(Color.White)
    .padding(12)
  }
}
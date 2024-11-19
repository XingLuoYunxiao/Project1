import { myOrderAdd } from "../model/myOrderAdd"

@Component
export struct OrderItem {
@ObjectLink item:myOrderAdd
  build() {
    Column() {
      Row() {
        Text(this.item.spotname)
        Image($r('app.media.ic_arrow')).width(30)
        Blank()
        Text(this.item.order_status)
      }.width('100%')
      Row() {
        Image($r(this.item.spot_img)).width(80).height(80)
        Text(`下单:${this.item.order_time.getFullYear()}-${this.item.order_time.getMonth()+1}-${this.item.order_time.getDate()} ${this.item.order_time.toTimeString().substring(0,5)}`)
        Column() {
          Text(`￥${this.item.quantity* this.item.spot_price}`)
          Text(`共${this.item.quantity}件`)
        }
      }
      Row() {
        Text('更多')
        Blank()
        Button('评价')
        Button('再来一单')
      }.width('100%')
    }.borderRadius(20)
    .backgroundColor(Color.White)
    .padding(12)
  }
}
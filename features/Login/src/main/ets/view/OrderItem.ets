import { myOrderAdd } from "../model/myOrderAdd"
@CustomDialog
struct CustomDialogExample {
  controller: CustomDialogController;
  @Prop reviewname:string;
  @State rating: number =0;
  @State content:string=''
  build() {
    Column(){
      Row(){
        Text(this.reviewname)
        Button('发布').onClick(()=>{
          this.content=''
        })
      }
      Row(){
        Text('评分')
        Rating({ rating: this.rating, indicator: false })
          .stars(5)
          .stepSize(0.5)
          .margin({ top: 24 })
          .onChange((value: number) => {
            this.rating = value
          })
      }
      TextArea({placeholder:'亲,可以从环境、服务等方面分享旅行感受哦~', text: this.content})
        .onChange((value)=>{
          this.content=value
        })
        .height(200)
    }
  }
}

@Component
export struct OrderItem {
@ObjectLink item:myOrderAdd;
@Prop reviewname:string;
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      reviewname:this.reviewname
    }),
    cancel: (() => {
      this.dialogController.close()
    }),
    alignment: DialogAlignment.Bottom,
    cornerRadius: {
      topLeft: 14,
      topRight: 14,
      bottomLeft: 0,
      bottomRight: 0
    }
  })

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
        Button('评价').onClick(()=>{
          this.dialogController.open()
        })
        Button('再来一单')
      }.width('100%')
    }.borderRadius(20)
    .backgroundColor(Color.White)
    .padding(12)
  }
}
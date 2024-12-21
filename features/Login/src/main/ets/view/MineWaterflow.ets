import { Spot } from "travel"
import Constants from "../common/constants/Constants";
import {MineViewModel} from "../service/MineViewModel"
@Component
export struct MineWaterflow {
  @State mineViewModel:MineViewModel=MineViewModel.getInstance();
  @Prop listitem:Spot
  @State img:string=''

  async aboutToAppear(): Promise<void> {
    this.img=await this.mineViewModel.waterList(this.listitem.imageUrl as string)
  }
  build() {
    Column({space:Constants.SMALL_SPACE}) {
      Image(this.img)
        .width('50%')
        .borderRadius(10)
        .height(200)
      Text(this.listitem.name)
      Row({space:Constants.SMALL_SPACE}){
        Text(`￥${this.listitem.ticketPrice}`)
        Text('已售500+')
      }
    }
  }
}
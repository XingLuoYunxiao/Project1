import {myOrder} from '../model/myOrder'
import { myOrderAdd } from "../model/myOrderAdd"
import {mySpot} from '../model/mySpot'
import { OrderItem} from "../view/OrderItem"
import { ListDataSource } from "../service/ListDataSource"
import { MineViewModel } from "../service/MineViewModel"
import auth from '@hw-agconnect/auth'
import text from '@ohos.graphics.text'

@Component
export struct MyOrderPage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @State order: myOrder[] = []
  @StorageLink('personUid') personUid: string = ''
  @State spots: mySpot[] = []
  @State isSearch:boolean=false
  @State mineViewModel:MineViewModel=MineViewModel.getInstance();
  @Provide orderListData: ListDataSource<myOrderAdd> = this.mineViewModel.orderListData
  @State searchListData: ListDataSource<myOrderAdd> = new ListDataSource();

  async aboutToAppear() {
    auth.getCurrentUser().then(user=>{
      if(user){
        this.mineViewModel.orderDeal(user.getUid())
      }
    })
  }

  build() {
    NavDestination() {
      Column() {
        Row() {
          Image($r('app.media.ic_hobbies')).width(30).onClick(() => {
            this.appPathStack.pop()
          })
          Search({placeholder:'搜索我的订单'})
            .onSubmit((val)=>{
              this.isSearch=true
              this.searchListData.notifyDataDeleteAll()
              for (let index = 0; index < this.orderListData.totalCount(); index++) {
                const res=this.orderListData.getData(index)
                if(res.spotname.includes(val)){
                  this.searchListData.pushData(res)
                }
              }
              this.searchListData.notifyDataReload()
            }).width('80%')
        }

        Tabs() {
          TabContent() {
            Scroll(){
              Column(){
                List({space:10}) {
                  if(this.isSearch==true){
                      LazyForEach(this.searchListData, (or: myOrderAdd) => {
                        ListItem() {
                          OrderItem({item:or})
                        }
                      },(or: myOrderAdd,index:number) => JSON.stringify(or)+Math.random()+index)
                  }else{
                    LazyForEach(this.orderListData, (or: myOrderAdd) => {
                      ListItem() {
                        OrderItem({item:or})
                      }
                    }, (or: myOrderAdd) => JSON.stringify(or))
                  }
                }
                Text('已经到底了').fontSize(20).fontColor($r('app.color.page_background_grey'))
              }
            }.scrollBar(BarState.Off)
            .edgeEffect(EdgeEffect.Spring)
            .height('100%')
          }
          .tabBar('全部订单')
          TabContent() {
          }
          .tabBar('待使用')

          TabContent() {
            if ('') {
              Column() {
                Image($r('app.media.miaosha'))
                Text('您还没有相关订单')
                Text('没有找到订单?试试查看全部')
                Button('查看全部')
              }
            }
          }
          .tabBar('待评价')

          TabContent() {

          }
          .tabBar('退款售后')
        }
      }
      .padding(8)
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.page_background_grey'))
    }
    .hideTitleBar(true)
  }
}
@Builder
export function MyOrderPageBuilder() {
  MyOrderPage()
}
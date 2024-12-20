import {myOrder} from '../model/myOrder'
import { myOrderAdd } from "../model/myOrderAdd"
import {mySpot} from '../model/mySpot'
import { OrderItem} from "../view/OrderItem"
import { ListDataSource } from "../service/ListDataSource"
import { MineViewModel } from "../service/MineViewModel"
import auth from '@hw-agconnect/auth'
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from 'routermodule'
import Constants from '../common/constants/Constants'
import { Spot } from 'travel'
import { SpotNetFunc } from 'travel/src/main/ets/service/SpotNetFunc'

@Component
export struct MyOrderPage {
  @Consume('appPathStack') appPathStack: NavPathStack;
  @State order: myOrder[] = [];
  @StorageProp('personUid') personUid: string = '';
  @State spots: mySpot[] = [];
  @State isSearch:boolean=false;
  @State mineViewModel:MineViewModel=MineViewModel.getInstance();
  @Provide orderListData: ListDataSource<myOrderAdd> = this.mineViewModel.orderListData;
  @State searchListData: ListDataSource<myOrderAdd> = new ListDataSource();
  @State SpotNetWork:SpotNetFunc = SpotNetFunc.getInstance()
  @State waitListData: ListDataSource<myOrderAdd> =this.mineViewModel.waitListData;

  async aboutToAppear() {
        this.mineViewModel.orderDeal(this.personUid)
  }

  @Builder
  listData(data:ListDataSource<myOrderAdd>){
    Column() {
      List({space:Constants.SMALL_SPACE}) {
        LazyForEach(data, (or: myOrderAdd) => {
          ListItem() {
            OrderItem({ item: or, reviewname: or.spotname })
          }
          .onClick(()=>{
            this.mineViewModel.taskPoolExecuteQuery(or.spotname).then((res) => {
              if(res.length !== 0){
                buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_ATTRACTIONDETAILPAGE,new Object({item:res[0]}))
              }
            })
          })
        },(or: myOrderAdd, index: number) => JSON.stringify(or) + Math.random() + index)
        // }
      }.scrollBar(BarState.Off)
      Text('已经到底了').fontSize(20).fontColor($r('app.color.page_background_grey'))
    }.height('100%')
  }
  build() {
    NavDestination() {
      Column() {
        Row() {
          Image($r('app.media.ic_back'))
            .width($r('app.float.md_topic_width'))
            .onClick(() => {
              this.appPathStack.pop()
              }).margin({right:10})
          Search({ placeholder: '搜索我的订单' })
            .onSubmit((val) => {
              this.isSearch = true
              this.searchListData.notifyDataDeleteAll()
              for (let index = 0; index < this.orderListData.totalCount(); index++) {
                const res = this.orderListData.getData(index)
                if (res.spotname.includes(val)) {
                  this.searchListData.pushData(res)
                }
              }
              this.searchListData.notifyDataReload()
            }).width('80%')
          }
          .width('100%')
          .height(Constants.TOP_HEIGHT_PAGE)

          Tabs() {
            TabContent() {
              Scroll() {
                if(this.isSearch==true){
                  this.listData(this.searchListData)
                }else{
                  this.listData(this.orderListData)
                }
              }.scrollBar(BarState.Off)
              .edgeEffect(EdgeEffect.Spring)
            }
            .tabBar('全部订单')
            TabContent() {
              Scroll() {
                this.listData(this.waitListData)
              }.scrollBar(BarState.Off)
              .edgeEffect(EdgeEffect.Spring)
            }
            .tabBar('待使用')
          }.barHeight(Constants.BAR_HEIGHT_PAGE)
        }
        .padding({left:Constants.PADDING_PAGE,right:Constants.PADDING_PAGE,top:Constants.PADDING_PAGE})
        .width('100%')
        .height('100%')
        .backgroundColor($r('app.color.page_background_grey'))
    }.hideTitleBar(true)
    .margin({top:Constants.HEADER_HEIGHT_PAGE})
  }
}
@Builder
export function MyOrderPageBuilder() {
  MyOrderPage()
}
const builderName = BuilderNameConstants.LOGIN_MYORDER;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(MyOrderPageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
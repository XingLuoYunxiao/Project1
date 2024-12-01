import { BrowsingHistory } from "../model/BrowsingHistory";
import { HistoryAdd } from "../model/HistoryAdd";
import { mySpot } from "../model/mySpot";
import { CollectHistoryItem } from "../view/CollectHistoryItem";
import { ListDataSource } from "../service/ListDataSource";
import { MineViewModel } from "../service/MineViewModel";
import auth from "@hw-agconnect/auth";
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule";
import Constants from "../common/constants/Constants";
import { SpotNetFunc } from "travel/src/main/ets/service/SpotNetFunc";
import { MyCalendar ,CalendarData} from "../view/MyCalendar";

@Component
export struct BrowsHistoryPage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @State manage:string='管理'
  @StorageLink('personUid') personUid: string = ''
  @State historyitem:BrowsingHistory[]=[]
  @State spots: mySpot[] = []
  @State isChecked:boolean=false;
  @State mineViewModel:MineViewModel=MineViewModel.getInstance();
  @State historyspotListData: ListDataSource<HistoryAdd> = this.mineViewModel.historyspotListData
  @State historypoemListData: ListDataSource<HistoryAdd> = this.mineViewModel.historypoemListData
  @State SpotNetWork:SpotNetFunc = SpotNetFunc.getInstance()
  @State calendarspotListData:ListDataSource<HistoryAdd> = new ListDataSource();


  @Builder
bottomDelete(){
    Row(){
      Checkbox()
        .select(this.isChecked)
        .onChange((isChecked: boolean) => {
          if(isChecked==true){
          }else{
          }
        })
      Text('全选')
      Blank()
      Button('清空全部')
      Button('删除')
      // .onClick(()=>{
      //   for (let index = 0; index < this.historyspotListData.totalCount(); index++) {
      //
      //   }
      // })
    }
    .backgroundColor(Color.White)
    .visibility(this.manage=='完成'?Visibility.Visible:Visibility.None).width('100%')
}


  build() {
    NavDestination() {
      Stack(){
        Column() {
          Row() {
            Image($r('app.media.ic_back')).width($r('app.float.md_topic_width')).onClick(() => {
              this.appPathStack.pop()
            })
            Text('浏览历史')
            Text(this.manage).onClick(() => {
              if (this.manage == '管理') {
                this.manage = '完成'
              } else {
                this.manage = '管理'
              }

            })
          }
          .height(Constants.TOP_HEIGHT_PAGE)
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          MyCalendar({onCalendarClick: (item: CalendarData): Promise<void> => this.mineViewModel.historyDeal(this.personUid,
            item)})
          Tabs() {
            TabContent() {
              Column() {
                List({space:Constants.SMALL_SPACE}) {
                  LazyForEach(this.historyspotListData, (history: HistoryAdd) => {
                    ListItem() {
                      Row() {
                        if (this.manage == '完成') {
                          Checkbox()
                            .select(this.isChecked)
                            .onChange((isChecked: boolean) => {
                              history.isChoose = isChecked
                            })
                        }
                        CollectHistoryItem({ item: history })
                      }
                    }.onClick(()=>{
                      this.SpotNetWork.search(history.spotname)
                      buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_ATTRACTIONDETAILPAGE,new Object({item:this.SpotNetWork.searchResult[0]}))
                    })
                  }, (history: HistoryAdd) => JSON.stringify(history))
                }.scrollBar(BarState.Off)
                Text('已经到底了').fontSize(20).fontColor($r('app.color.page_background_grey'))
              }.height('100%')
            }.tabBar('遗迹景点')

            TabContent() {
              Column() {
                List({space:Constants.SMALL_SPACE}) {
                  LazyForEach(this.historypoemListData, (history: HistoryAdd) => {
                    ListItem() {
                      Row() {
                        if (this.manage == '完成') {
                          Checkbox()
                            .select(this.isChecked)
                            .onChange((isChecked: boolean) => {
                              history.isChoose = isChecked
                            })
                        }
                        CollectHistoryItem({ item: history })
                      }
                    }.onClick(()=>{

                    })
                  }, (history: HistoryAdd) => JSON.stringify(history))
                }.scrollBar(BarState.Off)
                Text('已经到底了').fontSize(20).fontColor($r('app.color.page_background_grey'))
              }
            }.tabBar('诗词歌赋')
          }
          .layoutWeight(1)
          .barHeight(Constants.BAR_HEIGHT_PAGE)
        }.padding({left:Constants.PADDING_PAGE,right:Constants.PADDING_PAGE,top:Constants.PADDING_PAGE})
        this.bottomDelete()
      }.alignContent(Alignment.Bottom)
    }
    .hideTitleBar(true)
    .backgroundColor($r('app.color.page_background_grey'))
    .margin({top:Constants.HEADER_HEIGHT_PAGE,bottom:Constants.HEADER_HEIGHT_PAGE})
  }
}

@Builder
export function BrowsHistoryPageBuilder() {
  BrowsHistoryPage()
}

const builderName = BuilderNameConstants.LOGIN_BROWSHISTORYPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(BrowsHistoryPageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}

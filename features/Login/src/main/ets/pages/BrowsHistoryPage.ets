import { BrowsingHistory } from "../model/BrowsingHistory";
import { HistoryAdd } from "../model/HistoryAdd";
import { mySpot } from "../model/mySpot";
import { ListDataSource } from "../service/ListDataSource";
import { MineViewModel } from "../service/MineViewModel";
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule";
import Constants from "../common/constants/Constants";
import { SpotNetFunc } from "travel/src/main/ets/service/SpotNetFunc";
import { MyCalendar ,CalendarData} from "../view/MyCalendar";
import { CollectionAdd } from "../model/CollectionAdd";
import { promptAction } from "@kit.ArkUI";

@Component
struct CollectHistoryItem {
  @ObjectLink item:CollectionAdd|HistoryAdd
  build() {
    Row() {
      Image(this.item.spot_img).width(80).height(80).margin({left:10,right:10})
      Text(this.item.spotname)
    }.borderRadius(20)
    .width('100%')
    .backgroundColor(Color.White)
    .padding(12)
  }
}

@Component
export struct BrowsHistoryPage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @State manage:string='管理'
  @StorageProp('personUid') personUid: string = ''
  @State historyitem:BrowsingHistory[]=[]
  @State spots: mySpot[] = []
  @State isChecked:boolean=false;
  @State mineViewModel:MineViewModel=MineViewModel.getInstance();
  @State historyspotListData: ListDataSource<HistoryAdd> = this.mineViewModel.historyspotListData
  @State historypoemListData: ListDataSource<HistoryAdd> = this.mineViewModel.historypoemListData
  @State SpotNetWork:SpotNetFunc = SpotNetFunc.getInstance()
  @State calendarspotListData:ListDataSource<HistoryAdd> = new ListDataSource();
  @State deletecount:number=0

  @Builder
  bottomDelete(){
    Row(){
      CheckboxGroup({ group: 'checkboxGroup' })
        .checkboxShape(CheckBoxShape.CIRCLE)
        .selectedColor(Color.Blue)
        .onChange((itemName: CheckboxGroupResult) => {
          console.info("checkbox group content" + JSON.stringify(itemName))
          if(itemName.status==SelectStatus.All){
            this.deletecount=this.historyspotListData.totalCount()
            for (let index = this.historyspotListData.totalCount()-1; index >= 0; index--) {
              const cur=this.historyspotListData.getData(index)
              cur.isChoose=true
            }
          }
        })
        .mark({
          strokeColor:Color.White,
          size: 40,
          strokeWidth: 2
        })
        .unselectedColor(Color.Gray)
      Text('全选')
      Blank()
      Button('清空全部')
      Button(`删除${this.deletecount}`).onClick(()=>{
        for (let index = this.historyspotListData.totalCount()-1; index >= 0; index--) {
          const cur=this.historyspotListData.getData(index)
          if(cur.isChoose==true){
            this.mineViewModel.historydelete(cur.id,this.personUid);
            this.mineViewModel.historyspotListData.deleteData(index);
            this.deletecount=0
          }
        }
        this.manage='管理'
        promptAction.showToast({message: '删除成功', duration: 2000})
      })
    }
    .padding({left:20,right:20,top:15,bottom:15})
    .backgroundColor(Color.White)
    .width('100%')
    .visibility(this.manage=='退出管理'?Visibility.Visible:Visibility.None)
  }

  async aboutToAppear() {
    let currentDate = new Date();
    // 增加一天到当前日期
    let tomorrow = new Date(currentDate);
    tomorrow.setDate(currentDate.getDate() + 1);

    // 设置时间为0点
    tomorrow.setHours(0, 0, 0, 0);
    this.mineViewModel.historyDeal(this.personUid,tomorrow)
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
                this.manage = '退出管理'
              } else {
                this.manage = '管理'
              }

            })
          }
          .height(Constants.TOP_HEIGHT_PAGE)
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          MyCalendar({onCalendarClick: (item: Date): Promise<void> => this.mineViewModel.historyDeal(this.personUid,item)})
          Tabs() {
            TabContent() {
              Column() {
                List({space:Constants.SMALL_SPACE}) {
                  LazyForEach(this.historyspotListData, (history: HistoryAdd) => {
                    ListItem() {
                      Row() {
                          Checkbox({ name:history.spotname, group: 'checkboxGroup' })
                            .onChange((isChecked: boolean) => {
                              if (isChecked) {
                                this.deletecount++
                              }else this.deletecount--
                              history.isChoose=isChecked
                            })
                            .mark({
                              strokeColor:Color.White,
                              size: 50,
                              strokeWidth: 5
                            })
                            .visibility(this.manage=='退出管理'?Visibility.Visible:Visibility.None)
                        CollectHistoryItem({ item: history })
                      }
                    }
                    .onClick(()=>{
                      this.mineViewModel.taskPoolExecuteQuery(history.spotname).then((res) => {
                        if(res.length !== 0){
                          buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_ATTRACTIONDETAILPAGE,new Object({item:res[0]}))
                        }
                      })
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
                        if (this.manage == '退出管理') {
                          Checkbox()
                            .select(this.isChecked)
                            .onChange((isChecked: boolean) => {
                              history.isChoose = isChecked
                            })
                        }
                        CollectHistoryItem({ item: history })
                          // .onClick(()=>{
                          //   this.mineViewModel.taskPoolExecuteQuery(history.spotname).then((res) => {
                          //     if(res.length !== 0){
                          //       buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_ATTRACTIONDETAILPAGE,new Object({item:res[0]}))
                          //     }
                          //   })
                          // })
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

import { BrowsingHistory } from "../model/BrowsingHistory";
import { HistoryAdd } from "../model/HistoryAdd";
import { mySpot } from "../model/mySpot";
import { CollectHistoryItem } from "../view/CollectHistoryItem";
import { ListDataSource } from "../service/ListDataSource";
import { MineViewModel } from "../service/MineViewModel";
import auth from "@hw-agconnect/auth";
import { BuilderNameConstants, RouterModule } from "routermodule";
import Constants from "../common/constants/Constants";

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

  @Builder
bottomDelete(){
    Row(){
      Checkbox()
        .select(this.isChecked)
      Text('全选')
      Blank()
      Button('清空全部')
      Button('删除').onClick(()=>{
        // for (let index = 0; index < this.historyitem.length; index++) {
        //   if(this.historyListData.getData(index).isChoose==true){
        //     this.historyListData.deleteData(index)
        //   }
        // }
      })
    }.width('100%')
}

  async aboutToAppear() {
    auth.getCurrentUser().then(user=>{
      if(user){
        this.mineViewModel.historyDeal(user.getUid())
      }
    })
  }

  build() {
    NavDestination() {
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

        Tabs() {
          TabContent() {
            Column() {
              List({space:Constants.SMALL_SPACE}) {
                LazyForEach(this.mineViewModel.historyspotListData, (history: HistoryAdd) => {
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
                  }
                }, (history: HistoryAdd) => JSON.stringify(history))
              }.scrollBar(BarState.Off)

              Text('已经到底了').fontSize(20).fontColor($r('app.color.page_background_grey'))
            }

            if (this.manage == '完成') {
              this.bottomDelete()
            }
          }.tabBar('遗迹景点')

          TabContent() {
            Column() {
              List({space:Constants.SMALL_SPACE}) {
                LazyForEach(this.mineViewModel.historypoemListData, (history: HistoryAdd) => {
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
                  }
                }, (history: HistoryAdd) => JSON.stringify(history))
              }.scrollBar(BarState.Off)
              Text('已经到底了').fontSize(20).fontColor($r('app.color.page_background_grey'))
            }
          }.tabBar('诗词歌赋')
        }.barHeight(Constants.BAR_HEIGHT_PAGE)
      }.padding({left:Constants.PADDING_PAGE,right:Constants.PADDING_PAGE,top:Constants.PADDING_PAGE})
    }
    .hideTitleBar(true)
    .backgroundColor($r('app.color.page_background_grey'))
    .margin({top:Constants.HEADER_HEIGHT_PAGE})
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

import "map/src/main/ets/pages/MapViewPage";
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule";
import { LazyDataSource } from "utils";
import Constants from "../constants/Constants";
import { otherItemList } from "../model/Attraction";
import { Spot } from "../model/Spot";
import { SpotNetFunc } from "../service/SpotNetFunc";
import { router } from "@kit.ArkUI";

//评分数组，最高10分
const scoreList: number[] = [9.7, 10.0, 8.8, 9.5, 9.2, 9.9, 9.0];


export interface  LoadParams{
  param1: string;
  param2: Spot;
}

@Component
export struct FamousPlacePage {
  @Consume('travelPathStack') travelPathStack: NavPathStack;
  @Consume('appPathStack') appPathStack: NavPathStack;
  @State value:object = new Object()
  @State spotNetWork: SpotNetFunc = SpotNetFunc.getInstance();
  @State category: string = "";
  @State spotDataSource: LazyDataSource<Spot> = this.spotNetWork.allSpotsDataSource
  scroller: Scroller = new Scroller()

  @Builder itemFoot(){
    Column(){
      Text('-------到底了--------')
        .fontSize(10)
        .backgroundColor(Color.White)
        .width('100%')
        .textAlign(TextAlign.Center)
        .height(30)
        .margin({top:5})
    }
  }

  async aboutToAppear(): Promise<void> {
    this.category = JSON.parse(JSON.stringify(this.value)).category as string
    //this.category = this.appPathStack.getParamByName('FamousPlacePage')[0] as string
  }



  build() {
    NavDestination(){
      Row({space:5}){
        Image($r('app.media.ic_back'))
          .width(30)
          .height(30)
          .onClick( () => {
            this.appPathStack.pop();
          })
        Search({placeholder:"搜索想要去的景点"})
          .height(30)
          .layoutWeight(1)
          .onClick( () => {
            buildRouterModel(RouterNameConstants.ENTRY_HAP,  BuilderNameConstants.TRAVEL_SEARCHPAGE)
            //this.appPathStack.pushPathByName('SearchPage', true)
          })
        Badge({count: 1, position: BadgePosition.RightTop, style:{fontSize:14, badgeColor: Color.Red}}){
          Image($r('app.media.ic_public_email'))
            .width(24)
        }
      }
      .margin({top:5})
      .width('100%')
      .height(30)

      Tabs(){
        TabContent(){
          Column(){
            WaterFlow({footer: this.itemFoot(), scroller: this.scroller}){
              LazyForEach( this.spotDataSource, (item: Spot, index) => {
                FlowItem(){
                  Column(){
                    this.FamousItem(item, index)
                    Divider()
                      .color(Color.Gray)
                      .height(1)
                      .width('100%')
                  }
                }
                /*// 用来避免有加载效果造成的卡顿
                .onAppear(() => {
                  // 即将触底时提前增加数据
                  if (index + 5 == this.spotDataSource.totalCount()) {
                    for (let i = 0; i < 5; i++) {
                      this.spotDataSource.addData(this.spotDataSource.totalCount(), new Spot())
                    }
                    console.log('waterFlow ' + '即将触底了')
                  }
                })*/
              })
            }
            .scrollBar(BarState.Off)
            .width('100%')
          }
          .width('95%')
          .height('100%')
        }.tabBar('推荐')
        TabContent(){

        }.tabBar('地图')
        TabContent(){

        }.tabBar('自由行')

      }
    }
    .backgroundColor($r('app.color.app_background_color'))
    .hideTitleBar(true)
    .margin({top:Constants.HEADER_HEIGHT_PAGE})
  }

  @Builder
  FamousItem(spot: Spot, index:number){
    Row(){
      Column(){
        Image($r(spot.image))
          .width('100%')
          .borderRadius(10)
          .height(210)
      }
      .width('40%')
      .padding(8)
      .alignItems(HorizontalAlign.Center)

      Column(){
        Text(spot.name)
          .fontSize(20)
          .padding({top:5, bottom:10})
          .fontColor(Color.Black)
          .fontWeight(500)
        Text(){
          Span(scoreList[index%7].toFixed(1) + '分')
          .fontSize(16)
          .fontColor(Color.White)
          }
          .backgroundColor('#ff52bdd7')
          .fontSize(14)
          .padding(5)
          .borderRadius(10)
          .margin({bottom:8})
        Text(spot.summary)
          .fontSize(14)
          .fontColor(Color.Gray)
          .textOverflow({overflow: TextOverflow.Ellipsis})
          .maxLines(3)

        Row(){
          Column({space:8}) {
            Row(){
              Image($r('app.media.hotel_icon'))
                .width(16)
                .height(16)
              Text(`【${otherItemList[index%7].hotel}】`)
                .fontSize(14)
                .fontColor(Color.Gray)
            }
            Row(){
              Image($r('app.media.guide_icon'))
                .width(16)
                .height(16)
              Text(`【${otherItemList[index%7].guide}】`)
                .fontSize(14)
                .fontColor(Color.Gray)
            }
            Text(`${otherItemList[index%7].people}人出行`)
              .fontSize(14)
              .fontColor(Color.Gray)
          }
          .alignItems(HorizontalAlign.Start)
          Column(){
            Button('地图服务')
              .type(ButtonType.Capsule)
              .fontSize(16)
              .backgroundColor(Color.Orange)
              .fontColor(Color.White)
              /*.onClick(() => { // 点击跳转到其他共享包中的页面
                try {
                  this.getUIContext().getRouter().pushNamedRoute({
                    name: 'mapView',
                    params: {
                      data1: 'message',
                      data2: {
                        data3: [123, 456, 789]
                      }
                    }
                  })
                } catch (e) {
                  console.log("mapTestTag ", e)
                }
              })*/
              .margin({right:10})
              .onClick(() => {
                buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.MAP_MAPVIEWPAGE, new Object({Object:spot}));
                //buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.MAP_MAPVIEWPAGE);
              })
            Button('AI导游')
              .type(ButtonType.Capsule)
              .fontSize(16)
              .backgroundColor(Color.Orange)
              .fontColor(Color.White)
              .onClick( () => {
                let params: LoadParams = {
                  param1: "SpotDetailPage", // 第一个参数
                  param2: spot  // 第二个参数
                };
                buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_LOADINGANIMATION, new Object({params:params}));
                //this.appPathStack.pushPathByName('LoadingAnimation', params)
              })
          }
          .alignItems(HorizontalAlign.End)
          .justifyContent(FlexAlign.End)
          .height(80)
          .layoutWeight(1)

        }
        .margin({top:8})
      }
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
      .height(230)
      .padding(10)
      .layoutWeight(1)
    }
    .backgroundColor(Color.White)
    .height(250)
    .width('100%')
    .padding(10)
  }

}

@Builder
export function FamousPlacePageBuilder(value: object){
  FamousPlacePage({value:value})
}


const builderName = BuilderNameConstants.TRAVEL_FAMOUSPLACEPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(FamousPlacePageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}

import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from "routermodule"
import { LoadingStatus, LocationUtil } from "utils"
import Logger from "utils/src/main/ets/utils/Logger"
import Constants from "../constants/Constants"
import { Spot } from "../model/Spot"
import { CloudStorageService } from "../service/CloudStorageService"
import { SpotNetFunc } from "../service/SpotNetFunc"
import { NearbyItem } from "./NearbyItem"


@Component
export struct NearbyAttraction {
  @Consume('appPathStack') appPathStack: NavPathStack
  @State spotNetWork: SpotNetFunc = SpotNetFunc.getInstance()
  @State locationUtil: LocationUtil = LocationUtil.getInstance()
  @State currentCityName: string = '当前城市'
  @State CityNameJudge: boolean = false
  spotDistanceMap: Map<string, string> = new Map()

  async aboutToAppear(): Promise<void> {

    this.spotNetWork.loadNearbyAttractions().then(()=>{
      this.spotNetWork.getAllDistance()
      this.spotDistanceMap = this.spotNetWork.spotDistanceMap
    })
    this.getCurrentCityName()
  }

  getCurrentCityName(): void{
    this.locationUtil.getCityName().then(cityName => {
      this.currentCityName = cityName
      this.CityNameJudge = true
    })
  }

  build() {
    if( (this.spotNetWork.nearbyLoadingStatus === LoadingStatus.LOADING)||
    this.spotNetWork.nearbyLoadingStatus === LoadingStatus.OFF){
      LoadingProgress()
        .width(30)
        .height(30)
    }else if( this.spotNetWork.nearbyLoadingStatus === LoadingStatus.SUCCESS){
      Column(){
        Row(){
          Row(){
            Image($r('app.media.nearby_icon'))
              .width(24)
              .height(24)
              .margin({right:5})
            Text('附近景点')
              .fontSize(18)
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Center)
          //.backgroundColor('#ff5ad47b')
          .borderRadius(Constants.BORDER_RADIUS_MD)
          .height(40)
          .padding(5)
          Blank()
          Row(){
            Image($r('app.media.location_icon'))
              .width(20)
              .height(20)
              .margin({right:5})
            if( this.CityNameJudge){
              Text(this.currentCityName)
                .fontSize(14)
                .fontWeight(500)
            }else{
              Text('定位中')
                .fontSize(14)
                .fontWeight(500)
            }
          }
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')

        List() {
          ForEach(this.spotNetWork.nearbySpots, (item: Spot) => {
            ListItem(){
              NearbyItem({attraction: item, spotDistanceMap: this.spotDistanceMap})
                .reuseId('nearby')
            }
            .onClick(() => {
              buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_ATTRACTIONDETAILPAGE, new Object({item: item}))
              //this.appPathStack.pushPathByName('AttractionDetailPage', item)
            })

          })
        }
        //.divider({strokeWidth:1, color: Color.Gray})
        //.edgeEffect(EdgeEffect.Spring, {alwaysEnabled:true})
        .scrollBar(BarState.Off)
        .width('100%')
        .listDirection(Axis.Vertical)
        .margin({bottom: "15%"})

      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .height('100%')
    }
  }


}
import { LoadingStatus, LocationUtil } from "@ohos/Utils"
import Logger from "@ohos/Utils/src/main/ets/utils/Logger"
import Constants from "../constants/Constants"
import { Spot } from "../model/Spot"
import { SpotNetFunc } from "../service/SpotNetFunc"


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
              this.NearbyItem(item)
            }
            .onClick(() => {
              this.appPathStack.pushPathByName('AttractionDetailPage', item)
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

  @Builder
  NearbyItem(attraction: Spot) {
    Row() {
      Column() {
        if ($r(`${attraction.image}`) !== undefined) {
          Image($r(`${attraction.image}`))
            .width('100%')
            .height(60)
        }
        Text(attraction.name)
          .fontSize(14)
          .padding({ top: 5 })
          .fontColor(Color.Black)
          .fontWeight(500)
      }
      .width('40%')
      .padding(8)
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text(`距离 ${this.spotDistanceMap.get(attraction.id)}km`)
          .fontSize(16)
        Text(attraction.summary)
          .fontSize(14)
          .padding({ top: 5 })
          .fontColor(Color.Gray)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(3)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.End)

    }
    .borderRadius(Constants.BORDER_RADIUS_MD)
    .backgroundColor(Color.White)
    .height(100)
    .width('100%')
    .padding(10)
    .margin(5)

  }
}
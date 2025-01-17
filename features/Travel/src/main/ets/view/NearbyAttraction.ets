import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from "routermodule"
import { BreakpointConstants, BreakpointType, LoadingStatus, LocationUtil } from "utils"
import Logger from "utils/src/main/ets/utils/Logger"
import Constants from "../constants/Constants"
import { Spot } from "../model/Spot"
import { CloudStorageService } from "../service/CloudStorageService"
import { SpotNetFunc } from "../service/SpotNetFunc"
import { NearbyItem } from "./NearbyItem"
import { promptAction } from "@kit.ArkUI"
import { Classification } from "./Classficiation"

@Component
export struct NearbyAttraction {
  @Consume('appPathStack') appPathStack: NavPathStack
  @State spotNetWork: SpotNetFunc = SpotNetFunc.getInstance()
  @State locationUtil: LocationUtil = LocationUtil.getInstance()
  @State currentCityName: string = '当前城市'
  @State CityNameJudge: boolean = false
  @StorageLink('personUid') personUid: string = '';
  @StorageLink('currentWidthBreakpoint') currentWidthBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;

  spotDistanceMap: Map<string, string> = new Map()
  private retryTimer: number = -1
  private readonly RETRY_INTERVAL: number = 1000 // 1 second
  private count: number = 0 // 记录尝试次数

  async loadData(): Promise<void> {
    try {
      await this.spotNetWork.loadNearbyAttractions()
      await this.spotNetWork.getAllDistance()
      this.spotDistanceMap = this.spotNetWork.spotDistanceMap

      // 如果获取成功，清除定时任务
      if (this.retryTimer !== -1) {
        clearInterval(this.retryTimer)
        this.retryTimer = -1
      }
    } catch (error) {
      Logger.error('获取附近景点数据失败', error)

      // 如果获取失败，设置定时任务重新加载数据
      if (this.retryTimer === -1 && this.count < 3) {
        this.retryTimer = setInterval(() => {
          Logger.info('重新获取附近景点数据')
          this.loadData()
        }, this.RETRY_INTERVAL)
      }
    }
  }

  async aboutToAppear(): Promise<void> {
    this.loadData()
    this.getCurrentCityName()
  }

  aboutToDisappear(): void {
    //清除定时任务
    if (this.retryTimer !== -1) {
      clearInterval(this.retryTimer)
      this.retryTimer = -1
    }
  }

  getCurrentCityName(): void {
    this.locationUtil.getCityName().then(cityName => {
      this.currentCityName = cityName
      this.CityNameJudge = true
    })
  }

  build() {
    if ((this.spotNetWork.nearbyLoadingStatus === LoadingStatus.LOADING) ||
      this.spotNetWork.nearbyLoadingStatus === LoadingStatus.OFF) {
      LoadingProgress()
        .width(30)
        .height(30)
    } else if (this.spotNetWork.nearbyLoadingStatus === LoadingStatus.SUCCESS) {
      Column() {
        Row() {
          Row() {
            Image($r('app.media.nearby_icon'))
              .width(24)
              .height(24)
              .margin({ right: 5 })
            Text('附近景点')
              .fontSize(18)
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .borderRadius(Constants.BORDER_RADIUS_MD)
          .height(40)
          .padding(5)
          Blank()
          Row() {
            Image($r('app.media.location_icon'))
              .width(20)
              .height(20)
              .margin({ right: 5 })
            if (this.CityNameJudge) {
              Text(this.currentCityName)
                .fontSize(14)
                .fontWeight(500)
            } else {
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
            ListItem() {
              NearbyItem({ attraction: item, spotDistanceMap: this.spotDistanceMap })
                .reuseId('nearby')
            }
            .margin({ left: 5, right: 5 })
            .onClick(() => {
              if (item.id && this.personUid != '') {
                this.spotNetWork.addBrowse(item.id, this.personUid);
              } else {
                promptAction.showToast({ message: '请先登录' })
              }
              buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_ATTRACTIONDETAILPAGE, new Object({ item: item }))
            })
          })
        }
        .nestedScroll({
          scrollForward: NestedScrollMode.PARENT_FIRST,
          scrollBackward: NestedScrollMode.SELF_FIRST
        })
        .lanes(new BreakpointType({ sm: 1, md: 1, lg: 2 }).getValue(this.currentWidthBreakpoint))
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
        .listDirection(Axis.Vertical)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
  }
}
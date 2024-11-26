import { BuilderNameConstants, RouterModule, RouterNameConstants } from "routermodule";
import { Spot } from "travel";
import { map, mapCommon, MapComponent, navi, site } from "@kit.MapKit";
import { LocationUtil } from "utils";
import { RouteType, SearchSiteModel } from "../service/SearchSiteModel";
import { geoLocationManager } from "@kit.LocationKit";
import Logger from "utils/src/main/ets/utils/Logger";
import { AsyncCallback } from "@kit.BasicServicesKit";
import { ColumnTab } from "../service/ColumnTab";
import { TabViewModel } from "../service/TabViewModel";
import { RouteContentView } from "../view/RouteContentView";
import { CommonConstants } from "../constants/CommonConstants";

@Component
export struct RouterPlanView {
  @State value: object = new Object();
  @State terminalPoint: string | undefined = '';
  @StorageLink('routes') routes: Array<navi.Route> | undefined = [];
  @State sites: Array<site.Site> | undefined = [];
  @State isShow: boolean = false;
  @State isRouteShow: boolean = false;
  @State isCallBack: boolean = false;
  @State locationUtil: LocationUtil = LocationUtil.getInstance();
  @Prop spot: Spot
  @State mapController?: map.MapComponentController | undefined = undefined;
  @State routeType: RouteType = RouteType.DRIVING;

  private tabList: ColumnTab[] = new TabViewModel().getTabList();
  private tabsController: TabsController = new TabsController();
  @State currentIndex: number = 0;

  private searchSiteModel: SearchSiteModel = new SearchSiteModel();
  private mapOptions?: mapCommon.MapOptions;
  private callback?: AsyncCallback<map.MapComponentController>;
  private style: mapCommon.MyLocationStyle = {
    anchorU: 0.5,
    anchorV: 0.5,
    radiusFillColor: 0xff00FFFFFF,
    displayType: mapCommon.MyLocationDisplayType.FOLLOW
  };

  async aboutToAppear(): Promise<void> {
    this.spot = JSON.parse(JSON.stringify(this.value)).Object as Spot

    this.mapOptions = {
      position: {
        target: {
          latitude: this.spot.location.latitude,
          longitude: this.spot.location.longitude
        },
        zoom: CommonConstants.OUTER_ZOOM
      }
    };

    // 地图初始化的回调
    this.callback = async (err, mapController) => {
      if (!err) {
        // 获取地图的控制器类，用来操作地图
        this.mapController = mapController;
        this.mapController.on('mapLoad', () => {
          Logger.info('mapLoad success');
        });
        this.abilityEnabled();
        mapController.setMyLocationStyle(this.style);
        this.mapController.on('mapClick', ()=> {
          this.isRouteShow = !this.isRouteShow;
        })
        this.isCallBack = true;
      }
    };

    this.InitRoute(this.routeType)

  }

  async InitRoute(type: RouteType){
    await this.locationUtil.getLocation(this.mapController).then(async (location: geoLocationManager.Location) => {
      //获取附近具体的地点
      /*let position: mapCommon.LatLng = {
        longitude: location.longitude,
        latitude: location.latitude
      };
      await this.searchSiteModel.getNearByLocation(position, this.spot.name)
        .then((nearByResult: site.NearbySearchResult | undefined) => {
          if (nearByResult) {
            this.sites = nearByResult.sites;
          }
        })*/

      if( this.sites !== undefined){
        await this.searchSiteModel.getRoutes(location, this.spot.location, type)
          .then(async (routeResult: navi.RouteResult | undefined) => {
            if (routeResult) {
              Logger.info('Route plan success' + JSON.stringify(routeResult));
              this.routes = routeResult.routes;
              Logger.info('Routes: ' + JSON.stringify(this.routes));
            }
          })
      }
      this.isShow = true;
    })
  }

  async abilityEnabled(): Promise<void> {
    this.mapController?.setMyLocationEnabled(true);
    this.mapController?.setMyLocationControlsEnabled(true);
    this.mapController?.setTrafficEnabled(true);
    this.mapController?.setBuildingEnabled(true);
    /*if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM) {
      this.mapController?.setZoomControlsEnabled(false);
    }
    this.mapController?.moveCamera(map.zoomTo(MapConstants.ZOOM));*/
  }

  @Builder
  TabBuilder(item: ColumnTab, targetIndex: number) {
    Row() {
      Image(item.getIconSelected())
        .visibility(this.currentIndex === targetIndex ? Visibility.Visible : Visibility.None)
        .height(20)
        .width(24)
      Text(item.getName())
        .fontSize(18)
        .fontColor((this.currentIndex === targetIndex) ?
        $r('app.color.tab_font_selected') : $r('app.color.tab_font_unselected'))
    }
    .onClick(async () => {
      this.currentIndex = targetIndex;
      this.routeType = targetIndex;
      await this.InitRoute(this.routeType)
      this.tabsController.changeIndex(this.currentIndex);
    })
    .justifyContent(FlexAlign.Center)
    .backgroundColor((this.currentIndex === targetIndex) ?
    $r('app.color.tab_selected') : '#80d2d0d0')
    .borderRadius($r('app.float.tab_border_radius'))
    .height($r('app.float.tab_row_height'))
    .width(100)
  }

  @Builder
  myBuilder(){
    Column({space:5}) {
      Tabs({ barPosition: BarPosition.Start, controller: this.tabsController }) {
        TabContent() {
          if( this.isCallBack){
            RouteContentView({ mapController: this.mapController, columnHeight: 270 })
          }
        }
        .tabBar(this.TabBuilder(this.tabList[0], 0))

        TabContent() {
          if( this.isCallBack){
            RouteContentView({ mapController: this.mapController, columnHeight: 270 })
          }
        }
        .tabBar(this.TabBuilder(this.tabList[1], 1))

        TabContent() {
          if( this.isCallBack){
            RouteContentView({ mapController: this.mapController, columnHeight: 270 })
          }
        }
        .tabBar(this.TabBuilder(this.tabList[2], 2))

      }
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .barHeight(40)
      .width('100%')
      .padding(5)
      .scrollable(true)
      .barMode(BarMode.Scrollable)
    }
  }

  aboutToDisappear(): void {
    this.isRouteShow = false;
  }

  build() {
    NavDestination() {
      if (this.isShow) {
        Stack(){
          MapComponent({ mapOptions: this.mapOptions, mapCallback: this.callback })
            .width('100%')
            .height('100%')
            .onAppear( ()=>{
                this.isRouteShow = true;
            })
            .bindSheet($$this.isRouteShow, this.myBuilder(),{
              detents: [300, SheetSize.LARGE, 200],
              backgroundColor: Color.White,
              blurStyle: BlurStyle.Thick,
              showClose: false,
              enableOutsideInteractive: true,
              dragBar: true,
              preferType: SheetType.BOTTOM,
              //mode: SheetMode.OVERLAY,
            })

          Row() {
            Image($r('app.media.ic_back'))
              .width(40)
              .height(40)
              .margin({ left: 8 })
          }
          .position({ left: 0, top: 0 })
          .width('100%')
          .justifyContent(FlexAlign.Start)
          .height(42)
          .margin({ top: 20 })
          .onClick(() => {
            RouterModule.pop(RouterNameConstants.ENTRY_HAP);
            this.mapController?.clear()
          })

        }

      }
      else {
        Column() {
          Row({space: 10}){
            LoadingProgress()
              .width(30)
              .height(30)
            Text('加载中...')
              .height(30)
              .textAlign(TextAlign.Center)
          }
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .height('100%')
      }

    }
    .hideTitleBar(true)
    .margin({ top: $r('app.float.header_height_page') })
  }
}



@Builder
export function MapViewPageBuilder(value: object){
  RouterPlanView({value:value})
}

const builderName = BuilderNameConstants.MAP_ROUTEPLANVIEW;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(MapViewPageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}


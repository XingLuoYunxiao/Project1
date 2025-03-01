import { BuilderNameConstants, RouterModule, RouterNameConstants } from "routermodule";
import { Spot, Params, TravelPlan} from "travel";
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
  @Prop travelPlan: TravelPlan
  @State mapController?: map.MapComponentController | undefined = undefined;
  @State routeType: RouteType = RouteType.WALKING;

  private tabList: ColumnTab[] = new TabViewModel().getTabList();
  private tabsController: TabsController = new TabsController();
  @State currentIndex: number = 2;

  private searchSiteModel: SearchSiteModel = new SearchSiteModel();
  private mapOptions?: mapCommon.MapOptions;
  private callback?: AsyncCallback<map.MapComponentController>;
  private style: mapCommon.MyLocationStyle = {
    anchorU: 0.5,
    anchorV: 0.5,
    radiusFillColor: 0xff00FFFFFF,
    //displayType: mapCommon.MyLocationDisplayType.FOLLOW
  };

  async aboutToAppear(): Promise<void> {
    let params = JSON.parse(JSON.stringify(this.value)).params as Params
    this.spot = params.spot as Spot;
    this.travelPlan = params.travelPlan as TravelPlan;
    //给每个地点前面加上名称, 依次来更加精准匹配目的地
    this.travelPlan.sites = this.travelPlan.sites.map((site) => (`${this.spot.name}${site}`))
    //this.travelPlan.sites.map((site) => { console.log(`testTag ${site}`)})


    this.mapOptions = {
      position: {
        target: {
          latitude: this.spot.latitude ?? 0,
          longitude: this.spot.longitude ?? 0
        },
        zoom: CommonConstants.ZOOM
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

        //移动地图中心到 spot 的坐标
        if (this.spot.latitude && this.spot.longitude) {
          const spotLocation: mapCommon.LatLng = {
            latitude: this.spot.latitude,
            longitude: this.spot.longitude,
          };

          // 移动相机并缩放到合适的级别
          this.mapController.moveCamera(
            map.newCameraPosition({target:spotLocation, zoom: CommonConstants.ZOOM })
          );
        }

        let pointAnnotationOptions: mapCommon.PointAnnotationParams = {
          // 定义点注释图标锚点
          position: {
            latitude: this.spot.latitude!,
            longitude: this.spot.longitude!
          },
          // 定义点注释名称与地图poi名称相同时，是否支持去重
          repeatable: false,
          // 定义点注释的碰撞规则
          collisionRule: mapCommon.CollisionRule.NAME,
          // 定义点注释的标题，数组长度最小为1，最大为3
          titles: [{
            // 定义标题内容
            content: this.spot.name!,
            // 定义标题字体颜色
            color: 0xFF000000,
            // 定义标题字体大小
            fontSize: 20,
            // 定义标题描边颜色
            strokeColor: 0xFFFFFFFF,
            // 定义标题描边宽度
            strokeWidth: 2,
          }
          ],
          // 定义点注释的显示属性，为true时，在被碰撞后仍能显示
          forceVisible: true,
          // 定义碰撞优先级，数值越大，优先级越低
          priority: 3,
          // 定义点注释展示的最小层级
          minZoom: 2,
          // 定义点注释展示的最大层级
          maxZoom: 22,
          // 定义点注释是否可见
          visible: true,
          // 定义点注释叠加层级属性
          zIndex: 10
        }
        await this.mapController.addPointAnnotation(pointAnnotationOptions);

        this.mapController.on('mapClick', ()=> {
          this.isRouteShow = !this.isRouteShow;
        })
        this.isCallBack = true;
      }
    };

    this.InitRoute(this.routeType)

  }

  aboutToDisappear(): void {
    this.isRouteShow = false;
    this.mapController?.clear();
  }

  onPageHide(): void {
    this.mapController?.hide()
  }

  onPageShow(): void {
    this.mapController?.show()
  }

  InitRoute(type: RouteType){
    this.locationUtil.getLocation(this.mapController).then(async (location: geoLocationManager.Location) => {

      /*//获取景点附近具体的地点
      this.searchSiteModel.getNearByLocation(this.spot.location, this.spot.name)
        .then((nearByResult: site.NearbySearchResult | undefined) => {
          if (nearByResult) {
            this.sites = nearByResult.sites;
          }
        })*/

      //获取具体景点坐标位置, 数组所有景点坐标
      this.searchSiteModel.getSearchByText({latitude: this.spot.latitude!, longitude: this.spot.longitude!}, this.spot, this.travelPlan.sites)
        .then((nearByResult: site.NearbySearchResult | undefined) => {
          if (nearByResult) {
            this.sites = nearByResult.sites;
            if( this.sites !== undefined && this.sites.length > 0){
              this.searchSiteModel.getInnerRoutes({latitude: this.spot.latitude!, longitude: this.spot.longitude!}, this.sites, type)
                .then(async (routeResult: navi.RouteResult | undefined) => {
                  if (routeResult !== undefined) {
                    Logger.info('Route plan success' + JSON.stringify(routeResult));
                    this.routes = routeResult.routes;
                    Logger.info('Routes: ' + JSON.stringify(this.routes));
                    this.isShow = true;
                  }
                })
            }
          }
        })
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
      this.InitRoute(this.routeType)
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
        /*TabContent() {
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
        .tabBar(this.TabBuilder(this.tabList[1], 1))*/

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


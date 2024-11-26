import { RouterModule } from 'routermodule';
import { BuilderNameConstants } from 'routermodule';
import { MapComponent, mapCommon, map, navi } from '@kit.MapKit';
import { AsyncCallback } from '@kit.BasicServicesKit';
import { Spot } from 'travel';
import { CommonConstants } from '../constants/CommonConstants';

@Component
export struct NavigationPage {
  private TAG = "HuaweiMapDemo";
  private mapOptions?: mapCommon.MapOptions;
  private callback?: AsyncCallback<map.MapComponentController>;
  private mapController?: map.MapComponentController;
  private mapEventManager?: map.MapEventManager;
  @Prop spot:Spot
  private style: mapCommon.MyLocationStyle = {
    anchorU: 0.5,
    anchorV: 0.5,
    radiusFillColor: 0xff00FFFFFF,
    displayType: mapCommon.MyLocationDisplayType.FOLLOW
  };

  async testDrivingRoutes(): Promise<navi.RouteResult | undefined>{
    let params: navi.DrivingRouteParams = {
      // 起点的经纬度
      origins: [{
        "latitude": 34.982129213545843,
        "longitude": 108.27745557768591
      }],
      // 终点的经纬度
      destination: {
        "latitude": this.spot.location.latitude,
        "longitude": this.spot.location.longitude
      },
      // 路径的途经点
      waypoints: [{ "latitude": 31.967236140819114, "longitude": 120.27142088866847 },
        { "latitude": 31.972868002238872, "longitude": 120.2943211817165 },
        { "latitude": 31.98469327973332, "longitude": 120.29101107384068 }],
      language: "zh_CN"
    };
    const result = await navi.getDrivingRoutes(params);
    console.info("Succeeded in getting driving routes.");
    return result;

  }



  aboutToAppear(): void {
    // 地图初始化参数，设置地图中心点坐标及层级
    this.mapOptions = {
      position: {
        target: {
          latitude: this.spot.location.latitude,
          longitude: this.spot.location.longitude
        },
        zoom: CommonConstants.ZOOM
      }
    };

    // 地图初始化的回调
    this.callback = async (err, mapController) => {
      if (!err) {
        // 获取地图的控制器类，用来操作地图
        this.mapController = mapController;
        this.abilityEnabled();
        mapController.setMyLocationStyle(this.style);
        this.mapEventManager = this.mapController.getEventManager();
        // polyline初始化参数
        let polylineOption: mapCommon.MapPolylineOptions = {
          points: [{longitude:108.78,latitude:34.975}, {longitude:this.spot.location.longitude, latitude:this.spot.location.latitude}],
          clickable: true,
          startCap: mapCommon.CapStyle.BUTT,
          endCap: mapCommon.CapStyle.BUTT,
          geodesic: false,
          jointType: mapCommon.JointType.BEVEL,
          visible: true,
          width: 10,
          zIndex: 10,
          gradient: false
        }
        // 创建polyline
        await this.mapController.addPolyline(polylineOption).then(() => {
          console.info('Drawing success');
        });
        let callback = () => {
          console.info(this.TAG, `on-mapLoad`);
        }
        this.mapEventManager.on("mapLoad", callback);
      }
    };
  }

  // 页面每次显示时触发一次，包括路由过程、应用进入前台等场景，仅@Entry装饰的自定义组件生效
  onPageShow(): void {
    // 将地图切换到前台
    if (this.mapController !== undefined) {
      this.mapController.show();
    }
  }

  // 页面每次隐藏时触发一次，包括路由过程、应用进入后台等场景，仅@Entry装饰的自定义组件生效。
  onPageHide(): void {
    // 将地图切换到后台
    if (this.mapController !== undefined) {
      this.mapController.hide();
    }
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

  build() {
    NavDestination(){
      Stack() {
        Text("nihao")
          .width('100%')
        // 调用MapComponent组件初始化地图
        MapComponent({ mapOptions: this.mapOptions, mapCallback: this.callback }).width('100%').height('100%');
      }.height('100%')
    }
  }

/*
  StartNavi = ()=>{
    let petalMapWant: Want = {
      bundleName: 'com.huawei.hmos.maps.app',
      uri: 'maps://routes', // 路径规划
      // uri: 'maps://navigation', // 导航
      parameters: {
        // 接入方业务名或包名，Link请求来源。
        linkSource: 'com.example.navitest',
        destinationLatitude: 40.0382556,
        destinationLongitude: 116.3144536,
        // 终点Poi ID，如果有，优先使用（Map Kit返回的Poi信息含Poi ID）。
        destinationPoiId: '906277887815706098',
        destinationName: '北京清河高铁站',
        vehicleType: 0 // 交通出行工具。0-驾车， 1-步行， 2-骑行。默认驾车
      }
    }

    let context = getContext(this) as common.UIAbilityContext;
    context.startAbility(petalMapWant);
  }

  build() {
    NavDestination(){
      RelativeContainer() {
        Text("唤起导航")
          .id('HelloWorld')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
          .onClick(async() => {
            await this.testDrivingRoutes()
          })
          .onClick( this.StartNavi)
      }
      .height('100%')
      .width('100%')
    }
  }

  async testDrivingRoutes(){
    let params: navi.DrivingRouteParams = {
      // 起点的经纬度
      origins: [{
        "latitude": 31.982129213545843,
        "longitude": 120.27745557768591
      }],
      // 终点的经纬度
      destination: {
        "latitude": 31.982129213545843,
        "longitude": 120.27745557768591
      },
      // 路径的途经点
      waypoints: [{ "latitude": 31.967236140819114, "longitude": 120.27142088866847 },
        { "latitude": 31.972868002238872, "longitude": 120.2943211817165 },
        { "latitude": 31.98469327973332, "longitude": 120.29101107384068 }],
      language: "zh_CN"
    };
    const result = await navi.getDrivingRoutes(params);
    console.info("Succeeded in getting driving routes.");
  }*/
}

@Builder
export function NavigationPageBuilder(){
  NavigationPage()
}

const builderName = BuilderNameConstants.MAP_NAVIGATIONPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(NavigationPageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
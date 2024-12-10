import { RouterModule, RouterNameConstants } from 'routermodule';
import { BuilderNameConstants } from 'routermodule';
import { Spot } from 'travel';
import { Want } from '@kit.AbilityKit';
import { common } from '@kit.AbilityKit';


@Component
export struct MapViewPage {
  //@State mapUtil: MapUtil = MapUtil.getInstance();
  @Consume('appPathStack') appPathStack: NavPathStack;
  @State value: object = new Object()
  @State spot: Spot = new Spot();

  aboutToAppear(): void {
    this.spot = JSON.parse(JSON.stringify(this.value).toString()).Object as Spot;
    this.StartNavi()
  }

  StartNavi = ()=>{
    let petalMapWant: Want = {
      bundleName: 'com.huawei.hmos.maps.app',
      uri: 'maps://routes', // 路径规划
      // uri: 'maps://navigation', // 导航
      parameters: {
        // 接入方业务名或包名，Link请求来源。
        linkSource: '用户到景点的导航',
        destinationLatitude: this.spot.latitude ?? 0,
        destinationLongitude: this.spot.longitude ?? 0,
        destinationName: `${this.spot.name}`,
        vehicleType: 0 // 交通出行工具。0-驾车， 1-步行， 2-骑行。默认驾车
      }
    }

    let context = getContext(this) as common.UIAbilityContext;
    context.startAbility(petalMapWant);
  }

  build() {
    NavDestination(){

      Row(){
        Image($r('app.media.ic_back'))
          .width(30)
          .height(30)
          .onClick( () => {
            RouterModule.pop(RouterNameConstants.ENTRY_HAP);
          })

        Text(this.spot.name)
          .fontSize(24)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      Row() {
        /*NavigationPage({spot:this.spot})
          .width('100%')
          .height('100%')*/
      }
    }
    .margin({top:$r('app.float.header_height_page')})
    .hideTitleBar(true)
  }
}

@Builder
export function MapViewPageBuilder(value: object){
  MapViewPage({value:value})
}

const builderName = BuilderNameConstants.MAP_MAPVIEWPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(MapViewPageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}


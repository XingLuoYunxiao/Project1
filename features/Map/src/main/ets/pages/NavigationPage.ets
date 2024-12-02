import { RouterModule } from 'routermodule';
import { BuilderNameConstants } from 'routermodule';
import { Spot } from 'travel';
import { common } from '@kit.AbilityKit';
import { Want } from '@kit.AbilityKit';

@Component
export struct NavigationPage {
  @Prop spot:Spot

  StartNavi = ()=>{
    let petalMapWant: Want = {
      bundleName: 'com.huawei.hmos.maps.app',
      uri: 'maps://routes', // 路径规划
      // uri: 'maps://navigation', // 导航
      parameters: {
        // 接入方业务名或包名，Link请求来源。
        linkSource: '用户到景点的导航',
        destinationLatitude: this.spot.location.latitude,
        destinationLongitude: this.spot.location.longitude,
        destinationName: `${this.spot.name}`,
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
          /*.onClick(async() => {
            await this.testDrivingRoutes()
          })*/

          .onClick(this.StartNavi)
      }
      .height('100%')
      .width('100%')
    }
  }
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

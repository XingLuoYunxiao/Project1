import { RouterModule, RouterNameConstants } from 'routermodule';
import { BuilderNameConstants } from 'routermodule';
import { Spot } from 'travel';
import { NavigationPage } from './NavigationPage';


//TODO 模块间跳转，不知道能否引用其他模块的内容
@Component
export struct MapViewPage {
  //@State mapUtil: MapUtil = MapUtil.getInstance();
  @Consume('appPathStack') appPathStack: NavPathStack;
  @State value: object = new Object()
  @State spot: Spot = new Spot('-1','null' , "null", 'null', 0, {"latitude": 0, "longitude": 0}, 0, 'null', 'null', '', '', '', '');

  aboutToAppear(): void {
    this.spot = JSON.parse(JSON.stringify(this.value).toString()).Object as Spot;
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
        NavigationPage({spot:this.spot})
          .width('100%')
          .height('100%')
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


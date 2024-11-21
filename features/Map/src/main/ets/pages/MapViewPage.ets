import { AMap, MapsInitializer, MapView, MapViewComponent, MapViewManager, } from '@amap/amap_lbs_map3d';
import { router } from '@kit.ArkUI';
import { RouterModule } from 'routermodule';
import { BuilderNameConstants } from 'routermodule';
import { Spot } from 'travel';

MapsInitializer.setApiKey("6c6f0a62ed032f8422a7e2bc070f18e5");
MapViewManager.getInstance().registerMapViewCreatedCallback((mapview?: MapView, mapViewName?: string) => {
  if (!mapview) {
    return;
  }
  let mapView = mapview;
  mapView.onCreate();
  mapView.getMapAsync((map) => {
    let aMap: AMap = map;
  })
})

//TODO 模块间跳转，不知道能否引用其他模块的内容
//@Entry({routeName: 'mapView'})
@Component
export struct MapViewPage {
  @State value: object = new Object()
  @State spot: Spot = new Spot('-1','null' , "null", 'null', 0, {"latitude": 0, "longitude": 0}, 0, 'null', 'null', '', '', '', '');
    //new Spot('-1','null' , "null", 'null', 0, {"latitude": 0, "longitude": 0}, 0, 'null', 'null', '', '', '', '');
  aboutToAppear(): void {
    this.spot = JSON.parse(JSON.stringify(this.value).toString()) as Spot;
    //this.spot = this.value.Object as Spot;
  }

  build() {
    NavDestination(){
      Row() {
        MapViewComponent()
          .width('100%')
          .height('50%')

      }
      Text(this.spot.name)
        .width('100%')
        .height(200)
    }
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
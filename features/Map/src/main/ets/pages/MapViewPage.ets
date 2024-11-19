import { AMap, MapsInitializer, MapView, MapViewComponent, MapViewManager, } from '@amap/amap_lbs_map3d';
import { router } from '@kit.ArkUI';

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

@Entry({routeName: 'mapView'})
@Component
export struct MapViewPage {

  aboutToAppear(): void {
    router.getParams()
  }

  build() {
    Row() {
      MapViewComponent()
        .width('100%')
        .height('50%')
    }
  }
}

@Builder
export function MapViewPageBuilder(){
  MapViewPage()
}
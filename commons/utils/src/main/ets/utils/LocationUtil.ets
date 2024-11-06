import { geoLocationManager } from '@kit.LocationKit';
import { promptAction } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { Logger } from '@hw-agconnect/hmcore/src/main/ets/base/log/Logger';

const Tag = 'LocationUtil';

export interface Location{
  latitude:number
  longitude:number
}

export class LocationUtil {
  private static instance: LocationUtil = new LocationUtil();

  //单次定位功能
  private requestOnce: geoLocationManager.SingleLocationRequest = {
    'locatingPriority':  geoLocationManager.LocatingPriority.PRIORITY_ACCURACY,
    'locatingTimeoutMs': 10000
  };

  //持续定位，
  private requestContinuous: geoLocationManager.ContinuousLocationRequest= {
    'interval': 1,
    'locationScenario': geoLocationManager.UserActivityScenario.NAVIGATION
  }

  private constructor() {}

  static getInstance(): LocationUtil {
    return LocationUtil.instance;
  }

  async getCurrentLocation(): Promise<Location> {
    let loc:Location =  { latitude:0, longitude:0 }


    await geoLocationManager.getCurrentLocation(this.requestOnce).then((location: geoLocationManager.Location) => {
      console.log('current location: ' + JSON.stringify(location));
      loc = { latitude:location.latitude, longitude:location.longitude }
    }).catch((err: Error) => {
      promptAction.showToast({
        message: JSON.stringify(err),
        duration: 2000
      });
    });
    Logger.debug(Tag, 'LocationUtil getCurrentLocation', loc.latitude, ',',  loc.longitude)
    return loc
  }

  //导航服务调用接口
  getContinuousLocation(): void {
    let locationCallback = (location:geoLocationManager.Location):void => {
      console.log('locationCallback: data: ' + JSON.stringify(location));
    };
    try {
      geoLocationManager.on('locationChange', this.requestContinuous, locationCallback);
    } catch (err) {
      console.error("errCode:" + JSON.stringify(err));
    }
  }

}

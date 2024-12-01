import { geoLocationManager } from '@kit.LocationKit';
import { promptAction } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { Logger } from '@hw-agconnect/hmcore/src/main/ets/base/log/Logger';
import { map } from '@kit.MapKit';
import { CommonConstants } from '../constants/CommonConstants';

const Tag = 'LocationUtil';

export interface Location{
  latitude:number
  longitude:number
}

export class LocationUtil {
  private static instance: LocationUtil = new LocationUtil();
  //当前用户位置
  currentLocation: Location | undefined = undefined
  currentCityName: string | undefined = undefined

  //单次定位功能
  private requestOnceSpeed: geoLocationManager.SingleLocationRequest = {
    'locatingPriority':  geoLocationManager.LocatingPriority.PRIORITY_LOCATING_SPEED,
    'locatingTimeoutMs': 10000
  };

  //持续定位，
  private requestContinuous: geoLocationManager.ContinuousLocationRequest= {
    'interval': 1,
    'locationScenario': geoLocationManager.UserActivityScenario.NAVIGATION
  }

  private constructor() {
    this.getCurrentLocation()
  }


  static getInstance(): LocationUtil {
    if( !LocationUtil.instance){
      LocationUtil.instance = new LocationUtil();
    }
    return LocationUtil.instance;
  }

  getCurrentLocation(): Promise<void> {
    return new Promise<void>((resolve, reject) => {
      let loc:Location = { latitude:0, longitude:0 }
      geoLocationManager.getCurrentLocation(this.requestOnceSpeed).then((location: geoLocationManager.Location) => {
        console.log('current location: ' + JSON.stringify(location));
        loc = { latitude:Number(location.latitude.toFixed(2)), longitude: Number(location.longitude.toFixed(2)) }
        this.currentLocation = loc
        console.log('current location: ' + JSON.stringify(this.currentLocation));
        resolve()
      }).catch((err: Error) => {
        promptAction.showToast({
          message: JSON.stringify(err),
          duration: 2000
        });
        reject(err)
      });
      Logger.debug(Tag, 'LocationUtil getCurrentLocation', loc.latitude, ',',  loc.longitude)
      })
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

  // 逆地理编码服务
  async getAddress(location: Location): Promise<string> {
    return new Promise((resolve, reject) => {
      /*const reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest = {
        "latitude": location.latitude,
        "longitude": location.longitude,
        "maxItems": 1
      };*/

      try {
        geoLocationManager.getAddressesFromLocation({
          "latitude": location.latitude,
          "longitude": location.longitude,
          "maxItems": 1
        }, (err, data) => {
          if (err) {
            reject(err);
          }
          if (data && data[0] && data[0].locality) {
            resolve(data[0].locality);
          } else {
            resolve("未获取到地址");
          }
        });
      } catch (err) {
        reject(err);
      }
    });
  }

  // 获取当前地点的城市名
  async getCityName(): Promise<string> {
    if( this.currentLocation === undefined)
      await this.getCurrentLocation()
    return new Promise(async ( resolve, reject) => {
      let address:string = await this.getAddress(this.currentLocation!)
      this.currentCityName = address
      if( address !== '未获取到地址'){
        Logger.info(Tag, 'getCityName', '获取到地址', address)
        resolve(address)
      }else{
        Logger.error(Tag, 'getCityName', '未获取到地址')
      }
        reject(address)
    })
  }

  //TODO 可以优化
  //导航模块需要的地图服务
  async getLocation(mapController?: map.MapComponentController): Promise<geoLocationManager.Location> {
    let promise = geoLocationManager.getCurrentLocation();
    Logger.info(Tag, 'getCurrentLocation' + JSON.stringify(promise));
    promise.then(async (location: geoLocationManager.Location) => {
      mapController?.setMyLocation(location);
      Logger.info(Tag, 'getCurrentLocation' + JSON.stringify(location));
      mapController?.animateCamera(map.newLatLng({
        latitude: location.latitude,
        longitude: location.longitude
      }, CommonConstants.ZOOM), CommonConstants.DURATION);
      return location;
    }).catch((error: Error) => {
      Logger.error('getCurrentLocation failed', 'getCurrentLocation error: ' + JSON.stringify(error));
    });
    return promise;
  }

}

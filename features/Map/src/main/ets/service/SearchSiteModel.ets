/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { mapCommon, site, navi, map } from '@kit.MapKit';
import { geoLocationManager } from '@kit.LocationKit';
import { i18n } from '@kit.LocalizationKit';
import Logger from 'routermodule/src/main/ets/utils/Logger';
import {  CommonConstants } from '../constants/CommonConstants';

export const enum RouteType {
  DRIVING,
  BICYCLING,
  WALKING
}

export class SearchSiteModel {
  /**
   * Search for nearby locations based on the input location.
   * @param position
   * @param text
   * @returns
   */
  async getNearByLocation(position: mapCommon.LatLng, text: string): Promise<site.NearbySearchResult | undefined> {
    let params: site.NearbySearchParams = {
      location: position,
      language: CommonConstants.languageMap.get(i18n.System.getSystemLanguage()),
      radius: 50000,
      query: text
    };
    let result: site.NearbySearchResult | undefined = undefined;
    try {
      result = await site.nearbySearch(params);
      Logger.info('NearbySearch success, result = ' + JSON.stringify(result));
    } catch (err) {
      Logger.error('NearbySearch fail, err = ' + JSON.stringify(err));
    }
    return result;
  }

  /**
   * Plan driving route.
   * @param beginPoint
   * @param terminalPoint
   * @returns
   */
  async getRoutes(beginPoint: geoLocationManager.Location, terminalPoint: mapCommon.LatLng,  type:RouteType): Promise<navi.RouteResult | undefined> {
    if (!terminalPoint || !terminalPoint) {
      return undefined;
    }

    let origin: mapCommon.LatLng = {
      latitude: beginPoint.latitude,
      longitude: beginPoint.longitude
    };

    let originPosition: mapCommon.LatLng =
      map.convertCoordinateSync(mapCommon.CoordinateType.WGS84, mapCommon.CoordinateType.GCJ02, origin);

    let paramsDrive: navi.DrivingRouteParams = {
      origins: [
        originPosition
      ],
      destination: {
        latitude: terminalPoint.latitude,
        longitude: terminalPoint.longitude
      },
      optimize: true,
      language: CommonConstants.languageMap.get(i18n.System.getSystemLanguage()),
      alternatives: true,
      avoids: [1,8],
      trafficMode: 0
    };

    let paramsWalkCycle: navi.DrivingRouteParams = {
      origins: [
        originPosition
      ],
      destination: {
        latitude: terminalPoint.latitude,
        longitude: terminalPoint.longitude
      },
      optimize: true,
      language: CommonConstants.languageMap.get(i18n.System.getSystemLanguage()),
      alternatives: true,
      avoids: [8],
      trafficMode: 0
    };

    let result: navi.RouteResult | undefined = undefined;
    try {
      switch (type) {
        case RouteType.DRIVING:
          result = await navi.getDrivingRoutes(paramsDrive);
          break;
        case RouteType.WALKING:
          result = await navi.getWalkingRoutes(paramsWalkCycle);
          break;
        case RouteType.BICYCLING:
          result = await navi.getCyclingRoutes(paramsWalkCycle);
          break;
        default:
          break;
      }
    } catch (err) {
      Logger.error('routes plan fail, err = ' + JSON.stringify(err));
    }
    return result;
  }

  async getWalkingRoutes(beginPoint: geoLocationManager.Location, terminalPoint: mapCommon.LatLng){
    if (!terminalPoint || !terminalPoint) {
      return undefined;
    }

    let origin: mapCommon.LatLng = {
      latitude: beginPoint.latitude,
      longitude: beginPoint.longitude
    };

    let originPosition: mapCommon.LatLng =
      map.convertCoordinateSync(mapCommon.CoordinateType.WGS84, mapCommon.CoordinateType.GCJ02, origin);

    let params: navi.DrivingRouteParams = {
      origins: [
        originPosition
      ],
      destination: {
        latitude: terminalPoint.latitude,
        longitude: terminalPoint.longitude
      },
      optimize: true,
      language: CommonConstants.languageMap.get(i18n.System.getSystemLanguage()),
      alternatives: true,
      avoids: [1,8],
      trafficMode: 0
    };

    let result: navi.RouteResult | undefined = undefined;
    try {
      result = await navi.getWalkingRoutes(params);
      Logger.info('Driving routes plan success, result = ' + JSON.stringify(result));
    } catch (err) {
      Logger.error('Driving routes plan fail, err = ' + JSON.stringify(err));
    }
    return result;
  }
}
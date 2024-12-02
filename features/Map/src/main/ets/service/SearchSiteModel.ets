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
import { Spot } from 'travel';

export const enum RouteType {
  DRIVING,
  BICYCLING,
  WALKING
}

export class SearchSiteModel {
  //搜索景点附近的景点，并和传过来的景点进行匹配
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

  //根据内部景点数组进行查询具体景点坐标信息
  async getSearchByText(position: mapCommon.LatLng, spot: Spot, sites: string[]): Promise<site.NearbySearchResult | undefined> {
    const locRes: site.SearchByTextResult = { totalCount: 0, sites: [] };
    const uniqueSiteNames = new Set<string>();

    // 使用 for...of 保证顺序执行
    for (const element of sites) {
      const params: site.SearchByTextParams = {
        query: element,
        location: position,
        language: CommonConstants.languageMap.get(i18n.System.getSystemLanguage()),
        radius: 5000,
        cityId: spot.cityCode,
        //poiTypes: ['TOURISM', 'LEISURE', 'SPORT_FITNESS']
      };

      try {
        const result = await site.searchByText(params);
        Logger.info('SearchByText success, result = ' + JSON.stringify(result));

        // 检查结果是否包含有效数据(去除重复数据)
        if (result && result.totalCount > 0) {
          result.sites?.some((site: site.Site) => {
            // 仅添加尚未存在的站点
            if (site.name && !uniqueSiteNames.has(site.name)) {
              uniqueSiteNames.add(site.name);
              locRes.sites?.push(site);
              return true;
            }
            return false
          });
        }
      } catch (err) {
        Logger.error('SearchByText fail, err = ' + JSON.stringify(err));
      }
    }

    locRes.totalCount = locRes.sites?.length || 0;
    return locRes;
  }

  //TODO 需要优化， 匹配景点不准确，绘制路线不是很明确
  async getInnerRoutes(beginPoint: mapCommon.LatLng, nextPoint: site.Site[], type: RouteType): Promise<navi.RouteResult | undefined> {
    if (nextPoint.length === 0)
      return undefined;

    // 使用 for...of 保证顺序和同步
    const routes: navi.Route[] = [];
    let prevLocation: mapCommon.LatLng = {
      latitude: beginPoint.latitude,
      longitude: beginPoint.longitude
    };

    for (let i = 0; i < nextPoint.length; i++) {
      const site = nextPoint[i];

      if (site.location?.longitude !== undefined && site.location?.latitude !== undefined) {
        //let originPosition: mapCommon.LatLng = map.convertCoordinateSync(mapCommon.CoordinateType.WGS84, mapCommon.CoordinateType.GCJ02, prevLocation);

        let paramsWalkCycle: navi.RouteParams = {
          origins: [prevLocation],
          destination: {
            latitude: site.location.latitude,
            longitude: site.location.longitude
          },
          language: CommonConstants.languageMap.get(i18n.System.getSystemLanguage()),
          avoids: [8],
        };

        try {
          let route = await navi.getWalkingRoutes(paramsWalkCycle);
          if (route && route.routes && route.routes.length > 0) {
            //TODO 将routes中的几个路线查看一下
            routes.push(route.routes[0]);
          }
        } catch (error) {
          // 错误处理
          Logger.error(`Route planning error for site ${site.name}: ${error}`);
        }

        // 更新上一个位置为当前站点位置
        prevLocation = routes[i].steps[0].endLocation

      }
    }

    return { routes };
  }

  //获得两点之间的路线
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

    let paramsWalkCycle: navi.RouteParams = {
      origins: [
        originPosition
      ],
      destination: {
        latitude: terminalPoint.latitude,
        longitude: terminalPoint.longitude
      },
      language: CommonConstants.languageMap.get(i18n.System.getSystemLanguage()),
      avoids: [8],
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
}
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

// Key of the builderMap of the routing table in the RouterModule. The format is as follows:{bundleName}_${pageName}.
export class BuilderNameConstants {
  // Map
  static readonly MAP_MAPVIEWPAGE: string = 'map_MapViewPage';
  static readonly MAP_NAVIGATIONPAGE: string = 'map_NavigationPage';
  static readonly MAP_ROUTEPLANVIEW: string = 'map_RoutePlanView';


  //Travel
  // Feature: Travel中的AI导游页面
  static readonly TRAVEL_FAMOUSPLACEPAGE: string = 'travel_FamousPlacePage';
  // Feature: Travel中的景点分类页面
  static readonly TRAVEL_ATTRACTIONTICKETPAGE: string = 'travel_AttractionTicketPage';
  static readonly TRAVEL_LOADINGANIMATION: string = 'travel_LoadingAnimation';
  static readonly TRAVEL_SPOTDETAILPAGE: string = 'travel_SpotDetailPage';
  static readonly TRAVEL_SEARCHPAGE: string = 'travel_SearchPage';
  static readonly TRAVEL_ATTRACTIONDETAILPAGE: string = 'travel_AttractionDetailPage';


}

// Indicates the key of the routerMap table in the RouterModule.
export class RouterNameConstants {
  static readonly ENTRY_HAP: string = 'AppPath_Router';
}
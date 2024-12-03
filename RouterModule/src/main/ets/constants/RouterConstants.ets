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
  //Culture
  static readonly CULTURE_POEM: string = 'culture_PoemPage'
  static readonly CULTURE_POEMDETAIL: string = 'culture_PoemDetailPage'
  static readonly CULTURE_POEMENETER: string = 'culture_PoemEnterPage'
  static readonly CULTURE_SENTENCE: string = "culture_SentencePage"
  static readonly CULTURE_IDIOM: string = "culture_IdiomPage"
  static readonly CULTURE_XIEHOUYU: string = "culture_XiehouyuPage"
  static readonly CULTURE_ART: string = "culture_ArtPage"
  static readonly CULTURE_FESTIVAL: string = "culture_FestivalPage"
  static readonly CULTURE_CALLIGRAPHY: string = "culture_CalligraphyDetails"
  static readonly CULTURE_PAINTING: string = "culture_PaintingDetails"
  static readonly CULTURE_IdiomSolitaire: string = "culture_IdiomSolitaire"
  static readonly CULTURE_FlyingFlowerOder: string = 'culture_FlyingFlowerOder'
  static readonly CULTURE_TEST: string = 'culture_Test'
  static readonly CULTURE_FOLKART: string = 'culture_FolkArt'
  static readonly CULTURE_Building: string = 'culture_Building'
  static readonly CULTURE_AIPainting: string = 'culture_AIPainting'
  static readonly CULTURE_FestivalPage2: string = 'culture_FestivalPage2'
  static readonly CULTURE_GapFillingPage: string = 'culture_GapFillingPage'
  static readonly CULTURE_SentenceFilling: string = 'culture_SentenceFilling'
}

// Indicates the key of the routerMap table in the RouterModule.
export class RouterNameConstants {
  static readonly ENTRY_HAP: string = 'AppPath_Router';
}

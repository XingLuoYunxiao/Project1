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
  //Travel
  // Feature: Travel中的AI导游页面
  static readonly TRAVEL_FAMOUSPLACEPAGE: string = 'travel_FamousPlacePage';
  //Login
  static readonly TRAVEL_ATTRACTIONDETAILPAGE:string='travel_AttractionDetailPage';
  static readonly LOGIN_COLLECTIONPAGE: string = 'login_CollectionPage';
  static readonly LOGIN_LOGINPAGE:string='login_LoginPage';
  static readonly LOGIN_ADVICEPAGE:string='login_AdvicePage';
  static readonly LOGIN_BROWSHISTORYPAGE:string='login_BrowshistoryPage';
  static readonly LOGIN_CHANGEPHOTO:string='login_ChangePhoto';
  static readonly LOGIN_CUSSERVICEPAGE:string='login_CusservicePage';
  static readonly LOGIN_KNOWLEDGEPAGE:string='login_KnowledgePage';
  static readonly LOGIN_MYORDER:string='login_Myorder';
  static readonly LOGIN_PRIVACYPAGE:string='login_PrivacyPage';
  static readonly LOGIN_SETTINGPAGE:string='login_SettingPage';
  // Feature: Travel中的景点分类页面
  static readonly TRAVEL_ATTRACTIONTICKETPAGE: string = 'travel_AttractionTicketPage';
  static readonly TRAVEL_LOADINGANIMATION: string = 'travel_LoadingAnimation';
  static readonly TRAVEL_SPOTDETAILPAGE: string = 'travel_SpotDetailPage';
  static readonly TRAVEL_SEARCHPAGE: string = 'travel_SearchPage';

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
}

// Indicates the key of the routerMap table in the RouterModule.
export class RouterNameConstants {
  static readonly ENTRY_HAP: string = 'AppPath_Router';
}

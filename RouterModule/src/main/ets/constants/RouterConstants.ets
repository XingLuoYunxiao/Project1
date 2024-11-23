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
  static readonly MAP_MAPVIEWPAGE: string = 'map_MapViewPage';
  //Travel
  static readonly TRAVEL_FAMOUSPLACEPAGE: string = 'travel_FamousPlacePage';
  static readonly HARA_A2: string = '@ohos/hara_A2';
  static readonly HARB_B1: string = '@ohos/harb_B1';
  static readonly HARB_B2: string = '@ohos/harb_B2';
  static readonly HARB_B3: string = '@ohos/harb_B3';
  static readonly HARC_C1: string = '@ohos/harc_C1';
  static readonly HARC_C2: string = '@ohos/harc_C2';
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

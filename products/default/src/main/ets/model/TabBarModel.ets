/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the 'License');
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

export interface TabBarData {
  id: TabBarType;
  title: ResourceStr;
  activeIcon: ResourceStr;
  defaultIcon: ResourceStr;
}

export enum TabBarType {
  //数字枚举： 默认情况下，枚举是数字的，可以不指定值，枚举成员会从0开始自动递增。
  TRAVEL = 0,
  CULTURE,
  //AI,
  ROUTE,
  MINE
}

export const TabsInfo: TabBarData[] = [
  {
    id: TabBarType.TRAVEL,
    title: $r('app.string.tab_travel'),
    activeIcon: $r('app.media.ic_tab_travel_on'),
    defaultIcon: $r('app.media.ic_tab_travel_off')
  },
  {
    id: TabBarType.CULTURE,
    title: $r('app.string.tab_culture'),
    activeIcon: $r('app.media.ic_tab_culture_on'),
    defaultIcon: $r('app.media.ic_tab_culture_off')
  },
  //TODO AI未完成
  /*{
    id: TabBarType.AI,
    title: $r('app.string.tab_culture'),
    activeIcon: $r('app.media.ic_tab_culture_on'),
    defaultIcon: $r('app.media.ic_tab_culture_off')
  },*/
  {
    id: TabBarType.ROUTE,
    title: $r('app.string.tab_route'),
    activeIcon: $r('app.media.ic_tab_route_on'),
    defaultIcon: $r('app.media.ic_tab_route_off')
  },
  {
    id: TabBarType.MINE,
    title: $r('app.string.tab_mine'),
    activeIcon: $r('app.media.ic_tab_mine_on'),
    defaultIcon: $r('app.media.ic_tab_mine_off')
  }
]
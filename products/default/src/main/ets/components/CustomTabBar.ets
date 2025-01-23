/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { BreakpointConstants, BreakpointType } from 'utils';
import { AppConstants } from '../constants/AppConstants';
import { TabBarData, TabBarType, TabsInfo } from '../model/TabBarModel';

@Component
export struct CustomTabBar {
  @Link currentIndex: TabBarType;
  @StorageLink('currentHeightBreakpoint') currentHeightBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('currentWidthBreakpoint') currentWidthBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;

  onChange(index: TabBarType): void {
    this.currentIndex = index;
  }

  build() {
    Flex({
      direction: this.currentWidthBreakpoint === BreakpointConstants.BREAKPOINT_LG ? FlexDirection.Column : FlexDirection.Row,
      alignItems: ItemAlign.Center,
      justifyContent: FlexAlign.SpaceAround
    }) {
      ForEach(TabsInfo, (item: TabBarData) => {
        TabItem({
          index: item.id,
          selectedIndex: this.currentIndex,
          onChange: (index: number) => this.onChange(index)
        })
      }, (item: TabBarData) => item.id.toString())
    }
    .border({
      width: this.currentWidthBreakpoint === BreakpointConstants.BREAKPOINT_LG ? { right: $r('app.float.tab_border_width')} : { top: $r('app.float.tab_border_width') },
      color: $r('sys.color.ohos_id_color_text_field_sub_bg')
    })
    .padding({ bottom: $r('app.float.md_padding_margin')})
    .clip(false)
    .height(new BreakpointType<Length>({
      sm: AppConstants.TAB_HEIGHT,
      md: AppConstants.TAB_HEIGHT,
      lg: AppConstants.FULL_PERCENT
    }).getValue(this.currentWidthBreakpoint))
    .width(new BreakpointType<Length>({
      sm: AppConstants.FULL_PERCENT,
      md: AppConstants.FULL_PERCENT,
      lg: $r('app.float.tool_bar_width')
    }).getValue(this.currentWidthBreakpoint))
    .margin({bottom: $r('app.float.lg_padding_margin')})
    .backgroundColor($r('app.color.app_background_color'))
  }
}

@Component
struct TabItem {
  @Prop index: number
  @Prop selectedIndex: number;
  @StorageLink('currentWidthBreakpoint') currentWidthBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  onChange: (index: number) => void = () => {
  };

  //TODO 用-1替换了TabBarType.AI
  build() {
    Column() {
      Image(this.selectedIndex === this.index ? TabsInfo[this.index].activeIcon : TabsInfo[this.index].defaultIcon)
        .size(this.index === -1 ?
          { width: $r('app.float.tab_big_img_width'), height: $r('app.float.tab_big_img_height') } :
          { width: $r('app.float.tab_img_size'), height: $r('app.float.tab_img_size') })
        .margin({ top: this.index === -1 ? $r('app.float.tab_margin') : 0 })
        .offset({
          y: (this.selectedIndex === this.index ) ?
          5 : 0
        })// TODO：知识点：组件的某些通用属性变化时，可以通过属性动画animation实现过渡效果。动画效果是tabBar的图片向上偏移一小段距离
        .animation({
          duration: 400,
          curve: Curve.Ease,
          iterations: 1,
          playMode: PlayMode.Normal
        })
      Text(TabsInfo[this.index].title)
        .fontSize($r('app.float.tab_font_size'))
        .margin({ top: $r('app.float.tab_title_margin') })
        .fontWeight(AppConstants.TAB_FONT_WEIGHT)
        .fontColor(this.index === this.selectedIndex ?
          (this.index == -1 ? $r('app.color.challenge_light') :
          $r('sys.color.ohos_id_color_bottom_tab_text_on')) :
        $r('sys.color.ohos_id_color_bottom_tab_text_off'))
    }
    .clip(false)
    .padding(
      { left: $r('app.float.ss_padding_margin'), right: $r('app.float.ss_padding_margin') })
    .layoutWeight(1)
    .size(this.currentWidthBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
      { width: AppConstants.FULL_PERCENT } :
      { height: AppConstants.FULL_PERCENT })
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      if (this.selectedIndex !== this.index) {
        this.onChange(this.index);
      }
    })
  }
}
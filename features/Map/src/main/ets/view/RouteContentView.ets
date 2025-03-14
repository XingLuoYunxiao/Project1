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

import { map, navi } from '@kit.MapKit';
import Logger from 'utils/src/main/ets/utils/Logger';
import { CommonConstants } from '../constants/CommonConstants';
import { RouteConstants } from '../constants/RouteConstants';
import { CalculateModel } from '../service/CalculateModel';
import { DrawRouteModel } from '../service/DrawRouteModel';

@Component
export struct RouteContentView {
  @StorageLink('routes') routes: Array<navi.Route> | undefined = [];
  @State currentIndex: number = 0;
  @State columnHeight: number = 269;
  @Link mapController: map.MapComponentController;
  private calculateMode: CalculateModel = new CalculateModel();
  private drawRouteModel: DrawRouteModel = new DrawRouteModel();

  aboutToAppear(): void {
    if (this.routes !== undefined && this.mapController) {
      this.mapController.clear();
      /*this.drawRouteModel.drawRoute(this.mapController, this.routes[0].steps[0].roads).then(() => {
        Logger.info('First draw route success');
      });*/
      this.drawRouteModel.drawRoutes(this.mapController, this.routes).then(() => {
        Logger.info('First draw route success');
      });
    }
  }



  build() {
    if (this.routes !== undefined) {
      if (this.columnHeight > CommonConstants.HEIGHT_MIDDLE) {
        List() {
          ListItem() {
            Row() {
              Column() {
                Text(`我的方案`)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor($r('app.color.font_color_heavy_selected') )
                  .margin({ bottom: $r('app.float.text_image_margin') })
                Text(this.calculateMode.getRoutesTotalDistance(this.routes).toString() + RouteConstants.KILOMETRES)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor($r('app.color.font_color_light_selected'))
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ left: $r('app.float.list_margin_border') })

              Text(this.calculateMode.getRoutesTotalTime(this.routes))
                .fontSize($r('app.float.font_size_big'))
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.font_color_heavy_selected'))
                .margin({ right: $r('app.float.list_margin_border') })
            }
            .width(CommonConstants.FULL_WIDTH)
            .justifyContent(FlexAlign.SpaceBetween)
            .height($r('app.float.list_group_height'))
            .borderRadius($r('app.float.list_group_border_radius'))
            .shadow({
              radius: $r('app.float.route_radius'),
              color: $r('app.color.route_radius')
            })
          }
          .padding({
            top: $r('app.float.list_row_padding_top')
          })
          .width(CommonConstants.FULL_WIDTH)
          .height($r('app.float.list_row_height'))
          /*ForEach(this.routes, (item: navi.Route, index: number) => {
            ListItem() {
              Row() {
                Column() {
                  Text(`方案${index+1}`)
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(this.currentIndex === index ?
                      $r('app.color.font_color_heavy_selected') : $r('app.color.route_font_color_unselected'))
                    .margin({ bottom: $r('app.float.text_image_margin') })
                  Text(this.calculateMode.getTotalDistance(item).toString() + RouteConstants.KILOMETRES)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.currentIndex === index ?
                      $r('app.color.font_color_light_selected') : $r('app.color.route_font_color_unselected'))
                }
                .alignItems(HorizontalAlign.Start)
                .margin({ left: $r('app.float.list_margin_border') })

                Text(this.calculateMode.getTotalTime(item))
                  .fontSize($r('app.float.font_size_big'))
                  .fontWeight(FontWeight.Bold)
                  .fontColor(this.currentIndex === index ?
                    $r('app.color.font_color_heavy_selected') : $r('app.color.route_font_color_unselected'))
                  .margin({ right: $r('app.float.list_margin_border') })
              }
              .width(CommonConstants.FULL_WIDTH)
              .justifyContent(FlexAlign.SpaceBetween)
              .height($r('app.float.list_group_height'))
              .borderRadius($r('app.float.list_group_border_radius'))
              .shadow({
                radius: $r('app.float.route_radius'),
                color: $r('app.color.route_radius')
              })
            }
            .onClick(() => {
              this.currentIndex = index;
              this.mapController.clear();
              this.drawRouteModel.drawRoute(this.mapController, item.steps[0].roads).then(() => {
                Logger.info('Draw route success');
              });
            })
            .padding({
              top: $r('app.float.list_row_padding_top')
            })
            .width(CommonConstants.FULL_WIDTH)
            .height($r('app.float.list_row_height'))
          })*/
        }
        .width(CommonConstants.FULL_WIDTH)
        .height(CommonConstants.FULL_HEIGHT)
      } else {
        List() {
          ForEach(this.routes, (item: navi.Route, index: number) => {
            ListItem() {
              Column() {
                Text($r('app.string.choose'))
                  .fontSize($r('app.float.font_size_small'))
                  .fontWeight(FontWeight.Bold)
                  .fontColor(this.currentIndex === index ?
                    $r('app.color.font_color_heavy_selected') : $r('app.color.route_font_color_unselected'))
                  .margin({
                    top: $r('app.float.list_column_margin_top'),
                    left: $r('app.float.list_column_margin_left')
                  })
                Text(this.calculateMode.getTotalTime(item))
                  .fontSize($r('app.float.font_size_big'))
                  .fontWeight(FontWeight.Bold)
                  .fontColor(this.currentIndex === index ?
                    $r('app.color.font_color_heavy_selected') : $r('app.color.route_font_color_unselected'))
                  .margin({ left: $r('app.float.list_column_margin_left') })
                Text(this.calculateMode.getTotalDistance(item).toString() + RouteConstants.KILOMETRES)
                  .fontSize($r('app.float.font_size_small'))
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.currentIndex === index ?
                    $r('app.color.font_color_light_selected') : $r('app.color.route_font_color_unselected'))
                  .margin({ left: $r('app.float.list_column_margin_left') })
              }
              .margin({ right: $r('app.float.list_column_margin_right') })
              .alignItems(HorizontalAlign.Start)
              .height($r('app.float.list_row_total_height'))
              .width($r('app.float.list_row_width_sm'))
              .borderRadius($r('app.float.list_group_border_radius'))
              .shadow({
                radius: $r('app.float.route_radius'),
                color: $r('app.color.route_radius')
              })
            }
            .onClick(() => {
              this.currentIndex = index;
              this.mapController.clear();
              this.drawRouteModel.drawRoute(this.mapController, item.steps[0].roads).then(() => {
                Logger.info('Draw route success');
              });
            })
          })
        }
        .width(CommonConstants.FULL_WIDTH)
        .scrollBar(BarState.Off)
        .listDirection(Axis.Horizontal)
      }
    }
  }
}
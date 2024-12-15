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

import { navi } from '@kit.MapKit';
import Logger from 'utils/src/main/ets/utils/Logger';


export class CalculateModel {

  //获取总路径时间
  getRoutesTotalTime(routes: navi.Route[]){
    if (routes === undefined) {
      return "0";
    }
    let time: number = 0;
    for(let i = 0; i < routes.length; i++){
      for (let index = 0; index < routes[i].steps.length; index++) {
        if (routes[i].steps[index] !== undefined && routes[i].steps[index].duration !== undefined) {
          time += routes[i].steps[index].duration!;
          Logger.info('Time is ' + time);
        }
      }
    }

    return this.formatTime(time/60);
  }


  //获取总路径长度
  getRoutesTotalDistance(routes: navi.Route[]){
    if (routes === undefined ) {
      return 0;
    }
    let distance: number = 0;
    for(let i = 0; i < routes.length; i++){
      for (let index = 0; index < routes[i].steps.length; index++) {
        if (routes[i].steps[index] !== undefined && routes[i].steps[index].distance !== undefined) {
          distance += routes[i].steps[index].distance!;
          Logger.info('Distance is ' + distance);
        }
      }
    }
    return distance / 1000;
  }
  /**
   * Get the total duration of the route.
   * @param route
   * @returns
   */
  getTotalTime(route: navi.Route): string {
    if (route === undefined || route.steps === undefined) {
      return "0";
    }
    let time: number = 0;
    for (let index = 0; index < route.steps.length; index++) {
      if (route.steps[index] !== undefined && route.steps[index].duration !== undefined) {
        time += route.steps[index].duration!;
        Logger.info('Time is ' + time);
      }
    }

    return this.formatTime(time/60);
  }

  formatTime(minutes: number): string {
    const hours = Math.floor(minutes / 60);
    const remainingMinutes = Math.round(minutes % 60); // 使用 Math.round() 四舍五入


    let formattedTime = '';
    if (hours > 0) {
      formattedTime += hours + '小时';
    }
    if (remainingMinutes > 0) {
      formattedTime += remainingMinutes + '分钟';
    }
    // 处理时间为0的情况
    if(formattedTime === ''){
      formattedTime = '0' + '分钟';
    }

    return formattedTime;
  }

  /**
   * Get the total distance of the route.
   * @param route
   * @returns
   */
  getTotalDistance(route: navi.Route): number {
    if (route === undefined || route.steps === undefined) {
      return 0;
    }
    let distance: number = 0;
    for (let index = 0; index < route.steps.length; index++) {
      if (route.steps[index] !== undefined && route.steps[index].distance !== undefined) {
        distance += route.steps[index].distance!;
        Logger.info('Distance is ' + distance);
      }
    }
    return distance / 1000;
  }
}
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

export class RouteConstants {
  /**
   * Divider stroke width.
   */
  static readonly STROKE_WIDTH: number = 1;

  /**
   * Text input area width.
   */
  static readonly TEXT_INPUT_WIDTH: string = '60%';

  /**
   * Tab area width.
   */
  static readonly TAB_AREA_WIDTH: string = '80%';

  /**
   * Result list differ height.
   */
  static readonly LIST_DIFFER_HEIGHT: number = 40;

  /**
   * Minutes.
   */
  static readonly MINUTES: string = getContext(this).resourceManager.getStringSync($r('app.string.minutes').id);

  /**
   * Kilometres.
   */
  static readonly KILOMETRES: string = getContext(this).resourceManager.getStringSync($r('app.string.kilometers').id);

  /**
   * Topic icons.
   */
  static readonly TOPIC_ICONS_SELECTED: Resource[] = [
    $r('app.media.navigate'),
    $r('app.media.cycling'),
    $r('app.media.walking')
  ];

  /**
   * Footer tab topics.
   */


  static readonly TOPIC_LIST: string[] = [
    getContext(this).resourceManager.getStringSync($r('app.string.drive').id),
    getContext(this).resourceManager.getStringSync($r('app.string.cycling').id),
    getContext(this).resourceManager.getStringSync($r('app.string.walk').id),
    getContext(this).resourceManager.getStringSync($r('app.string.taxi').id),
    getContext(this).resourceManager.getStringSync($r('app.string.public_transportation').id),
    getContext(this).resourceManager.getStringSync($r('app.string.proxy_driving').id),
    getContext(this).resourceManager.getStringSync($r('app.string.train').id),
    getContext(this).resourceManager.getStringSync($r('app.string.passenger_car').id)
  ];
}
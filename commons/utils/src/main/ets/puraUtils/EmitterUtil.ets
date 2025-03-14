/*
 * Copyright (C) 2024 桃花镇童长老 @pura/harmony-utils
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
 *
 * https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 */

import { emitter } from '@kit.BasicServicesKit';
//import { NumberUtil } from './NumberUtil';
import { StrUtil } from './StrUtil';


/**
 * TODO Emitter工具类（进行线程间通信）
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class EmitterUtil {

  private constructor() {}


  /**
   * 发送事件
   * @param eventId 事件ID，string类型的eventId不支持空字符串。
   * @param data 发送的数据
   * @param EventPriority 事件被发送的优先级
   */
  static post<T>(eventId: string | number, data: T, priority: emitter.EventPriority = emitter.EventPriority.HIGH) {
    let eventData: emitter.EventData = { data: { "eventData": data } };
    let options: emitter.Options = { priority: priority };
    emitter.emit(eventId.toString(), options, eventData);
  }


  /**
   * 订阅事件
   * @param eventId 事件ID，string类型的eventId不支持空字符串。
   * @param callback 事件的回调处理函数。
   */
  static onSubscribe<T>(eventId: string | number, callback: (data: T) => void) {
    emitter.on(eventId.toString(), (eventData: emitter.EventData) => {
      callback(eventData.data?.eventData);
    });
  }


  /**
   * 单次订阅指定事件
   * @param eventId 事件ID，string类型的eventId不支持空字符串。
   * @param callback 事件的回调处理函数。
   */
  static onceSubscribe<T>(eventId: string | number, callback: (data: T) => void) {
    emitter.once(eventId.toString(), (eventData: emitter.EventData) => {
      callback(eventData.data?.eventData);
    });
  }


  /**
   * 取消事件订阅
   * @param eventId 事件ID，string类型的eventId不支持空字符串。
   */
  static unSubscribe(eventId: string | number) {
    emitter.off(eventId.toString());
  }


}
/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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

import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';
import { showDialog } from '../common/utils/DialogUtil';
import { CommonConstants, CookieOperation } from '../common/constants/CommonConstant';

/**
 * Link component.
 */
@Component
export struct LinkButton {
  buttonType?: string;
  isNeedDivider?: boolean;

  build() {
    Row() {
      Text(this.buttonType)
        .fontColor($r('app.color.link_blue'))
        .fontSize(CommonConstants.BUTTON_SIZE)
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Normal)
        .onClick(() => {
          this.operationMethod();
        })

      if (this.isNeedDivider) {
        Divider()
          .vertical(true)
          .margin(CommonConstants.DIVIDER_MARGIN)
          .height(CommonConstants.DIVIDER_HEIGHT)
      }
    }
  }

  operationMethod(): void {
    try {
      if (this.buttonType === CookieOperation.GET_COOKIE) {
        //获取指定url对应cookie的值
        let originCookie = webview.WebCookieManager.fetchCookieSync(CommonConstants.USER_CENTER_URL);
        showDialog(originCookie);
      } else if (this.buttonType === CookieOperation.SET_COOKIE) {
        //为指定url设置单个cookie的值
        webview.WebCookieManager.configCookieSync(CommonConstants.USER_ABOUT_URL, 'info=测试cookie写入');
        showDialog($r('app.string.write_success'));
      } else if (this.buttonType === CookieOperation.DELETE_COOKIE) {
        //清除所有cookie
        webview.WebCookieManager.clearAllCookiesSync();
        let deleteMessage = $r('app.string.delete_success');
        showDialog(deleteMessage);
      } else {
        router.pushUrl({
          url: CommonConstants.PAGE_VERIFY
        })
      }
    } catch (error) {
      showDialog('Operation failed.' + JSON.stringify(error));
    }
  }
}
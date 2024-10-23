/*
 * 此文件暂时不可用，需要在真机模式下才能使用kit.AccountKit
 * */

import { authentication } from '@kit.AccountKit'
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';

class HuaweiAuthPlugin{
  //创建一个account kit授权对象，可以通过返回值设置请求参数
  requestAuth(){
    const huaweiIdProvider = new authentication.HuaweiIDProvider;
    const authRequest = huaweiIdProvider.createAuthorizationWithHuaweiIDRequest()

    authRequest.scopes = ['profile', 'openid']
    authRequest.permissions = ['serviceauthcode', 'idtoken']
    authRequest.forceAuthorization = true;
    // 执行授权请求，并处理结果
    try {
      let controller = new authentication.AuthenticationController(getContext(this));
      controller.executeRequest(authRequest, (err: BusinessError<Object>, data) => {
        if (err) {
          this.dealAllError(err);
          return;
        }
        let authorizationWithHuaweiIDResponse = data as authentication.AuthorizationWithHuaweiIDResponse;
        let state = authorizationWithHuaweiIDResponse.state;
        if (state != undefined && authRequest.state != state) {
          hilog.error(0x0000, 'testTag', `Failed to authorize. The state is different, response state: ${state}`);
          return;
        }
        hilog.info(0x0000, 'testTag', 'Succeeded in authentication.');
        let authorizationWithHuaweiIDCredential = authorizationWithHuaweiIDResponse.data!;
        let avatarUri = authorizationWithHuaweiIDCredential.avatarUri; // 元服务不支持该字段
        let nickName = authorizationWithHuaweiIDCredential.nickName; // 元服务不支持该字段
        let idToken = authorizationWithHuaweiIDCredential.idToken;
        let unionID = authorizationWithHuaweiIDCredential.unionID;
        let openID = authorizationWithHuaweiIDCredential.openID;
        // 开发者处理avatarUri, nickName, idToken, unionID, openID
        console.log("TestTag avatarUri,nickName,unionID", avatarUri, nickName, unionID)
      });
    } catch (error) {
      this.dealAllError(error);
    }
  }
  // 错误处理
  dealAllError(error: BusinessError<Object>): void {
    hilog.error(0x0000, 'testTag', `Failed to auth. Code: ${error.code}, message: ${error.message}`);
    }
}

export const huaweiAuthPlugin = new HuaweiAuthPlugin();
import http from "@ohos:net.http";
import { TokenValue } from "@bundle:com.example.ictproject/default@Login/ets/viewmodel/UserInfoItem";
import type { BusinessError } from "@ohos:base";
export function getToken(codeValue: string) {
    let httpRequest = http.createHttp();
    let responseResult = httpRequest.request(`https://oauth-login.cloud.huawei.com/oauth2/v3/token?grant_type=authorization_code&code=${codeValue}&client_id=111715523&client_secret=bd4ce6600688291bbf0d3be54f9357b36987ebc48aefa62f168a1974d9edfc35&redirect_uri=http://ireadbook.html`, {
        method: http.RequestMethod.POST,
        header: {
            'Content-Type': 'application/x-www-form-urlencoded',
        }
    });
    return responseResult.then((value) => {
        if (value.responseCode === 200) {
            //获取返回的数据
            console.log('testTag: ', value.result.toString());
            return JSON.parse(value.result.toString()) as TokenValue;
        }
        return new TokenValue();
    }).catch((error: BusinessError) => {
        console.log(error.code.toString());
    });
}

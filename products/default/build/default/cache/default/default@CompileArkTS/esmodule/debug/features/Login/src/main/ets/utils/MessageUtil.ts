import http from "@ohos:net.http";
import type { BusinessError } from "@ohos:base";
import { PersonalMsg } from "@bundle:com.example.ictproject/default@Login/ets/viewmodel/UserInfoItem";
//根据id_token获取个人信息
export function getPersonalMsg(id_token: string) {
    let httpRequest = http.createHttp();
    let responseResult = httpRequest.request(`https://oauth-login.cloud.huawei.com/oauth2/v3/tokeninfo?`, {
        method: http.RequestMethod.POST,
        header: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        extraData: 'id_token=' + id_token,
    });
    return responseResult.then((value) => {
        if (value.responseCode === 200) {
            // 获取返回的数据
            console.log('testTag PersonalMsg: ', value.result.toString());
            return JSON.parse(value.result.toString()) as PersonalMsg;
        }
        return new PersonalMsg();
    }).catch((error: BusinessError) => {
        console.log(error.code.toString());
    });
}

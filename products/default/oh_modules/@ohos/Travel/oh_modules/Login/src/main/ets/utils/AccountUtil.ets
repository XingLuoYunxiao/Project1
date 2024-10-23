import http from '@ohos.net.http'
import { TokenValue } from '../viewmodel/UserInfoItem'
import { BusinessError } from '@ohos.base'
export function getToken(codeValue:string){
  let httpRequest = http.createHttp()
  let responseResult = httpRequest.request(
    `https://oauth-login.cloud.huawei.com/oauth2/v3/token?grant_type=authorization_code&code=${codeValue}&client_id=112219945&client_secret=6e3030e330e405857b1a2460fcd90dae72b362fc4502638d03304075468844be&redirect_uri=http://guyunyouzong.html`,
    {
      method: http.RequestMethod.POST,
      header:{
        'Content-Type':'application/x-www-form-urlencoded',
      }
    })
  return responseResult.then((value) => {
    if (value.responseCode === 200) {
      //获取返回的数据
      console.log('testTag: ', value.result.toString())
      return JSON.parse(value.result.toString()) as TokenValue
    }
    return new TokenValue()
  }).catch((error: BusinessError) => {
    console.log(error.code.toString())
  })
}

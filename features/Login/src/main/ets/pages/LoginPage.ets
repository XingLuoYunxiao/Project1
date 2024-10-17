import { webview } from '@kit.ArkWeb'
import { router } from '@kit.ArkUI'
import { getToken } from '../utils/AccountUtil'
import { getPersonalMsg } from '../utils/MessageUtil'

@Component
export struct LoginPage {
  @Consume('loginPathStack') loginPathStack: NavPathStack
  controller: webview.WebviewController = new webview.WebviewController()
  build() {
    NavDestination(){
      Column(){
        Web({ src: $rawfile('Index.html'), controller: this.controller })
          .onLoadIntercept((event) => {
            let url: string = event.data.getRequestUrl()
            console.log("url: ", url)
            // 正则表达式，用于匹配 code 参数
            const regex = /code=([^&]+)/;

            // 使用正则表达式匹配 URL 中的 code 参数
            const match = regex.exec(url);

            // 检查是否有匹配项，并提取 code 的值
            const code = match ? match[1] : null;
            console.log(code);
            if (url.indexOf('http://guyunyouzong.html') === 0 && code) {
              this.handleLogin(code)
              // 跳转APP主界面
              this.loginPathStack.pop()
              return true
            }
            return false
          })
      }
    }
  }

  async handleLogin(code: string) {
    try {
      let tokenValue = await getToken(code)
      if (tokenValue && tokenValue.id_token) {
        let personalMsg = await getPersonalMsg(tokenValue.id_token)
        if (personalMsg && personalMsg.display_name) {
          AppStorage.setOrCreate('personName', personalMsg.display_name)
        }
      }
    } catch (error) {
      console.error('Login failed:', error)
    }
  }
}
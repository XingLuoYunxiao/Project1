import { webview } from '@kit.ArkWeb';
import { CommonConstants, CookieOperation } from '../common/constants/CommonConstant';
import { LinkButton } from '../view/LinkButton'
import { showDialog } from '../common/utils/DialogUtil';

/**
 * Home page.
 */
@Component
export struct LoginWebPage {
  @Consume('loginPathStack') loginPathStack: NavPathStack
  controller: webview.WebviewController = new webview.WebviewController()

  build() {
    NavDestination(){
      Column() {
        Text($r('app.string.navigator_name'))
          .fontSize(CommonConstants.NAVIGATOR_SIZE)
          .fontWeight(CommonConstants.FONT_WEIGHT_DEEPER)
          .fontColor($r('app.color.navigator_black'))
          .width(CommonConstants.FULL_WIDTH)
          .margin({
            top: CommonConstants.APP_TITLE_MARGIN_TOP,
            left: CommonConstants.APP_TITLE_MARGIN_LEFT
          })

        Text($r('app.string.title_name'))
          .fontSize(CommonConstants.TITLE_SIZE)
          .fontWeight(CommonConstants.FONT_WEIGHT_DEEPER)
          .fontColor($r('app.color.title_black'))
          .textAlign(TextAlign.Center)
          .width(CommonConstants.WEB_WIDTH)
          .height(CommonConstants.PAGE_TITLE_HEIGHT)
          .margin({
            top: $r('app.float.page_title_margin_top'),
            bottom: $r('app.float.page_title_margin_bottom')
          })

        Web({
          src: CommonConstants.USER_CENTER_URL,
          controller: this.controller
        })
          //设置是否开启文档对象模型存储接口（DOM Storage API）权限
          //Session Storage和Local Storage前者为临时数据，其存储与释放跟随会话生命周期；后者为可持久化数据，落盘在应用目录下。
          .domStorageAccess(true)
          .javaScriptAccess(true)
          .height(CommonConstants.WEB_HEIGHT)
          .width(CommonConstants.WEB_WIDTH)
          .margin({ bottom: CommonConstants.WEB_MARGIN_BOTTOM })
          .onErrorReceive((event) => {
            //判断资源请求是否为主frame。
            //判断资源请求是否为主frame的原因：
            // 安全性：通常，对于主frame的请求会有更严格的权限控制，以确保不会加载恶意内容。
            // 性能：主frame的资源加载通常比子frame的资源加载更重要，因为它们直接影响到用户体验。
            // 资源加载策略：不同的框架可能有不同的资源加载策略，例如广告框架可能需要在特定条件下加载。
            if (event?.request.isMainFrame()) {
              let message = $r('app.string.load_error');
              showDialog(message);
            }
          })

        Row() {
          LinkButton({ buttonType: CookieOperation.GET_COOKIE, isNeedDivider: true })
          LinkButton({ buttonType: CookieOperation.SET_COOKIE, isNeedDivider: true })
          LinkButton({ buttonType: CookieOperation.DELETE_COOKIE, isNeedDivider: true })
          LinkButton({ buttonType: CookieOperation.VERIFY_COOKIE, isNeedDivider: false })
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width(CommonConstants.WEB_WIDTH)
      }
      .backgroundColor($r('app.color.page_background_grey'))
      .width(CommonConstants.FULL_WIDTH)
      .height(CommonConstants.FULL_HEIGHT)
    }
  }
}


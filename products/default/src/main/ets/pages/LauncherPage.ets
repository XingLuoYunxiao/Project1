import { router } from '@kit.ArkUI'
import { CustomDialogComponent } from '@ohos/login'
import { common } from '@kit.AbilityKit'
import { PreferenceUtil  as preferenceUtil } from '@ohos/utils'

const PREF_KEY = 'iReadUserKey'

@Entry
@Component
struct LauncherPage {
  context = getContext(this) as common.UIAbilityContext
  controller: CustomDialogController = new CustomDialogController({
    builder: CustomDialogComponent({
      confirm: (): void => this.onConfirm(),
      cancel: (): void => this.exitApp()
    })
  })

  async onPageShow(): Promise<void> {
    // 加载首选项
    let isAgree  = await preferenceUtil.getPreferenceValue(PREF_KEY, false)

    // 判断是否同意
    if( isAgree)
    // 同意跳转页面
      this.jumpToIndex()
    //不同意，退出
    else{
      this.controller.open()
    }
  }

  jumpToIndex(){
    setTimeout( () => {
      router.replaceUrl({
        url: 'pages/AdvertisingPage'
      })
    })
  }

  onConfirm(){
    // 1.保存首选项
    preferenceUtil.putPreferenceValue(PREF_KEY, true)
    // 2.跳转到主页
    this.jumpToIndex()
  }

  exitApp(){
    //退出
    this.context.terminateSelf()
  }

  build() {
    Column({space:10}){
      Image($r('app.media.launcher'))
        .objectFit(ImageFit.Fill)

    }
    .height('100%')
    .width('100%')
  }
}
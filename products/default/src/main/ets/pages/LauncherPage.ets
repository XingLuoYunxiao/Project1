import { router } from '@kit.ArkUI'
import { CustomDialogComponent } from 'login'
import { common } from '@kit.AbilityKit'
import { PreferenceUtil  as preferenceUtil } from 'utils'
import { BusinessError } from '@kit.BasicServicesKit'
import Logger from 'utils/src/main/ets/utils/Logger'

const PREF_KEY = 'GuYunUserKey'
const TAG: string = '[LauncherPage]';

// TODO 第一次安装应用时弹出定位点击同意后，不出现隐私服务弹窗
@Entry
@Component
struct LauncherPage {
  context = getContext(this) as common.UIAbilityContext
  isAgree: boolean = false
  private PreferenceUtil: preferenceUtil = preferenceUtil.getInstance()
  controller: CustomDialogController = new CustomDialogController({
    builder: CustomDialogComponent({
      confirm: (): void => this.onConfirm(),
      cancel: (): void => this.exitApp()
    })
  })

  async onPageShow(): Promise<void> {
    // 加载首选项
    this.PreferenceUtil.getPreferenceValue<boolean>(PREF_KEY).then( (res) => {
      this.isAgree = res ?? false
    })

    if (this.isAgree) {
      this.PreferenceUtil.putPreferenceValue(PREF_KEY, true).then(() => {
        Logger.info(TAG, 'Put the value of isAgreedPrivacy Successfully.');
        this.jumpToIndex()
      }).catch((err: BusinessError) => {
        Logger.error(TAG, 'Put the value of isAgreedPrivacy Failed, err: ' + err);
      });
    } else {
      this.PreferenceUtil.getPreferenceValue<boolean>(PREF_KEY).then((isAgreed: boolean | null) => {
        if (isAgreed) {
          this.jumpToIndex()
        } else {
          this.controller.open()
        }
      }).catch((err: BusinessError) => {
        Logger.error(TAG, 'check isAgreedPrivacy Failed, err: ' + err);
      });
    }
  }

  checkAgreedPrivacy(): void {

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
    this.PreferenceUtil.putPreferenceValue<boolean>(PREF_KEY, true)
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
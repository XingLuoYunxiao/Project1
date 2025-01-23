import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError, request } from '@kit.BasicServicesKit'
import { buffer } from '@kit.ArkTS';
import auth from '@hw-agconnect/auth';
import { initialize } from '@hw-agconnect/hmcore';
import { AppUtil } from "utils/src/main/ets/puraUtils/AppUtil"
import { PreferencesUtil } from "utils/src/main/ets/puraUtils/PreferencesUtil"
import { EXP } from "culture/src/main/ets/model/EXP"
import { LogUtil } from "utils/src/main/ets/puraUtils/LogUtil"
import lpreferencesUtil from 'login/src/main/ets/common/utils/PreferenceUtil'
import {abilityAccessCtrl,AbilityConstant, common, PermissionRequestResult, Permissions, UIAbility, Want } from '@kit.AbilityKit';
import { display, window } from '@kit.ArkUI';
import { KeyboardAvoidMode } from '@kit.ArkUI';
import { WindowUtil } from 'utils'

const TAG: string = 'EntryAbility';
const domain = 0x0011; //定位模块

export default class EntryAbility extends UIAbility {
  private windowObj?: window.Window;


  async onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): Promise<void> {
    await lpreferencesUtil.loadPreference(this.context,'UserInfoPreference')

    // 初始化方法,缓存全局变量
    AppUtil.init(this.context);

    this.initAgc()
    let file = this.context.resourceManager.getRawFileContentSync('agconnect-services.json');
    let json: string = buffer.from(file.buffer).toString();
    auth.init(this.context, json);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    this.initAgc()
    let atManager = abilityAccessCtrl.createAtManager();
    setTimeout(async () => {
      try {
        await atManager.requestPermissionsFromUser(this.context,
          ['ohos.permission.INTERNET', 'ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION'])
          .then((data) => {
            hilog.info(domain, TAG, `data: ${JSON.stringify(data)}`);
          })
          .catch((err: BusinessError) => {
            hilog.error(domain, TAG, `err: ${JSON.stringify(err)}`);
          })
      } catch (err) {
        hilog.error(domain, TAG, `catch err->${JSON.stringify(err)}`);
      }
    }, 1000)

  }

  async initAgc() {
    const value = await this.context.resourceManager.getRawFileContent('agconnect-services.json');
    let json: string = buffer.from(value).toString('utf8');
    console.log('json testTag: ' + json)
    initialize(this.context, JSON.parse(json));
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {

    // 将经验首选项初始化为[],方便之后取出后直接解析成数组
    // let EXPString: string = PreferencesUtil.getSync("EXP", "") as string;
    // if (EXPString === '') {
    //   let exp: EXP[] = []
    //   PreferencesUtil.putSync("EXP", JSON.stringify(exp))
    // }


    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    requestFullScreen(windowStage, this.context);

    windowStage.getMainWindow().then((data: window.Window) => {
      this.windowObj = data;
      this.updateWidthBp();
      this.updateHeightBp();
      this.windowObj.on('windowSizeChange', (windowSize: window.Size) => {
        this.updateWidthBp();
        this.updateHeightBp();
      })
    })

    let windowUtil: WindowUtil | undefined = WindowUtil.getInstance();
    if (windowUtil !== undefined) {
      windowUtil.setWindowStage(windowStage);
      windowUtil.setMainWindowPortrait();
    }
    windowStage.loadContent('pages/LauncherPage', (err, data) => {

      //设置软键盘为压缩模式,避让组件
      windowStage.getMainWindowSync().getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE);

      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }

      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });

  }

  private updateHeightBp(): void {
    if (this.windowObj === undefined) {
      return;
    }
    let mainWindow: window.WindowProperties = this.windowObj.getWindowProperties();
    let windowHeight: number = mainWindow.windowRect.height;
    let windowWidth: number = mainWindow.windowRect.width;
    let windowWidthVp = windowWidth / display.getDefaultDisplaySync().densityPixels;
    let windowHeightVp = windowHeight / display.getDefaultDisplaySync().densityPixels;
    let heightBp: string = '';
    let aspectRatio: number = windowHeightVp / windowWidthVp;
    if (aspectRatio < 0.8) {
      heightBp = 'sm';
    } else if (aspectRatio >= 0.8 && aspectRatio < 1.2) {
      heightBp = 'md';
    } else {
      heightBp = 'lg';
    }
    AppStorage.setOrCreate('currentHeightBreakpoint', heightBp);
  }


  private updateWidthBp(): void {
    if (this.windowObj === undefined) {
      return;
    }
    let mainWindow: window.WindowProperties = this.windowObj.getWindowProperties();
    let windowWidth: number = mainWindow.windowRect.width;
    let windowWidthVp = windowWidth / display.getDefaultDisplaySync().densityPixels;
    let widthBp: string = '';
    if (windowWidthVp < 320) {
      widthBp = 'xs';
    } else if (windowWidthVp >= 320 && windowWidthVp < 600) {
      widthBp = 'sm';
    } else if (windowWidthVp >= 600 && windowWidthVp < 840) {
      widthBp = 'md';
    } else if (windowWidthVp >= 840 && windowWidthVp < 1440) {
      widthBp = 'lg';
    } else {
      widthBp = 'xl';
    }
    AppStorage.setOrCreate('currentWidthBreakpoint', widthBp);
  }


  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}

function requestFullScreen(windowStage: window.WindowStage, context: Context): void {
  windowStage.getMainWindow((err: BusinessError, data: window.Window) => {
    if (err.code) {
      return;
    }
    let windowClass: window.Window = data;
    windowClass.setWindowLayoutFullScreen(true);
  });
}


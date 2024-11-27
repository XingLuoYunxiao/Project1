import { abilityAccessCtrl, AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit'
import { buffer } from '@kit.ArkTS';
import auth from '@hw-agconnect/auth';
import { initialize } from '@hw-agconnect/hmcore';
import { AppUtil } from "utils/src/main/ets/puraUtils/AppUtil"
import { PreferencesUtil } from "utils/src/main/ets/puraUtils/PreferencesUtil"
import { EXP } from "culture/src/main/ets/model/EXP"
import { LogUtil } from "utils/src/main/ets/puraUtils/LogUtil"

const TAG: string = 'EntryAbility';
const domain = 0x0011; //定位模块

export default class EntryAbility extends UIAbility {
  async onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): Promise<void> {

    // 初始化方法,缓存全局变量
    AppUtil.init(this.context);

    this.initAgc()
    let file = this.context.resourceManager.getRawFileContentSync('agconnect-services.json');
    let json: string = buffer.from(file.buffer).toString();
    auth.init(this.context, json);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    this.initAgc()
    let atManager = abilityAccessCtrl.createAtManager();
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
    let EXPString: string = PreferencesUtil.getSync("EXP", "") as string;
    LogUtil.debug("EXPstring:" + EXPString)
    if (EXPString === '') {
      let exp: EXP[] = []
      PreferencesUtil.putSync("EXP", JSON.stringify(exp))
    }

    
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    requestFullScreen(windowStage, this.context);


    windowStage.loadContent('pages/LauncherPage', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
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
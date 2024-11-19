import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit'
import { PreferenceUtil } from '@ohos/utils';
import { buffer } from '@kit.ArkTS';
import auth from '@hw-agconnect/auth';
import { initialize } from '@hw-agconnect/hmcore';

const TAG: string = 'EntryAbility';
const name = 'appEntryStore'


export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.initAgc()
    let file = this.context.resourceManager.getRawFileContentSync('agconnect-services.json');
    let json:string = buffer.from(file.buffer).toString();
    auth.init(this.context,json);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    PreferenceUtil.loadPreference(this.context, name)

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
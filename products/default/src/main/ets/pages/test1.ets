import { bundleManager } from '@kit.AbilityKit';
import { cloudDatabase } from '@kit.CloudFoundationKit';
import { BusinessError } from '@kit.BasicServicesKit';

let flag = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_SIGNATURE_INFO;
let bundleInfo = bundleManager.getBundleInfoForSelfSync(flag)
let appId = bundleInfo.signatureInfo.appId;

@Entry
@Component
struct test {

  build() {
    Column(){
      Button('点我').onClick(()=>{
        console.log("testTag appId: " + appId)
      })
        .alignSelf(ItemAlign.Auto)
    }
    .margin(100)
  }
}
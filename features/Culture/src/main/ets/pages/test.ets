import { BuilderNameConstants, RouterModule } from 'routermodule';
import { webview } from '@kit.ArkWeb';
import { common } from '@kit.AbilityKit';
import { FileUtil } from 'utils/src/main/ets/puraUtils/FileUtil';
import { LogUtil } from 'utils/src/main/ets/puraUtils/LogUtil';
import { fileUri } from '@kit.CoreFileKit';
import { CloudStorageConstants } from '../common/constants/cloudStorageConstants';
import { getPath } from '../common/util/getImage';

let context = getContext(this) as common.UIAbilityContext;
let path: string = context.cacheDir
const applicationContext = context.getApplicationContext();
const cacheDir = applicationContext.cacheDir;

@Component
export struct testPage {
  controller: webview.WebviewController = new webview.WebviewController();
  @State url: string = ''
  @State cachePath: string = path + "/culture" + "/calligraphy_chaoshu.png";
  @StorageProp('ImgPathsMap') ImgPathsMap: Map<string, string> = new Map<string, string>()

  aboutToAppear(): void {

  }

  build() {
    NavDestination() {

      Column() {
        Button('打印')
          .onClick(() => {

            LogUtil.print(FileUtil.listFileSync(path))
            // const dirPath: string = "culture/"
            // LogUtil.print(FileUtil.listFileSync(dirPath))
            let filePath = path + "/culture" + "/calligraphy_jiaguwen.png"
            let uri = fileUri.getUriFromPath(filePath);
            this.url = uri
            LogUtil.debug("this.url" + this.url)
            LogUtil.print(FileUtil.listFileSync(path + "/culture"))

            LogUtil.debug('cacheDir:' + cacheDir)
          })

        Text(this.cachePath)
        Text(fileUri.getUriFromPath(this.cachePath))
        Image(fileUri.getUriFromPath(this.cachePath))
          .width(100)

        Image(fileUri.getUriFromPath('painting_baihuazhengyan.png'))
          .width(100)
        Button('打印context.cacheDir')
          .onClick(() => {
            LogUtil.print(FileUtil.listFileSync(context.cacheDir));
            LogUtil.print(FileUtil.listFileSync(context.cacheDir + "/culture"));


          })

        Button('打印context.cacheDir + "/culture"')
          .onClick(() => {
            LogUtil.print(FileUtil.listFileSync(context.cacheDir + "/culture"));


          })
        Button('打印context.cacheDir + "/culture"' + "painting")
          .onClick(() => {
            LogUtil.print(FileUtil.listFileSync(context.cacheDir + "/culture" + "/painting"));


          })


        Button('打印路径')
          .onClick(() => {

            LogUtil.debug(getPath(CloudStorageConstants.getPaintingConstant('painting_fuchunshanju')))
            LogUtil.debug(fileUri.getUriFromPath(this.cachePath))
          })

        Image('file://com.application.ictprojectone/data/storage/el2/base/haps/default/cache/culture/painting_fuchunshanjutu.png')
          .width(100)
        //.alt($r('app.media.alt'))

      }

    }
  }
}

@Builder
export function testPageBuilder() {
  testPage()
}

const builderName = BuilderNameConstants.CULTURE_TEST
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(testPageBuilder)
  RouterModule.registerBuilder(builderName, builder)
}
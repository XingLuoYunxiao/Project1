import { BuilderNameConstants, RouterModule } from 'routermodule';
import { common } from '@kit.AbilityKit';
import { LogUtil } from 'utils/src/main/ets/puraUtils/LogUtil';
import fs, { ListFileOptions } from '@ohos.file.fs';
import { fileUri } from '@kit.CoreFileKit';
import { downloadImageListTest } from '../common/util/testUtil';

let context = getContext(this) as common.UIAbilityContext;
let cacheDir: string = context.cacheDir

const ImageList: string[] = [
  'culture/papercutting/paper1.jpg',
  'culture/papercutting/paper2.jpg',
  'culture/papercutting/paper3.jpg',
  'culture/papercutting/paper4.jpeg',
  'culture/papercutting/paper5.jpeg',
  'culture/papercutting/paper6.jpeg'
];

function getPath(str: string | undefined): string {
  return fileUri.getUriFromPath(cacheDir + '/' + str)
}

function listFileSync(path: string, options?: ListFileOptions): string[] {
  return fs.listFileSync(path, options);
}

@Component
export struct testPage {
  aboutToAppear(): void {
    downloadImageListTest(ImageList)
  }

  build() {
    NavDestination() {
      Column() {

        Button('打印')
          .onClick(() => {
            LogUtil.debug('cacheDir:' + cacheDir)
            LogUtil.print(listFileSync(cacheDir))
            LogUtil.print(listFileSync(cacheDir + "/culture"))
            LogUtil.print(listFileSync(cacheDir + "/culture/papercutting"))
          })

        ForEach(ImageList, (item: string) => {
          Image(getPath(item))
            .width(100)
        })
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
import { BuilderNameConstants, RouterModule } from 'routermodule';
import { webview } from '@kit.ArkWeb';


@Component
export struct testPage {
  controller: webview.WebviewController = new webview.WebviewController();

  build() {
    NavDestination() {
      Web({ src: $rawfile('my.html'), controller: this.controller })

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
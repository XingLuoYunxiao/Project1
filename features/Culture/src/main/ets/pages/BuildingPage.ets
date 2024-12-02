import { webview } from "@kit.ArkWeb";
import { BuilderNameConstants, RouterModule } from "routermodule";


@Component
export struct BuildingPage {
  controller: webview.WebviewController = new webview.WebviewController();

  build() {
    NavDestination() {
      Web({ src: $rawfile('my.html'), controller: this.controller })
        .margin({ top: $r('app.float.header_height_page') })
    }
  }
}

@Builder
export function BuildingPageBuilder() {
  BuildingPage()
}

const builderName = BuilderNameConstants.CULTURE_Building
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(BuildingPageBuilder)
  RouterModule.registerBuilder(builderName, builder)
}
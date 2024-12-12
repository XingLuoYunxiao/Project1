import { BuilderNameConstants, RouterModule } from 'routermodule';
import Constants from '../common/constants/Constants'

@Component
struct ShareDetail {
  build() {
    NavDestination(){
      Column(){

      }
    }
  .margin({top:Constants.HEADER_HEIGHT_PAGE})
  .hideTitleBar(true)
  }
}

@Builder
export function ShareDetailBuilder() {
  ShareDetail()
}

const builderName = BuilderNameConstants.SHARE_DETAILSHPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ShareDetailBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
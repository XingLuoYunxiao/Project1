import { BuilderNameConstants } from 'routermodule';
export { FamousPlacePage } from './src/main/ets/pages/FamousPlacePage'
export { TravelStartPage } from './src/main/ets/pages/TravelStartPage'
export { Spot } from './src/main/ets/model/Spot'
export { Params, TravelPlan } from './src/main/ets/service/TravelPlan'

export function harInit(builderName: string): void {
  // 动态引入要跳转的页面
  switch (builderName) {
    case BuilderNameConstants.TRAVEL_FAMOUSPLACEPAGE:
      import("./src/main/ets/pages/FamousPlacePage");
      break;
    case BuilderNameConstants.TRAVEL_ATTRACTIONTICKETPAGE:
      import("./src/main/ets/pages/AttractionTicketPage");
      break;
    case BuilderNameConstants.TRAVEL_ATTRACTIONDETAILPAGE:
      import("./src/main/ets/pages/AttractionDetailPage");
      break;
    case BuilderNameConstants.TRAVEL_LOADINGANIMATION:
      import("./src/main/ets/pages/LoadingAnimation");
      break;
    case BuilderNameConstants.TRAVEL_SEARCHPAGE:
      import("./src/main/ets/pages/SearchPage");
      break;
    case BuilderNameConstants.TRAVEL_SPOTDETAILPAGE:
      import("./src/main/ets/pages/SpotDetailPage");
      break;
    default:
      break;
  }
}
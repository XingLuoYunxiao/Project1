import { BuilderNameConstants } from 'routermodule';
export { FamousPlacePage } from './src/main/ets/pages/FamousPlacePage'
export { TravelStartPage } from './src/main/ets/pages/TravelStartPage'
export { Spot } from './src/main/ets/model/Spot'

export function harInit(builderName: string): void {
  // 动态引入要跳转的页面
  switch (builderName) {
    case BuilderNameConstants.TRAVEL_FAMOUSPLACEPAGE:
      import("./src/main/ets/pages/FamousPlacePage");
      break;
    default:
      break;
  }
}
import { BuilderNameConstants } from 'routermodule';

export { MapViewPage } from './src/main/ets/pages/MapViewPage'

export function harInit(builderName: string): void {
  // 动态引入要跳转的页面
  switch (builderName) {
    case BuilderNameConstants.MAP_MAPVIEWPAGE:
      import("./src/main/ets/pages/MapViewPage");
      break;
    case BuilderNameConstants.MAP_NAVIGATIONPAGE:
      import("./src/main/ets/pages/NavigationPage");
    case BuilderNameConstants.MAP_ROUTEPLANVIEW:
      import("./src/main/ets/pages/RoutePlanView");
    default:
      break;
  }
}
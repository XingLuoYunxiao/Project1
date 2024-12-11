import { BuilderNameConstants } from 'routermodule';
export { SharePage } from './src/main/ets/pages/SharePage';
export function harInit(builderName: string): void {
  // 动态引入要跳转的页面
  switch (builderName) {
    case BuilderNameConstants.SHARE_PUBLISHPAGE:
      import("./src/main/ets/pages/PublishPage");
      break;
    default:
      break;
  }
}

import { BuilderNameConstants } from 'routermodule';
export { InfoMessagePage } from './src/main/ets/pages/InfoMessagePage';
export { CustomDialogComponent } from './src/main/ets/view/CustomDialogComponent';
export function harInit(builderName: string): void {
  // 动态引入要跳转的页面
  switch (builderName) {
    case BuilderNameConstants.LOGIN_COLLECTIONPAGE:
      import("./src/main/ets/pages/CollectionPage");
      break;
    case BuilderNameConstants.LOGIN_ADVICEPAGE:
      import("./src/main/ets/pages/AdvicePage");
      break;
    case BuilderNameConstants.LOGIN_BROWSHISTORYPAGE:
      import("./src/main/ets/pages/BrowsHistoryPage");
      break;
    case BuilderNameConstants.LOGIN_CUSSERVICEPAGE:
      import("./src/main/ets/pages/CusServicePage");
      break;
    case BuilderNameConstants.LOGIN_KNOWLEDGEPAGE:
      import("./src/main/ets/pages/KnowledgePage");
      break;
    case BuilderNameConstants.LOGIN_MYORDER:
      import("./src/main/ets/pages/MyOrderPage");
      break;
    case BuilderNameConstants.LOGIN_PRIVACYPAGE:
      import("./src/main/ets/pages/PrivacyPage");
      break;
    case BuilderNameConstants.LOGIN_SETTINGPAGE:
      import("./src/main/ets/pages/SettingPage");
      break;
    case BuilderNameConstants.LOGIN_LOGINPAGE:
      import("./src/main/ets/pages/LoginPage");
      break;
    default:
      break;
  }
}
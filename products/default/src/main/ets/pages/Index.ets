import { TravelStartPage } from 'travel';
import { InfoMessagePage } from 'login';
import { CulturalHeritageStartPage } from 'culture';
import { TabBarType } from '../model/TabBarModel';
import { CustomTabBar } from '../components/CustomTabBar';
import { AppConstants } from '../constants/AppConstants';
import auth from '@hw-agconnect/auth';
import { LocationUtil } from 'utils';
import { RouterModule, RouterNameConstants } from 'routermodule';

@Entry
@Component
struct Index {
  @State currentIndex: number = TabBarType.TRAVEL;
  @StorageLink('isHideBar') isHideBar: boolean = false;
  @Provide('travelPathStack') travelPathStack: NavPathStack = new NavPathStack();
  @Provide('appPathStack') appPathStack: NavPathStack = new NavPathStack();
  @Provide('loginPathStack') loginPathStack: NavPathStack = new NavPathStack();
  private tabsController: TabsController = new TabsController();

  async aboutToAppear(): Promise<void> {
    await LocationUtil.getInstance().getCurrentLocation()
    AppStorage.setOrCreate('isHideBar', false);
    if( !this.appPathStack){
      this.appPathStack = new NavPathStack();
    }
    RouterModule.createRouter(RouterNameConstants.ENTRY_HAP, this.appPathStack)
  }

  @Builder
  routerMap(builderName: string, param: object) {
    // Obtain the WrappedBuilder object based on the module name, create a page through the builder interface, and import the param parameter.
    RouterModule.getBuilder(builderName).builder(param);
  };


  @Builder
  tabBarBuilder(title: string, targetIndex: number, selectedIcon: Resource, unselectIcon: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedIcon : unselectIcon)
        .width(24)
        .height(24)
      Text(title)
        .fontFamily('HarmonyHeiTi-Medium')
        .fontSize(10)
        .fontColor(this.currentIndex === targetIndex ? '#0A59F7' : 'rgba(0,0,0,0.60)')
        .textAlign(TextAlign.Center)
        .lineHeight(14)
        .fontWeight(500)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex;
      this.tabsController.changeIndex(targetIndex);
    })
  }

  build() {
    Navigation(this.appPathStack){
      Stack(){
        Flex({ direction: FlexDirection.RowReverse }){
          Tabs({ index: this.currentIndex  }) {
            TabContent() {
              TravelStartPage()
            }
            //.tabBar(this.tabBarBuilder('旅游', 0, $r("app.media.ic_tab_travel_on"), $r("app.media.ic_tab_travel_off")))

            TabContent() {
              CulturalHeritageStartPage()
            }
            TabContent() {
              Text('开发中')
                .align(Alignment.Center)
            }
            //.tabBar(this.tabBarBuilder('非遗', 1, $r("app.media.ic_tab_culture_on"), $r("app.media.ic_tab_culture_off")))

            TabContent() {
              InfoMessagePage()
            }
            //.tabBar(this.tabBarBuilder('我的', 2, $r("app.media.ic_tab_mine_on"), $r("app.media.ic_tab_mine_off")))

          }
          .layoutWeight(1)
          .barHeight(0)
          .scrollable(false)
          .vertical(false)
          .divider({
            strokeWidth: 0.5,
            color: '#0D182431'
          })
          .scrollable(false)
          .backgroundColor('#F1F3F5')
          .padding({ top: 36, bottom: 28 })
          .onChange((index) => {
            this.currentIndex = index;
          })

        }
        .width(AppConstants.FULL_PERCENT)
        .height(AppConstants.FULL_PERCENT)

        CustomTabBar({ currentIndex: $currentIndex})

      }
      .alignContent(Alignment.BottomEnd)

    }
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
    .navDestination(this.routerMap)
  }
}
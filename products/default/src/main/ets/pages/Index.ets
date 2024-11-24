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
  @Provide('travelPathStack') travelPathStack: NavPathStack = new NavPathStack();
  @Provide('appPathStack') appPathStack: NavPathStack = new NavPathStack();
  @Provide('loginPathStack') loginPathStack: NavPathStack = new NavPathStack();

  async aboutToAppear(): Promise<void> {
    await LocationUtil.getInstance().getCurrentLocation()
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

  build() {
    Navigation(this.appPathStack){
      Stack(){
        Flex({ direction: FlexDirection.Row}){
          Tabs({index:this.currentIndex}) {
            TabContent() {
              TravelStartPage()
            }

            TabContent() {
              CulturalHeritageStartPage()
            }

            TabContent() {
              Text('开发中')
                .align(Alignment.Center)
            }

            TabContent() {
              InfoMessagePage()
            }
          }
          .layoutWeight(1)
          //隐藏掉默认的tabbar
          .barHeight(0)
          .scrollable(false)
          .vertical(false)
          //分割线的线宽
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
      //Stack的属性,子组件的对齐方式
      .alignContent(Alignment.BottomEnd)

    }
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
    .navDestination(this.routerMap)
  }
}
import { TravelStartPage } from 'travel';
import { InfoMessagePage } from 'login';
import {  CulturalPage } from 'culture';
import { TabBarType } from '../model/TabBarModel';
import { CustomTabBar } from '../components/CustomTabBar';
import { AppConstants } from '../constants/AppConstants';
import auth from '@hw-agconnect/auth';
import { LocationUtil } from 'utils';
import { RouterModule, RouterNameConstants } from 'routermodule';
import { SharePage } from 'share';
import lpreferencesUtil from 'login/src/main/ets/common/utils/PreferenceUtil';

@Entry
@Component
struct Index {
  @State currentIndex: number = TabBarType.TRAVEL;
  @Provide('travelPathStack') travelPathStack: NavPathStack = new NavPathStack();
  @Provide('appPathStack') appPathStack: NavPathStack = new NavPathStack();
  @Provide('loginPathStack') loginPathStack: NavPathStack = new NavPathStack();
  @Provide('culturePathStack') culturePathStack: NavPathStack = new NavPathStack();

  async aboutToAppear(): Promise<void> {
    await LocationUtil.getInstance().getCurrentLocation()
    if( !this.appPathStack){
      this.appPathStack = new NavPathStack();
      AppStorage.setOrCreate('isHideBar', false);
    }
   RouterModule.createRouter(RouterNameConstants.ENTRY_HAP, this.appPathStack)

    const personUid=await lpreferencesUtil.getPreferenceValue('UserInfoPreference','personUid','')
    const personPhoto=await lpreferencesUtil.getPreferenceValue('UserInfoPreference','personPhoto','')
    const personName=await lpreferencesUtil.getPreferenceValue('UserInfoPreference','personName','')
    AppStorage.setOrCreate('personName',personName)
    AppStorage.setOrCreate('personPhoto',personPhoto)
    AppStorage.setOrCreate('personUid',personUid)
  }

  @Builder
  routerMap(builderName: string, param?: object) {
    RouterModule.getBuilder(builderName).builder(param);
  };


  build() {
    Navigation(this.appPathStack) {
      Stack() {
        Flex({ direction: FlexDirection.RowReverse }) {
          Tabs({ index: this.currentIndex }) {
            TabContent() {
              TravelStartPage()
            }
            TabContent() {
              CulturalPage()
            }
            TabContent() {
              SharePage()
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

        CustomTabBar({ currentIndex: $currentIndex })

      }
      //Stack的属性,子组件的对齐方式
      .alignContent(Alignment.BottomEnd)
    }
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
    .navDestination(this.routerMap)
  }
}
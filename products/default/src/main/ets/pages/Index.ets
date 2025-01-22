import { TravelStartPage } from 'travel';
import { InfoMessagePage } from 'login';
import { CulturalPage } from 'culture';
import { TabBarType } from '../model/TabBarModel';
import { CustomTabBar } from '../components/CustomTabBar';
import { AppConstants } from '../constants/AppConstants';
import { BreakpointConstants, BreakpointSystem, BreakpointTypeEnum, LocationUtil, WindowUtil } from 'utils';
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
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointTypeEnum.MD;
  @StorageLink('currentHeightBreakpoint') currentHeightBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('currentWidthBreakpoint') currentWidthBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;

  private breakpointSystem: BreakpointSystem = new BreakpointSystem(); // 断点系统实例

  async aboutToAppear(): Promise<void> {
    this.breakpointSystem.register(); // 注册断点系统
    await LocationUtil.getInstance().getCurrentLocation()
    if( !this.appPathStack){
      this.appPathStack = new NavPathStack();
      AppStorage.setOrCreate('isHideBar', false);
    }
    RouterModule.createRouter(RouterNameConstants.ENTRY_HAP, this.appPathStack)

    const personUid=await lpreferencesUtil.getPreferenceValue('UserInfoPreference','personUid','')
    const personPhoto=await lpreferencesUtil.getPreferenceValue('UserInfoPreference','personPhoto','')
    const personName=await lpreferencesUtil.getPreferenceValue('UserInfoPreference','personName','')

    AppStorage.setOrCreate('personUid',personUid)
    AppStorage.setOrCreate('personName',personName)
    AppStorage.setOrCreate('personPhoto',personPhoto)

  }

  /**
   * 在界面即将消失时调用，用于清理资源或取消订阅
   */
  aboutToDisappear(): void {
    // 获取WindowUtil的实例，可能未初始化所以可能是undefined
    let windowUtil: WindowUtil | undefined = WindowUtil.getInstance();
    // 如果WindowUtil实例不存在，则直接返回，无需执行后续操作
    if (windowUtil === undefined) {
      return;
    }
    // 取消对窗口大小变化事件的监听，以避免内存泄漏
    windowUtil.offWindowSizeChange();
  }

  @Builder
  routerMap(builderName: string, param?: object) {
    RouterModule.getBuilder(builderName).builder(param);
  };


  build() {
    Navigation(this.appPathStack) {
      Stack() {
        Flex({ direction: this.currentWidthBreakpoint === BreakpointConstants.BREAKPOINT_LG ? FlexDirection.RowReverse : FlexDirection.Column })
        {
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
          .padding({ top: 36})
          .onChange((index) => {
            this.currentIndex = index;
          })

          CustomTabBar({ currentIndex: $currentIndex })
        }
        .width(AppConstants.FULL_PERCENT)
        .height(AppConstants.FULL_PERCENT)


      }
      //Stack的属性,子组件的对齐方式
      //.alignContent(Alignment.BottomEnd)
    }
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
    .navDestination(this.routerMap)
  }
}
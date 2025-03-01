import { Classification } from '../view/Classficiation';
import { NearbyAttraction } from '../view/NearbyAttraction';
import { SearchHeader } from '../view/SearchHeader';
import { SpotNetFunc } from '../service/SpotNetFunc';
import { BreakpointConstants, BreakpointType, LoadingStatus, PreferenceUtil } from 'utils';
import { TravelSkeletonView } from '../view/TravelSkeletonView';


@Component
export struct TravelStartPage {
  @Consume('travelPathStack') travelPathStack: NavPathStack;
  @Consume('appPathStack') appPathStack: NavPathStack;
  @State spotNetWork: SpotNetFunc = SpotNetFunc.getInstance();
  @State loadAllState: string = LoadingStatus.OFF;
  PreferenceUtil: PreferenceUtil = PreferenceUtil.getInstance()
  @State swiperImage: Resource[] =
    [$r('app.media.swiper_xian'), $r('app.media.swiper_hangzhou'), $r('app.media.swiper_other1')]
  @StorageLink('currentHeightBreakpoint') currentHeightBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('currentWidthBreakpoint') currentWidthBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;

  async aboutToAppear(): Promise<void> {
    this.loadAllState = LoadingStatus.LOADING;
    if (this.spotNetWork.spots.length > 0) {
      this.loadAllState = LoadingStatus.SUCCESS;
    } else {
      await this.spotNetWork.getNearbySpots()
        .then((data) => {
          this.loadAllState = LoadingStatus.SUCCESS;
          this.spotNetWork.spots = data
        })
        .catch(() => {
          this.loadAllState = LoadingStatus.FAILED;
        });
    }
  }

  build() {
    Navigation(this.travelPathStack) {
      // 搜索栏
      SearchHeader();

      List() {
        ListItem() {
          // 顶部轮播图
          Swiper() {
            ForEach(this.swiperImage, (item: Resource) => {
              ListItem() {
                Image(item)
                  .objectFit(ImageFit.Fill)
                  .align(Alignment.TopStart)
                  .width('100%')
                  .backgroundColor('#ffffff')
                  .borderRadius(12)
                  .margin({ top: 10, left: 5, right: 5 })
                  .shadow({
                    color: '#cccccc',
                    radius: 5,
                    offsetX: 0,
                    offsetY: 2,
                  });
              }
              .padding({ right: $r('app.float.md_padding_margin') })
              .aspectRatio(2.4)
              .width('100%')

              //.height('20%');
            });
          }
          .autoPlay(true)
          .loop(true)
          .indicator(false)
          //.indicator(new DotIndicator().selectedColor('#FF7F50').color('#ffffff'))
          .displayCount(new BreakpointType({ sm: 1, md: 1, lg: 2 }).getValue(this.currentWidthBreakpoint))
          .width('100%')
          .margin({ top: 10 })
          .nextMargin(new BreakpointType<Length>({
            sm: 0,
            md: 0,
            lg: 100
          }).getValue(this.currentWidthBreakpoint))
          .padding({
            left: new BreakpointType({
              sm: $r('app.float.md_padding_margin'),
              md: $r('app.float.xxl_padding_margin'),
              lg: $r('app.float.xxl_padding_margin')
            }).getValue(this.currentWidthBreakpoint)
          })
        }

        ListItem() {
          Column() {
            // 旅游分类
            /*Text('热门分类')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .margin({ left: 10 })
              .fontColor('#444444');*/

            Classification()
              .padding({ top: 10, bottom: 10 });
          }
        }

        if (this.loadAllState === LoadingStatus.SUCCESS) {
          if(this.spotNetWork.spots && this.spotNetWork.spots.length > 0){
            ListItem() {
              NearbyAttraction()
                .width('100%')
                .layoutWeight(1);
            }
          }else{
            ListItem() {
              Column() {
                Text('很抱歉，当前区域暂时没有景点信息')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .margin({ left: 10 })
                  .fontColor('#444444');
              }
              .width("100%")
              .height("100%")
            }
          }
        } else if (this.loadAllState === LoadingStatus.LOADING) {
          ListItem() {
            TravelSkeletonView()
          }
        } else{
          ListItem() {
            Column() {
              Text('加载失败，请检查网络')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .margin({ left: 10 })
                .fontColor('#444444');
            }
            .width("100%")
            .height("100%")
          }
        }

        // .width('100%')
        // .layoutWeight(1)
        // .backgroundColor('#f8f9fa');
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .height('100%')
      .width('100%')

    }
    .hideTitleBar(true)
    .mode(NavigationMode.Stack);
  }
}



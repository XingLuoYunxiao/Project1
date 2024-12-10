import { Classification } from '../view/Classficiation';
import { NearbyAttraction } from '../view/NearbyAttraction';
import { SearchHeader } from '../view/SearchHeader';
import { SpotNetFunc } from '../service/SpotNetFunc';
import { LoadingStatus } from 'utils';


@Component
export struct TravelStartPage {
  @Consume('travelPathStack') travelPathStack: NavPathStack;
  @Consume('appPathStack') appPathStack: NavPathStack;
  @State spotNetWork: SpotNetFunc = SpotNetFunc.getInstance();
  @State loadAllState: string = LoadingStatus.OFF;
  @State swiperImage: Resource[] = [ $r('app.media.swiper_xian'), $r('app.media.swiper_hangzhou'), $r('app.media.swiper_other1')]

  async aboutToAppear(): Promise<void> {
    this.loadAllState = LoadingStatus.LOADING;
    this.spotNetWork.loadSpotsData()
      .then(() => {
        this.loadAllState = LoadingStatus.SUCCESS;
      })
      .catch(() => {
        this.loadAllState = LoadingStatus.FAILED;
      });
  }

  build() {
    Navigation(this.travelPathStack) {
      Column() {
        // 搜索栏
        SearchHeader();

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
            .width('100%')
            .height(230);
          });
        }
        .autoPlay(true)
        .loop(true)
        .indicator(new DotIndicator().selectedColor('#FF7F50').color('#ffffff'))
        .width('95%')
        .height(250)
        .margin({ top: 10 });


        // 旅游分类
        Text('热门分类')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .padding({ top: 15, bottom: 5 })
          .margin({ left: 10 })
          .fontColor('#444444');
        Classification().padding({ top: 10, bottom: 10 });

        if (this.loadAllState === LoadingStatus.SUCCESS) {
          // 附近景点
          Text('附近景点')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 20, left: 10, bottom: 10 })
            .fontColor('#444444');
          NearbyAttraction()
            .width('100%')
            .layoutWeight(1);
        } else {
          Text('加载中...')
            .fontSize(18)
            .fontColor('#aaaaaa')
            .alignSelf(ItemAlign.Center);
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#f8f9fa');
    }
    .hideTitleBar(true)
    .mode(NavigationMode.Stack);
  }


}



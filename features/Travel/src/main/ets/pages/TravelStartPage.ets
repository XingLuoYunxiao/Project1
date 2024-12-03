import { Classification } from '../view/Classficiation';
import { NearbyAttraction } from '../view/NearbyAttraction';
import { SearchHeader } from '../view/SearchHeader';
import { Database } from '@hw-agconnect/cloud';
import { BusinessError } from '@kit.BasicServicesKit';
import { Spot } from '../model/Spot';
import { SpotNetFunc } from '../service/SpotNetFunc';
import { LoadingStatus } from 'utils';
import { cloudDatabase } from '@kit.CloudFoundationKit';


@Component
export struct TravelStartPage {
  @Consume('travelPathStack') travelPathStack: NavPathStack;
  @Consume('appPathStack') appPathStack: NavPathStack;
  @State spotNetWork: SpotNetFunc = SpotNetFunc.getInstance()
  @State loadAllState: string =LoadingStatus.OFF
  @State swiperLoading: string = LoadingStatus.OFF
  @State spots: Spot[] = this.spotNetWork.spots
  private database:Database |null= null

  async aboutToAppear(): Promise<void> {
    this.loadAllState = LoadingStatus.LOADING
    this.spotNetWork.loadSpotsData().then(
      () => {
        this.loadAllState = LoadingStatus.SUCCESS
      }
    ).catch(()=>{
      this.loadAllState = LoadingStatus.FAILED
    })

    // 初始化
    let databaseZone = cloudDatabase.zone('Travel');
    let condition = new cloudDatabase.DatabaseQuery(Spot)
    databaseZone.query(condition, (err: BusinessError, res: Spot[]) => {
      if (err) {
        console.error(`查询失败，错误代码: ${err.code}, 错误信息: ${err.message}`);
      } else {
        console.info(`查询成功，结果: ${JSON.stringify(res)}`);
        this.spots = res
        this.swiperLoading = LoadingStatus.SUCCESS
      }
    })


  }

  build() {
    Navigation(this.travelPathStack){
      Column() {
        //搜索栏
        SearchHeader()

        //轮播图
        if( this.swiperLoading === LoadingStatus.SUCCESS){
          Swiper() {
            ForEach(this.spots, ( item: Spot) => {
              ListItem(){
                this.AttractionItem(item)
              }
              .width('100%')
              .height(230)
            })
          }
          .autoPlay(true)
          .loop(true)
          .indicator(false)
          .width('100%')
        }

        //旅游分类
        Classification()
          .padding({top:10,bottom:10})

        if( this.loadAllState === LoadingStatus.SUCCESS)
        {
          //附近景点
          NearbyAttraction()
            .width('100%')
            .layoutWeight(1)
        }

      }
      .width('95%')
      .height('100%')
      .backgroundColor($r('app.color.app_background_color'))
    }
    //.navDestination(this.travelStartRouter)
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)

  }


  @Builder
  AttractionItem(attraction: Spot){
    Stack() {
      if( $r(`${attraction.imageUrl}`) !== undefined){
        Image($r(`${attraction.imageUrl}`))
          .width('100%')
          .height(200)
          .borderRadius(10)

      }
      Text(attraction.name)
        .fontSize(18)
        .padding({top:5})
        .padding(5)
        .fontColor(Color.White)

    }
    .align(Alignment.TopStart)
    //.alignItems(HorizontalAlign.Start)
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(10)
    .margin({top:10})
  }
}

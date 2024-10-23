import {Attraction} from '../model/Attraction'
import { LoadingAnimation } from '../util/Loading';
import { Classification } from '../view/Classficiation';
import { NearbyAttraction } from '../view/NearbyAttraction';
import { SearchHeader } from '../view/SearchHeader';
import { AttractionDetailPage } from './AttractionDetailPage';
import { FamousPlacePage } from './FamousPlacePage';
import { MapDemo } from './MapDemo';

export const attractions: Attraction[] = [
  new Attraction(1, "长城", $r("app.media.attraction_1")),
  new Attraction(2, "故宫", $r("app.media.attraction_2")),
  new Attraction(3, "大唐不夜城", $r("app.media.attraction_3")),

]


@Component
export struct TravelStartPage {

  @Provide('travelPathStack') travelPathStack: NavPathStack = new NavPathStack();

  build() {
    Navigation(this.travelPathStack){
      Column() {
        //搜索栏
        SearchHeader()

        //轮播图
        Swiper() {
          ForEach(attractions, ( item: Attraction) => {
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

        //旅游分类
        Classification()
          .padding({top:10,bottom:10})


        //附近景点
        NearbyAttraction()
          .width('100%')
          .height('100%')

      }
      .width('95%')
      .height('100%')
      .backgroundColor($r('app.color.app_background_color'))
    }
    .navDestination(this.travelStartRouter)
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)

  }

  @Builder
  travelStartRouter(path: string){
    if( path === 'FamousPlacePage'){
      FamousPlacePage()
    }else if( path === 'LoadingAnimation'){
      LoadingAnimation()
    }else if( path === 'AttractionDetailPage'){
      AttractionDetailPage()
    }else if( path === 'MapDemo'){
      MapDemo()
    }
  }

  @Builder
  AttractionItem(attraction: Attraction){
    Stack() {

      Image(attraction.image)
        .width('100%')
        .height(200)
        .borderRadius(10)
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

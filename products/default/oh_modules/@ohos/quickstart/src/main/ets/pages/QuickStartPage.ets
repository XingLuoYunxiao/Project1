import {Attraction} from '../model/Attraction'
import { Classification } from '../view/Classficiation';
import { NearbyAttraction } from '../view/NearbyAttraction';
import { SearchHeader } from '../view/SearchHeader';

export const attractions: Attraction[] = [
  new Attraction(1, "长城", $r("app.media.attraction_1")),
  new Attraction(2, "故宫", $r("app.media.attraction_2")),
  new Attraction(3, "大唐不夜城", $r("app.media.attraction_3")),

]


@Entry
@Component
export struct QuickStartPage {

  build() {
    Column() {

      SearchHeader()

      Swiper() {
        ForEach(attractions, ( item: Attraction, index) => {
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

      Classification()
        .padding({top:10,bottom:10})

      NearbyAttraction()
        .width('100%')
        .height('100%')

    }
    .width('95%')
    .height('100%')
    .backgroundColor('#F1F3F5')
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

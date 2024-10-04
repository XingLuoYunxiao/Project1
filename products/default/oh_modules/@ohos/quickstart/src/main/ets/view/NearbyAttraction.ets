import { Attraction } from "../model/Attraction"

//西安附近的景点，要有简介
const nearbyAttractions: Attraction[] = [
  new Attraction(4, "秦始皇兵马俑博物馆", $r("app.media.nearby_1"), "秦始皇兵马俑博物馆位于陕西省西安市，是中国最著名的考古遗址之一，展示了秦始皇的陵墓及其壮观的兵马俑军队。"),
  new Attraction(5, "大雁塔", $r("app.media.nearby_2"), "大雁塔是唐代著名的佛塔，位于陕西省西安市，是玄奘法师为保存从印度带回的佛经而建。"),
  new Attraction(6, "西安城墙", $r("app.media.nearby_4"), "西安城墙是中国现存规模最大、保存最完整的古代城垣，是明代初年在唐长安城的基础上扩建而成的。"),
  new Attraction(7, "钟楼", $r("app.media.nearby_3"), "钟楼位于西安市中心，是明代建筑的典范，历史上用于晨钟暮鼓，现在是西安的标志性建筑之一。"),
  new Attraction(3, "大唐不夜城", $r("app.media.attraction_3"), "大唐不夜城位于陕西省西安市，是一个集文化、旅游、商业于一体的综合性旅游景区，以唐代皇家园林为主题，展现了盛唐时期的繁荣景象。"),
]

//定义一个景点距离数组
const distances: number[] = [
  12.2, 5.1, 36.6, 17.2, 49.8
]


@Component
export struct NearbyAttraction {
  build() {
    Column(){
      Text('附近景点')
        .fontSize(18)
        .padding({top:10})
      List() {
        ForEach(nearbyAttractions, (item: Attraction, index) => {
          ListItem(){
            this.NearbyItem(item, distances[index])
          }
        })
      }
      .edgeEffect(EdgeEffect.Spring, {alwaysEnabled:true})
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
      .listDirection(Axis.Vertical)
      .layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height('100%')
    .layoutWeight(1)

  }

  @Builder
  NearbyItem(attraction: Attraction, index:number){
    Row(){
      Column(){
        Image(attraction.image)
          .width('100%')
          .height(60)
        Text(attraction.name)
          .fontSize(14)
          .padding({top:5})
          .fontColor(Color.Black)
          .fontWeight(500)
      }
      .width('40%')
      .padding(8)
      .alignItems(HorizontalAlign.Center)

      Column(){
        Text(`距离 ${index}km`)
          .fontSize(16)
        Text(attraction.description)
          .fontSize(14)
          .padding({top:5})
          .fontColor(Color.Gray)
          .textOverflow({overflow: TextOverflow.Ellipsis})
          .maxLines(3)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.End)

    }
    .borderRadius(10)
    .backgroundColor(Color.White)
    .height(100)
    .width('100%')
    .padding(10)

  }
}
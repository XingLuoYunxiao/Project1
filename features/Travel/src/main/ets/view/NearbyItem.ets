import Constants from '../constants/Constants'
import { Spot } from '../model/Spot'
import { CloudStorageService } from '../service/CloudStorageService'


@Component
export struct NearbyItem{
  @Prop attraction: Spot
  @Prop spotDistanceMap: Map<string, string> = new Map()
  @State cloudService: CloudStorageService = CloudStorageService.getInstance()
  @State url: string | undefined = undefined
  @State isLoading: boolean = false

  aboutToAppear(){
    if( this.attraction && this.attraction.imageUrl)
      this.cloudService.getTravelSpotURL(this.attraction.imageUrl).then(url => {
        this.url = url
        this.isLoading = true
      })
  }

  build() {
    Row() {
      Column() {
        Image(this.url == undefined ? $r(`${this.attraction.imageUrl}`) : this.url)
          .width('100%')
          .height(60)

        Text(this.attraction.name)
          .fontSize(14)
          .padding({ top: 5 })
          .fontColor(Color.Black)
          .fontWeight(500)
      }
      .width('40%')
      .padding(8)
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text(`距离 ${this.spotDistanceMap.get(this.attraction.id?.toString())}km`)
          .fontSize(16)
        Text(this.attraction.summary)
          .fontSize(14)
          .padding({ top: 5 })
          .fontColor(Color.Gray)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(3)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.End)

    }
    .borderRadius(Constants.BORDER_RADIUS_MD)
    .backgroundColor(Color.White)
    .height(100)
    .width('100%')
    .padding(10)
    .margin(5)
  }
}
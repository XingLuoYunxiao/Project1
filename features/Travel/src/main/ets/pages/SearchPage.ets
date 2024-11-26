import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from 'routermodule'
import { PreferenceUtil } from 'utils'
import Constants from '../constants/Constants'
import { SpotNetFunc } from '../service/SpotNetFunc'

interface SearchDiscovery {
  icon: string,
  text: string,
  type: string
}

interface Recommendation {
  name: string,
  type: string
}


@Component
struct SearchPage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @State searchText: string = ''
  @State SpotNetWork:SpotNetFunc = SpotNetFunc.getInstance()
  @State preferenceUtil: PreferenceUtil = PreferenceUtil.getInstance()
  searchDiscovery: Array<SearchDiscovery> = [
    { icon: '🏨', text: '酒店', type: 'hotel' },
    { icon: '✈️', text: '机票', type: 'flight' },
    { icon: '🔥', text: '火车票', type: 'train' },
    { icon: '🚗', text: '打车', type: 'taxi' },
    { icon: '🎫', text: '门票', type: 'ticket' },
    { icon: '🗺️', text: '自由行', type: 'trip' }
  ]

  recommendations: Array<Recommendation> = [
    { name: '颐和园', type: '北京环度假区' },
    { name: '北京的酒店', type: '住宿' },
    { name: '故宫', type: '旅拍' },
    { name: '福州文化旅游品牌馆', type: '景点' },
    { name: '贵州·精选宝藏线路', type: '线路' }
  ]

  aboutToAppear(): void {
    // 从本地存储中获取搜索历史
    this.SpotNetWork.getSearchHistory()
  }


  build() {
    NavDestination(){
      Column() {
        // 搜索栏
        Row() {
          Image($r('app.media.ic_back'))
            .width(30)
            .height(30)
            .margin({left:5, right:5})
            .onClick( () =>{
              this.appPathStack.pop()
            })

          //将搜索按钮加入Search中
          Stack(){
            Search({ placeholder: "搜索目的地/景点/酒店等" })
              .layoutWeight(1)
              .height(40)
              .placeholderColor(Constants.COLOR_TEXT_LIGHT)
              .textFont({ size: Constants.FONT_CAPTION })
              .borderRadius(Constants.BORDER_RADIUS_MD)
              .onChange((value: string) => {
                this.searchText = value
              })


            Button('搜索')
              .height(30)
              .width(60)
              .padding(5)
              .fontColor(Color.White)
              .backgroundColor("#ff2acd71")
              .borderRadius(Constants.BORDER_RADIUS_MD)
              .onClick(() => {
                //跳转到搜索结果页面
                this.SpotNetWork.search(this.searchText)
                buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_ATTRACTIONTICKETPAGE, new Object({text: ""}))
                //this.appPathStack.pushPathByName('AttractionTicketPage', "")
              })
          }
          .borderRadius(Constants.BORDER_RADIUS_MD)
          .border({color: '#ff2acd71', width: 2, style: BorderStyle.Solid})
          .layoutWeight(1)
          .alignContent(Alignment.End)
        }
        .width(Constants.FULL_WIDTH)
        .height(40)
        .margin(Constants.MARGIN_SM)
        .padding({left:5, right: 10})

        // 搜索历史
        Column() {
          if( this.SpotNetWork.searchHistory.length !== 0){
            Row(){
              Text('搜索历史')
                .width(100)
                .height(30)
                .align(Alignment.TopStart)
                .fontSize(Constants.FONT_CAPTION)
                .fontWeight(FontWeight.Bold)
                .margin({ top: Constants.MARGIN_LG, bottom: Constants.MARGIN_MD })
              Blank()
              Image($r('app.media.ic_delete'))
                .width(24)
                .height(24)
                .fillColor(Color.Gray)
                .margin({ top: Constants.MARGIN_LG, bottom: Constants.MARGIN_MD })
                .onClick(() => {
                  this.SpotNetWork.clearSearchHistory()
                })
            }
            .width(Constants.FULL_WIDTH)
            .alignItems(VerticalAlign.Top)
            .justifyContent(FlexAlign.Center)

            Flex({ wrap: FlexWrap.Wrap }) {
              ForEach(this.SpotNetWork.searchHistory, (item: string) => {
                Text(item)
                  .fontSize(Constants.FONT_CAPTION)
                  .padding({ left: Constants.MARGIN_LG, right: Constants.MARGIN_LG })
                  .height(Constants.CATEGORY_HEIGHT)
                  .borderRadius(Constants.BORDER_RADIUS)
                  .backgroundColor(Constants.COLOR_BG)
                  .margin({ right: Constants.MARGIN_MD, bottom: Constants.MARGIN_MD })
                  .onClick( () => {
                    this.searchText = item
                    this.SpotNetWork.search(this.searchText);
                    buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_ATTRACTIONTICKETPAGE, new Object({text: ""}))
                    //this.appPathStack.replacePathByName('AttractionTicketPage', "")
                  })
              })
            }
          }
        }
        .width(Constants.FULL_WIDTH)
        .padding({ left: Constants.MARGIN_LG, right: Constants.MARGIN_LG })


        // 搜索发现
        Column() {
          Row(){
            Text('搜索发现')
              .fontSize(Constants.FONT_CAPTION)
              .fontWeight(FontWeight.Bold)
              .margin({ top: Constants.MARGIN_LG, bottom: Constants.MARGIN_MD })
          }
          .width(Constants.FULL_WIDTH)
          .alignItems(VerticalAlign.Top)

          Grid() {
            ForEach(this.searchDiscovery, (item:SearchDiscovery) => {
              GridItem() {
                Column() {
                  Text(item.icon)
                    .fontSize(24)
                  Text(item.text)
                    .fontSize(Constants.FONT_CAPTION)
                    .margin({ top: Constants.MARGIN_SM })
                }
                .alignItems(HorizontalAlign.Center)
              }
            })
          }
          .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr')
          .rowsGap(Constants.MARGIN_LG)
          .columnsGap(Constants.MARGIN_MD)
        }
        .padding({ left: Constants.MARGIN_LG, right: Constants.MARGIN_LG })



        // 推荐列表
        List() {
          ForEach(this.recommendations, (item: Recommendation) => {
            ListItem() {
              Row() {
                Text(item.name)
                  .fontSize(Constants.FONT_CAPTION)
                Text(item.type)
                  .fontSize(Constants.FONT_CAPTION)
                  .fontColor(Constants.COLOR_TEXT_LIGHT)
                  .margin({ left: Constants.MARGIN_MD })
              }
              .width(Constants.FULL_WIDTH)
              .padding(Constants.MARGIN_MD)
            }
            .backgroundColor(Color.White)
          })
        }
        .margin({ top: Constants.MARGIN_LG })
      }
      .width(Constants.FULL_WIDTH)
      .height(Constants.FULL_HEIGHT)
      .backgroundColor($r('app.color.app_background_color'))
      .margin({ top: Constants.HEADER_HEIGHT_PAGE })
    }
    .hideTitleBar(true)
    .backgroundColor($r('app.color.app_background_color'))

  }
}

@Builder
export function SearchPageBuilder() {
  SearchPage()
}

const builderName = BuilderNameConstants.TRAVEL_SEARCHPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(SearchPageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}

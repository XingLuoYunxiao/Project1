import { lvMarkdownIn, lvText } from "@luvi/lv-markdown-in"
import { BuilderNameConstants, RouterModule, RouterNameConstants } from "routermodule";
import Constants from "../constants/Constants";
import { Spot } from "../model/Spot";


@Component
export struct SpotDetailPage {
  @State spot: Spot = new Spot('-1','null' , "null", 'null', 0, {"latitude": 0, "longitude": 0}, 0, 'null', 'null', '', '', '', '');
  @Consume('travelPathStack') travelPathStack: NavPathStack;
  @Consume('appPathStack') appPathStack: NavPathStack;

  @State value: object = new Object()
  @State  myScale: number = 1
  @State voice: boolean = false;
  @State isLoading: boolean = false;
  @State responseText: string = '';
  @State aImage: Resource = $r('app.media.avator');



  async aboutToAppear(): Promise<void> {
    lvText.setTextSize(16)
    let spot = JSON.parse(JSON.stringify(this.value)).spot as Spot
    //let spot = await this.appPathStack.getParamByName('SpotDetailPage')[0] as Spot;
    this.spot = new Spot(spot.id, spot.name, spot.summary, spot.category, spot.rating, spot.location, spot.ticketPrice, spot.openingHours, spot.image, spot.cityCode, spot.cityId, spot.cityName);
    this.sendRequest(this.spot.name);

  }

  async sendRequest(content:string) {
    this.isLoading = true;
    this.responseText = '';
    try {
      if(this.spot.chats == undefined || this.spot.chats.length === 0)
        this.spot.addChat();
      this.spot.sendRequest(content, (chunk: string) => {
        this.responseText += chunk;
      });
    } catch (error) {
      console.error("Error:", error);
      this.responseText = '发生错误: ' + error.message;
    } finally {
      this.isLoading = false;
    }
  }

  build() {
    NavDestination(){
      Column() {
        Row(){
          Image($r('app.media.ic_back'))
            .width(30)
            .height(30)
            .onClick( () => {
              //this.appPathStack.pop();
              RouterModule.popToName(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_FAMOUSPLACEPAGE)
            })
          Row(){
            Text(this.spot.name)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .margin({right:15})
            Blank()
            if( this.voice === false){
              Image($r('app.media.voice_close'))
                .width(30)
                .height(30)
                .margin({left:15})
                .onClick( () => {
                  this.voice = true;
                })
            }else{
              Image($r('app.media.voice_open'))
                .width(30)
                .height(30)
                .margin({left:15})
                .onClick( () => {
                  this.voice = false;
                })
            }
          }
          .padding(5)
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
        }
        .width(Constants.FULL_WIDTH)
        .justifyContent(FlexAlign.Start)

        /*Image($r('app.media.gugong_map'))
          .width(Constants.FULL_WIDTH)
          .height(300)
          .borderRadius(10)
          .margin({top:10})
          .onClick( () => {
            this.travelPathStack.pushPathByName('MapDemo', true);
          })*/

        Column(){
          Text(`${this.spot.name}路径规划`)
            .fontSize(24)
            .fontColor(Color.White)
            .backgroundColor(Color.Orange)
            .borderRadius(10)
            .padding(5)
            .margin({top:10})
          if (this.isLoading) {
            LoadingProgress().width(50).height(50)
          }
          Scroll(){
            Column(){
              lvMarkdownIn({ text: this.responseText.toString() })
                .width(Constants.OUTER_WIDTH) // content为文本内容
                .padding(10)
            }
            .width(Constants.FULL_WIDTH)
          }
          .edgeEffect(EdgeEffect.Spring)
          .scrollable(ScrollDirection.Vertical)
        }
        .alignItems(HorizontalAlign.Start)

      }
      .width(Constants.OUTER_WIDTH)
      .height(Constants.FULL_HEIGHT)
    }
    .hideTitleBar(true)
    .margin({top:Constants.HEADER_HEIGHT_PAGE})
  }
}

@Builder
export function SpotDetailPageBuilder(value: object){
  SpotDetailPage({value:value})
}

const builderName = BuilderNameConstants.TRAVEL_SPOTDETAILPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(SpotDetailPageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}

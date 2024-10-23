import { HttpGet } from "@ohos/utils";
import { lvMarkdownIn, lvText } from "@luvi/lv-markdown-in"
import { Spot} from "../model/ISpot";


@Component
export struct SpotDetailPage {
  @State spot: Spot = new Spot('0','null' , "null", 'null', 0, {"latitude": 0, "longitude": 0}, 0, 'null', 'null');
  @Consume('travelPathStack') travelPathStack: NavPathStack;
  @State  myScale: number = 1
  @State voice: boolean = false;
  @State isLoading: boolean = false;
  @State responseText: string = '';



  async aboutToAppear(): Promise<void> {
    lvText.setTextSize(16)
    this.spot = await this.travelPathStack.getParamByName('SpotDetailPage')[0] as Spot;
    this.sendRequest(this.spot.name);
  }

  async sendRequest(content:string) {
    this.isLoading = true;
    this.responseText = '';
    try {
      await HttpGet.travelDetailGet(content, (chunk: string) => {
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
              this.travelPathStack.pop();
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
        .width('100%')
        .justifyContent(FlexAlign.Start)

        /*Image($r('app.media.gugong_map'))
          .width('100%')
          .height(300)
          .borderRadius(10)
          .margin({top:10})
          .onClick( () => {
            this.travelPathStack.pushPathByName('MapDemo', true);
          })*/

        Column(){
          Text('路径规划')
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
                .width('95%') // content为文本内容
                .padding(10)
            }
            .width('100%')
          }
          .edgeEffect(EdgeEffect.Spring)
          .scrollable(ScrollDirection.Vertical)
        }
        .alignItems(HorizontalAlign.Start)
        .backgroundColor($r('app.color.app_background_color'))

        Column(){

        }



        /*Column(){
          Image($r('app.media.avator'))
            .width(100)
            .height(150)
            .objectFit(ImageFit.Contain)
            .opacity(0.8)
            .scale({ x: this.myScale, y: this.myScale })
        }
        .position({x:270, y:550})*/
      }
      .width('95%')
      .height('100%')
    }
    .backgroundColor($r('app.color.app_background_color'))
    .hideTitleBar(true)
  }
}

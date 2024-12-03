import { lvMarkdownIn, lvText } from "@luvi/lv-markdown-in"
import { TextToSpeechManager } from "aispeech";
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule";
import Constants from "../constants/Constants";
import { custom, Spot } from "../model/Spot";
import { Params, TravelPlan } from "../service/TravelPlan";
import { TipsDialog } from "@kit.ArkUI";

@Component
export struct SpotDetailPage {
  @State spot: Spot = new Spot()
  @Consume('travelPathStack') travelPathStack: NavPathStack;
  @Consume('appPathStack') appPathStack: NavPathStack;
  @State speechUtil: TextToSpeechManager = TextToSpeechManager.getInstance()
  //@StorageLink('isTravelPlanLoad') isTravelPlanLoad: boolean = false;
  @State value: object = new Object()
  @State  myScale: number = 1
  @Watch('speechText')
  @State voice: boolean = false;
  @State isLoading: boolean = false;
  @State isChecked: boolean = false;
  @State currentPlanSelected: number = 0;
  @Watch('speechText')
  @State responseText: string = '';
  @State aImage: Resource = $r('app.media.avator');
  @State customTravel:custom | undefined = undefined
  dialogControllerImage: CustomDialogController = new CustomDialogController({
    builder: TipsDialog({
      imageRes: $r('sys.media.ohos_ic_public_select_all'),
      content: '确定选择该方案吗?',
      primaryButton: {
        value: '取消',
        action: () => {
          this.isChecked = false;
          console.info('Callback when the first button is clicked')
        },
      },
      secondaryButton: {
        value: '确定',
        role: ButtonRole.ERROR,
        action: () => {
          this.isChecked = true;
          let params: Params = {
            spot: this.spot,
            travelPlan: this.customTravel!.travelPlans[this.currentPlanSelected]
          }
          buildRouterModel(RouterNameConstants.ENTRY_HAP,BuilderNameConstants.MAP_ROUTEPLANVIEW, new Object({params:params}))

          console.info('Callback when the second button is clicked')
        }
      },
      onCheckedChange: () => {
        console.info('Callback when the checkbox is clicked')
      }
    }),
  })


  async aboutToAppear(): Promise<void> {
    lvText.setTextSize(16)
    //let spot = await this.appPathStack.getParamByName('SpotDetailPage')[0] as Spot;
    this.spot = JSON.parse(JSON.stringify(this.value)).spot as Spot
    if( this.spot.name){
      this.sendRequest(this.spot.name);
    }
  }

  aboutToDisappear(): void {
    this.speechUtil.stop()
  }


  async sendRequest(content:string) {
    this.isLoading = true;
    this.responseText = '';
    try {
      if(this.spot.chats == undefined || this.spot.chats.length === 0)
        this.spot.addChat();
      /*this.spot.sendRequest(content, (chunk: string) => {
        this.responseText += chunk;
      });*/
      await this.spot.sendTravelRequest(content).then((res) => {
        this.customTravel = res
        if( Spot.resContent !== undefined){
          this.responseText = Spot.resContent
        }
      })
    } catch (error) {
      console.error("Error:", error);
      this.responseText = '发生错误: ' + error.message;
    } finally {
      this.isLoading = false;
    }
  }

  speechText(){
    if(this.voice){
      this.speechUtil.speak(this.responseText)
    }else{
      this.speechUtil.stop()
    }
  }

  build() {
    NavDestination(){
      Scroll(){
        Column() {
          Row(){
            Image($r('app.media.ic_back'))
              .width(30)
              .height(30)
              .onClick( () => {
                //this.appPathStack.pop();
                this.speechUtil.stop()
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
                    this.voice = !this.voice;
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

          /*Column(){
            Button('点我查询')
              .onClick(async ()=>{
                await this.queryAll()
              })
          }
  */
          Column(){
            Row(){
              Text(`${this.spot.name}路径规划`)
                .fontSize(24)
                .fontColor(Color.White)
                .backgroundColor(Color.Orange)
                .borderRadius(10)
                .padding(5)
                .margin({top:10})
              Blank()
              Button('重新生成')
                .backgroundColor(Color.Orange)
                .padding(5)
                .onClick(async ()=>{
                  this.isLoading = false;
                  if( this.spot.name){
                    this.sendRequest(this.spot.name)
                  }
                })
            }
            .alignItems(VerticalAlign.Center)
            .width(Constants.FULL_WIDTH)
            if (this.isLoading) {
              LoadingProgress().width(50).height(50)
            }
            /*Scroll(){
              Column(){
                lvMarkdownIn({ text: this.responseText.toString() })
                  .width(Constants.OUTER_WIDTH) // content为文本内容
                  .padding(10)
              }
              .width(Constants.FULL_WIDTH)
            }
            .edgeEffect(EdgeEffect.Spring)
            .scrollable(ScrollDirection.Vertical)*/
          }
          .margin({bottom:Constants.MARGIN_MD})

          .alignItems(HorizontalAlign.Start)
          if(this.customTravel !== undefined){
            Column(){
              List({space: 10}){
                ForEach(this.customTravel.travelPlans, (item:TravelPlan, index) => {
                  ListItem(){
                    Column({space: 10}){
                      Text(`方案${index+1}`)
                        .width(Constants.FULL_WIDTH)
                        .textAlign(TextAlign.Center)
                        .fontSize(20)
                        .fontWeight(FontWeight.Bold)
                        .margin({right:15})
                      Row(){
                        Text(`路线:`)
                          .fontSize(18)
                          .fontWeight(FontWeight.Bold)
                          .margin({right:15})
                        Flex({wrap: FlexWrap.Wrap, direction:FlexDirection.Row}){
                          ForEach(item.sites, (site:string, index) => {
                            if( index !== item.sites.length-1){
                              Text(`${site}->`)
                                .textAlign(TextAlign.Center)
                                .fontSize(16)
                                .fontWeight(FontWeight.Bold)
                            }else{
                              Text(`${site}`)
                                .textAlign(TextAlign.Center)
                                .fontSize(16)
                                .fontWeight(FontWeight.Bold)
                                .margin({right:15})
                            }
                          })
                        }
                        .padding(10)
                        .width(Constants.FULL_WIDTH)
                      }
                      .justifyContent(FlexAlign.Start)

                      Text(`  ${item.description}`)
                        .fontSize(16)
                        .fontWeight(FontWeight.Bold)
                        .margin({right:15})
                    }
                    .padding(5)
                    .alignItems(HorizontalAlign.Start)
                    .backgroundColor(Constants.ROUTE_PLAN_CARD)
                    .width(Constants.FULL_WIDTH)
                    .borderRadius(Constants.BORDER_RADIUS_MD)
                    .justifyContent(FlexAlign.Center)
                    .onClick(() => {
                      this.currentPlanSelected = index;
                      this.dialogControllerImage.open()
                    })
                  }
                })
              }
              Column({space: 10}){
                Text(`推荐路线`)
                  .width(Constants.FULL_WIDTH)
                  .textAlign(TextAlign.Center)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                Text(`${this.customTravel.recommendedRoute}`)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .margin({left:15})
              }
              .padding(5)
              .margin(10)
              .borderRadius(Constants.BORDER_RADIUS_MD)
              .width(Constants.FULL_WIDTH)
              .backgroundColor(Constants.ROUTE_PLAN_CARD)
              .alignItems(HorizontalAlign.Start)

            }
          }
        }
        .width(Constants.OUTER_WIDTH)
        .height(Constants.FULL_HEIGHT)
        .layoutWeight(1)
      }
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

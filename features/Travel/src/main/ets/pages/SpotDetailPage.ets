import {TextToSpeechManager} from "aispeech"
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule";
import Constants from "../constants/Constants";
import { Params, TravelPlan } from "../service/TravelPlan";
import { TipsDialog } from "@kit.ArkUI";
import { Spot } from "../model/Spot";
import { custom } from "../service/TravelChatsService";
import { TravelChatsService } from "../service/TravelChatsService";
import { lvMarkdownIn } from "@luvi/lv-markdown-in";

@Component
export struct SpotDetailPage {
  @State spot: Spot = new Spot()
  @Consume('travelPathStack') travelPathStack: NavPathStack;
  @Consume('appPathStack') appPathStack: NavPathStack;
  @State chatsService: TravelChatsService = TravelChatsService.getInstance()
  @State speechUtil: TextToSpeechManager = TextToSpeechManager.getInstance()
  @State value: object = new Object()
  @State myScale: number = 1
  @Watch('speechText')
  @State voice: boolean = false;
  @State isLoading: boolean = false;
  @State isChecked: boolean = false;
  @State currentPlanSelected: number = 0;
  @Watch('speechText')
  //AI回答内容
  @State responseText: string = '';
  //计划列表
  @State customTravel:custom | undefined = undefined

  // 是否显示方案
  @State isShowPlan:boolean = false

  // 对话框控制器
  dialogControllerImage: CustomDialogController = new CustomDialogController({
    builder: TipsDialog({
      imageRes: $r('sys.media.ohos_ic_public_select_all'),
      content: '确定选择该方案吗?',
      primaryButton: {
        value: '取消',
        action: () => {
          this.isChecked = false;
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
          buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.MAP_ROUTEPLANVIEW, new Object({params:params}))
        }
      },
    }),
  })

  async aboutToAppear(): Promise<void> {
    this.spot = JSON.parse(JSON.stringify(this.value)).spot as Spot
    if (this.spot.name) {
      await this.sendRequest(this.spot.name);
    }
  }

  aboutToDisappear(): void {
    this.speechUtil.stop()
  }

  // AI对话请求
  async sendRequest(content:string) {
    this.isLoading = true;
    this.responseText = '';
    try {
      this.chatsService.sendRequest(content, (chunk: string) => {
        this.responseText += chunk;
      }).then((res) => {
        this.customTravel = res
        if (this.chatsService.resContent !== undefined) {
          this.responseText = this.chatsService.resContent
          this.isShowPlan = true
        }
      });
      /*await this.chatsService.sendTravelRequest(content).then((res) => {
        this.customTravel = res
        if (this.chatsService.resContent !== undefined) {
          this.responseText = this.chatsService.resContent
        }
      })*/
    } catch (error) {
      console.error("Error:", error);
      this.responseText = '发生错误: ' + error.message;
    } finally {
      this.isLoading = false;
    }
  }

  speechText() {
    if (this.voice) {
      this.speechUtil.speak(this.responseText)
    } else {
      this.speechUtil.stop()
    }
  }

  // 语音状态切换构建器
  @Builder
  voiceToggleBuilder() {
    Row() {
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
      Text('语音播报')
        .fontSize(16)
        .fontColor('#333333')
        .margin({ right: 10 })

      Toggle({ type: ToggleType.Switch, isOn: this.voice })
        .onChange((isOn: boolean) => {
          this.voice = isOn
          this.speechText()
        })
        .selectedColor('#4CAF50')
    }
    .alignItems(VerticalAlign.Center)
  }

  // 路线方案卡片构建器
  @Builder
  routePlanCardBuilder(plan: TravelPlan, index: number) {
    Column() {
      // 方案标题
      Row() {
        Text(`方案 ${index + 1}`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')

        Blank()

        Text('详情')
          .fontSize(14)
          .fontColor('#666666')
      }
      .width('100%')
      .margin({ bottom: 10 })

      // 路线
      Flex({ wrap: FlexWrap.Wrap, direction: FlexDirection.Row }) {
        ForEach(plan.sites, (site: string, siteIndex: number) => {
          Row() {
            Text(site)
              .fontSize(16)
              .fontColor('#333333')
              .margin(4)

            if (siteIndex < plan.sites.length - 1) {
              Image($r('app.media.arrow_right'))
                .width(16)
                .height(16)
                .margin({ left: 4, right: 4 })
            }
          }
        })
      }
      .margin({ bottom: 10 })

      // 描述
      Text(plan.description)
        .fontSize(14)
        .fontColor('#666666')
        .margin({ bottom: 10 })
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // 选择按钮
      Button('选择此方案')
        .type(ButtonType.Normal)
        .backgroundColor('#2196F3')
        .fontColor(Color.White)
        .width('100%')
        .onClick(() => {
          this.currentPlanSelected = index;
          this.dialogControllerImage.open()
        })
    }
    .width('100%')
    .padding(15)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .shadow({
      radius: 5,
      color: '#10000000',
      offsetX: 0,
      offsetY: 2
    })
    .margin({ bottom: 10 })
  }

  build() {
    NavDestination() {
      Column() {
        // 顶部导航栏
        Row() {
          Image($r('app.media.ic_back'))
            .width(30)
            .height(30)
            .margin({ right: 15 })
            .onClick(() => {
              this.speechUtil.stop()
              RouterModule.popToName(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_FAMOUSPLACEPAGE)
            })

          Text(this.spot.name)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .layoutWeight(1)

          this.voiceToggleBuilder()
        }
        .width('100%')
        .padding(15)
        .backgroundColor('#F5F5F5')
        .alignItems(VerticalAlign.Center)

        if(!this.isShowPlan)
        {
          Scroll(){
            Column(){
              lvMarkdownIn({ text: this.responseText.toString() })
                .width(Constants.OUTER_WIDTH) // content为文本内容
                .padding(10)
            }
            .width(Constants.FULL_WIDTH)
          }
        }else{
          // 主内容区
          Scroll() {
            Column() {
              // 路径规划标题区
              Row() {
                Text(`${this.spot.name}路径规划`)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')

                Blank()

                Button('重新生成')
                  .type(ButtonType.Normal)
                  .backgroundColor('#2196F3')
                  .fontColor(Color.White)
                  .onClick(async () => {
                    if (this.spot.name) {
                      await this.sendRequest(this.spot.name)
                      this.isShowPlan = false
                    }
                  })
              }
              .width('100%')
              .padding(15)
              .backgroundColor('#F5F5F5')

              // 加载中
              if (this.isLoading) {
                Column() {
                  LoadingProgress()
                    .width(50)
                    .height(50)
                    .color('#2196F3')
                }
                .width('100%')
                .justifyContent(FlexAlign.Center)
                .padding(20)
              }

              // 旅行方案列表
              if (this.customTravel !== undefined) {
                Column() {
                  // 方案列表
                  List() {
                    ForEach(this.customTravel.travelPlans, (item: TravelPlan, index) => {
                      ListItem() {
                        this.routePlanCardBuilder(item, index)
                      }
                    })
                  }
                  .width('100%')
                  .divider({
                    strokeWidth: 1,
                    color: '#F0F0F0',
                    startMargin: 0,
                    endMargin: 0
                  })

                  // 推荐路线
                  Column() {
                    Text('推荐路线')
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#333333')
                      .margin({ bottom: 10 })

                    Text(this.customTravel.recommendedRoute)
                      .fontSize(16)
                      .fontColor('#666666')
                  }
                  .width('100%')
                  .padding(15)
                  .backgroundColor(Color.White)
                  .borderRadius(12)
                  .shadow({
                    radius: 5,
                    color: '#10000000',
                    offsetX: 0,
                    offsetY: 2
                  })
                  .margin({ top: 10 })
                }
                .width('100%')
                .padding(15)
              }
            }
            .width('100%')
          }
          .layoutWeight(1)
          .edgeEffect(EdgeEffect.Spring)
          .scrollBar(BarState.Off)
        }

      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
    .margin({top:$r('app.float.header_height_page')})
    .hideTitleBar(true)
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
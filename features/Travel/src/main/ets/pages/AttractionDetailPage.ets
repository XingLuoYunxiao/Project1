import { BuilderNameConstants, RouterModule } from 'routermodule';
import Constants from '../constants/Constants';
import { Spot } from '../model/Spot';
import { common, Want } from '@kit.AbilityKit';
import { SpotNetFunc } from '../service/SpotNetFunc';
import { promptAction } from '@kit.ArkUI';
import { CloudStorageService } from '../service/CloudStorageService';
import { SpotComment } from '../view/SpotComment';
import { BreakpointConstants } from 'utils';
import { SpotDetailComment } from './SpotDetailComment';

@Component
struct AttractionDetailPage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @State value: object = new Object()
  @State spot: Spot = new Spot()
  @StorageLink('personUid') personUid: string = '';
  @State orderData :string[] = ['可定今日', '可订明日', '更多日期']
  @State spotNetWork: SpotNetFunc = SpotNetFunc.getInstance()
  @State isSelected: number = 0
  @State selectedDate: Date = new Date()
  @State isCollectLoading: boolean = false
  @State cloudService: CloudStorageService = CloudStorageService.getInstance()
  @State url: string | undefined = undefined
  @StorageLink('currentWidthBreakpoint') currentWidthBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;



  aboutToAppear(): void {
    //获取路由参数
    this.spot = JSON.parse(JSON.stringify(this.value)).item as Spot
    //this.spot = this.appPathStack.getParamByName('AttractionDetailPage')[0] as Spot;
    //先尝试从缓存中获取
    if( SpotNetFunc.cacheImgMap.has(this.spot.imageUrl!)){
      this.url = SpotNetFunc.cacheImgMap.get(this.spot.imageUrl!)
    }else if( this.spot && this.spot.imageUrl)
    this.cloudService.getTravelSpotURL(this.spot.imageUrl).then(url => {
      this.url = url
    })
    //TODO 收藏状态和Login不同步问题,卸载应用后，会出现该页面收藏丢失的情况, 这里可以使用多线程来解决景点的查询匹配问题
    this.spotNetWork.getCollection().then(() => {
      if(  this.spot && this.spot.id && this.spotNetWork.collection.indexOf(this.spot.id) > 0){
        this.isCollectLoading = true
      }
    })

  }

  StartNavi = ()=>{
    if( this.spot.latitude !== undefined && this.spot.longitude !== undefined){
      let petalMapWant: Want = {
        bundleName: 'com.huawei.hmos.maps.app',
        uri: 'maps://routes', // 路径规划
        // uri: 'maps://navigation', // 导航
        parameters: {
          // 接入方业务名或包名，Link请求来源。
          linkSource: '用户到景点的导航',
          destinationLatitude: this.spot.latitude!,
          destinationLongitude: this.spot.longitude!,
          destinationName: `${this.spot.name}`,
          vehicleType: 0 // 交通出行工具。0-驾车， 1-步行， 2-骑行。默认驾车
        }
      }

      let context = getContext(this) as common.UIAbilityContext;
      context.startAbility(petalMapWant);
    }
  }


  build() {
    NavDestination(){
      Column() {
        Row() {
          Image($r('app.media.ic_back'))
            .width(24)
            .height(24)
            .margin({ left: 16 })
            .onClick(() => {
              this.appPathStack.pop()
            })
          Text('景区详情')
            .fontSize(Constants.FONT_TITLE)
            .fontWeight(FontWeight.Medium)
            .margin({ left: 12 })
          Blank()
          //TODO 首选项和用户模块的收藏数据不同步
          Image( this.isCollectLoading ? $r('app.media.ic_collection_fill') : $r('app.media.ic_collection'))
            .fillColor(Color.Orange)
            .width(24)
            .height(24)
            .margin({ right: 16 })
            .onClick(() => {
              // 收藏
              if(this.personUid !== '' && this.spot && this.spot.id){
                this.spotNetWork.updateCollection(this.spot.id, this.personUid)
                this.isCollectLoading = !this.isCollectLoading
              }else{
                promptAction.showToast({message: '请先登录', duration: 2000})
              }
            })
        }
        .width('100%')
        .height(48)
        .backgroundColor(Color.White)

        Scroll() {
          Column() {
            Stack({ alignContent: Alignment.BottomEnd }) {
              if( this.spot && this.spot.imageUrl){
                Image(this.url == undefined ? $r(`${this.spot.imageUrl}`) : this.url)
                  .width('100%')
                  .height(240)
                  .objectFit(ImageFit.Fill)
              }
            }

            // 注意
            Row() {
              Image($r('app.media.ic_notice'))
                .width(20)
                .height(20)
                .fillColor('#ff856bae')
              Text('温馨提示：购票观众凭有效身份证件(包括身份证、港澳通行证、台胞证、回乡证、护照)')
                .fontSize(14)
                .fontColor('#ff856bae')
                .margin({ left: 8 })
            }
            .justifyContent(FlexAlign.Center)
            .margin({left:10, right:10, top:5})
            .borderRadius(12)
            .width('100%')
            .padding(16)
            .backgroundColor('#F5F6F7')

            // 景点标题
            Column() {
              Text(this.spot.name)
                .fontSize(30)
                .fontWeight(FontWeight.Bold)

              Text(`"${this.spot.summary}"`)
                .fontSize(Constants.FONT_CAPTION)
                .fontColor('#666666')
                .margin({ top: 8 })

              Row() {
                Rating({ rating: this.spot.rating })
                Text(this.spot.rating!.toString())
                  .fontSize(Constants.FONT_CONTENT)
                  .fontWeight(FontWeight.Medium)
                  .margin({ left: 8 })

                Blank()
                Button('导航')
                  .fontColor(Color.White)
                  .fontSize(20)
                  .backgroundColor('#ffe7a76c')
                  .width(72)
                  .height(40)
                  .onClick( () => {
                    this.StartNavi()
                  })

              }
              .width('100%')
              .margin({ top: 12 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(16)

            //景点信息
            Column() {
              Row() {
                Text( isBusinessTime(this.spot.openingHours) === true ? '营业中' :'未营业')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                Text(this.spot.openingHours)
                  .fontSize(Constants.FONT_CAPTION)
                  .margin({ left: 8 })
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Color.White)

              Row() {
                Text('景区地址')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                Text(this.spot.address)
                  .fontSize(Constants.FONT_CAPTION)
                  .margin({ left: 8 })
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Color.White)
            }
            .margin({ top: 8 })

            // 订票
            Column() {
              Row() {
                ForEach(this.orderData, (text:string, index:number) => {
                  Text(text)
                    .fontSize(Constants.FONT_CONTENT)
                    .padding(8)
                    .backgroundColor(this.isSelected === index ? '#F0F0F0' : Color.White)
                    .borderRadius(4)
                    .onClick( () => {
                      this.isSelected = index
                      if( this.isSelected === 2){
                          console.info("CalendarDialog.show")
                          CalendarPickerDialog.show({
                            selected: this.selectedDate,
                            onAccept: (value) => {
                              this.selectedDate = value
                              console.info("calendar onAccept:" + JSON.stringify(value))
                            },
                            onCancel: () => {
                              console.info("calendar onCancel")
                            },
                            onChange: (value) => {
                              console.info("calendar onChange:" + JSON.stringify(value))
                            },
                            onDidAppear: () => {
                              console.info("calendar onDidAppear")
                            },
                            onDidDisappear: () => {
                              console.info("calendar onDidDisappear")
                            },
                            onWillAppear: () => {
                              console.info("calendar onWillAppear")
                            },
                            onWillDisappear: () => {
                              console.info("calendar onWillDisappear")
                            }
                          })
                      }
                    })
                })
              }
              .padding(16)

              Row() {
                Column() {
                  Text('成人票')
                    .fontSize(Constants.FONT_CONTENT)
                    .fontWeight(FontWeight.Medium)
                  Row() {
                    Text('可订明日')
                      .fontSize(14)
                      .fontColor('#666666')
                    Text(`${getRandomPercentage()}%用户购买`)
                      .fontSize(14)
                      .fontColor('#666666')
                  }
                }
                .margin({ left: 16 })
                .alignItems(HorizontalAlign.Start)

                Row() {
                  Text(`¥${this.spot.ticketPrice}起`)
                    .fontSize(Constants.FONT_CONTENT)
                    .fontColor('#FF0000')
                    .margin({right:5})
                  Button('购买')
                    .fontColor(Color.White)
                    .fontSize(20)
                    .backgroundColor('#4CAF50')
                    .width(72)
                    .height(40)
                }
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .padding(16)

              // Student ticket
              Row() {
                Column() {
                  Text('学生票')
                    .fontSize(Constants.FONT_CONTENT)
                    .fontWeight(FontWeight.Medium)
                  Row() {
                    Text('可订明日')
                      .fontSize(14)
                      .fontColor('#666666')
                  }
                }
                .margin({ left: 16 })
                .alignItems(HorizontalAlign.Start)

                Row() {
                  Text('¥60起')
                    .fontSize(Constants.FONT_CONTENT)
                    .fontColor('#FF0000')
                    .margin({right:5})
                  Button('购买')
                    .fontColor(Color.White)
                    .fontSize(20)
                    .backgroundColor('#4CAF50')
                }
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .padding(16)
            }
            .margin({ top: 8 })
            .backgroundColor(Color.White)

            // 评论
            SpotComment({spot: this.spot})
          }
        }
        .scrollBar(BarState.Off)
        .visibility(this.currentWidthBreakpoint === BreakpointConstants.BREAKPOINT_LG ? Visibility.None : Visibility.Visible)
        .width('100%')
        .layoutWeight(1)
        .scrollable(ScrollDirection.Vertical)


        SideBarContainer(){
          // 评论
          SpotDetailComment({spot: this.spot})

          Scroll(){
            Column(){
              Stack({ alignContent: Alignment.BottomEnd }) {
                if( this.spot && this.spot.imageUrl){
                  Image(this.url == undefined ? $r(`${this.spot.imageUrl}`) : this.url)
                    .width('100%')
                    .height(240)
                    .objectFit(ImageFit.Fill)
                }
              }

              // 注意
              Row() {
                Image($r('app.media.ic_notice'))
                  .width(20)
                  .height(20)
                  .fillColor('#ff856bae')
                Text('温馨提示：购票观众凭有效身份证件(包括身份证、港澳通行证、台胞证、回乡证、护照)')
                  .fontSize(14)
                  .fontColor('#ff856bae')
                  .margin({ left: 8 })
              }
              .justifyContent(FlexAlign.Center)
              .margin({left:10, right:10, top:5})
              .borderRadius(12)
              .width('100%')
              .padding(16)
              .backgroundColor('#F5F6F7')

              // 景点标题
              Column() {
                Text(this.spot.name)
                  .fontSize(30)
                  .fontWeight(FontWeight.Bold)

                Text(`"${this.spot.summary}"`)
                  .fontSize(Constants.FONT_CAPTION)
                  .fontColor('#666666')
                  .margin({ top: 8 })

                Row() {
                  Rating({ rating: this.spot.rating })
                  Text(this.spot.rating!.toString())
                    .fontSize(Constants.FONT_CONTENT)
                    .fontWeight(FontWeight.Medium)
                    .margin({ left: 8 })

                  Blank()
                  Button('导航')
                    .fontColor(Color.White)
                    .fontSize(20)
                    .backgroundColor('#ffe7a76c')
                    .width(72)
                    .height(40)
                    .onClick( () => {
                      this.StartNavi()
                    })

                }
                .width('100%')
                .margin({ top: 12 })
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
              .padding(16)

              //景点信息
              Column() {
                Row() {
                  Text( isBusinessTime(this.spot.openingHours) === true ? '营业中' :'未营业')
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                  Text(this.spot.openingHours)
                    .fontSize(Constants.FONT_CAPTION)
                    .margin({ left: 8 })
                }
                .width('100%')
                .padding(16)
                .backgroundColor(Color.White)

                Row() {
                  Text('景区地址')
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                  Text(this.spot.address)
                    .fontSize(Constants.FONT_CAPTION)
                    .margin({ left: 8 })
                }
                .width('100%')
                .padding(16)
                .backgroundColor(Color.White)
              }
              .margin({ top: 8 })

              // 订票
              Column() {
                Row() {
                  ForEach(this.orderData, (text:string, index:number) => {
                    Text(text)
                      .fontSize(Constants.FONT_CONTENT)
                      .padding(8)
                      .backgroundColor(this.isSelected === index ? '#F0F0F0' : Color.White)
                      .borderRadius(4)
                      .onClick( () => {
                        this.isSelected = index
                        if( this.isSelected === 2){
                          console.info("CalendarDialog.show")
                          CalendarPickerDialog.show({
                            selected: this.selectedDate,
                            onAccept: (value) => {
                              this.selectedDate = value
                              console.info("calendar onAccept:" + JSON.stringify(value))
                            },
                            onCancel: () => {
                              console.info("calendar onCancel")
                            },
                            onChange: (value) => {
                              console.info("calendar onChange:" + JSON.stringify(value))
                            },
                            onDidAppear: () => {
                              console.info("calendar onDidAppear")
                            },
                            onDidDisappear: () => {
                              console.info("calendar onDidDisappear")
                            },
                            onWillAppear: () => {
                              console.info("calendar onWillAppear")
                            },
                            onWillDisappear: () => {
                              console.info("calendar onWillDisappear")
                            }
                          })
                        }
                      })
                  })
                }
                .padding(16)

                Row() {
                  Column() {
                    Text('成人票')
                      .fontSize(Constants.FONT_CONTENT)
                      .fontWeight(FontWeight.Medium)
                    Row() {
                      Text('可订明日')
                        .fontSize(14)
                        .fontColor('#666666')
                      Text(`${getRandomPercentage()}%用户购买`)
                        .fontSize(14)
                        .fontColor('#666666')
                    }
                  }
                  .margin({ left: 16 })
                  .alignItems(HorizontalAlign.Start)

                  Row() {
                    Text(`¥${this.spot.ticketPrice}起`)
                      .fontSize(Constants.FONT_CONTENT)
                      .fontColor('#FF0000')
                      .margin({right:5})
                    Button('购买')
                      .fontColor(Color.White)
                      .fontSize(20)
                      .backgroundColor('#4CAF50')
                      .width(72)
                      .height(40)
                  }
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)
                .padding(16)

                // Student ticket
                Row() {
                  Column() {
                    Text('学生票')
                      .fontSize(Constants.FONT_CONTENT)
                      .fontWeight(FontWeight.Medium)
                    Row() {
                      Text('可订明日')
                        .fontSize(14)
                        .fontColor('#666666')
                    }
                  }
                  .margin({ left: 16 })
                  .alignItems(HorizontalAlign.Start)

                  Row() {
                    Text('¥60起')
                      .fontSize(Constants.FONT_CONTENT)
                      .fontColor('#FF0000')
                      .margin({right:5})
                    Button('购买')
                      .fontColor(Color.White)
                      .fontSize(20)
                      .backgroundColor('#4CAF50')
                  }
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)
                .padding(16)
              }
              .margin({ top: 8 })
              .backgroundColor(Color.White)
            }
          }
          .margin({bottom:50})
          .scrollBar(BarState.Off)
          .layoutWeight(1)

        }
        .showControlButton(false)
        .sideBarWidth(480)
        .minSideBarWidth(320)
        .maxSideBarWidth(480)
        .autoHide(false)
        .divider(null)
        .sideBarPosition(SideBarPosition.End)
        .visibility(this.currentWidthBreakpoint === BreakpointConstants.BREAKPOINT_LG ? Visibility.Visible : Visibility.None)
      }
      .width(Constants.FULL_WIDTH)
      .margin({ top: Constants.HEADER_HEIGHT_PAGE })
    }
    .hideTitleBar(true)
  }
}

//获取0-100.0%之内的随机数，保存1为小数
function getRandomPercentage(): number {
  return Math.floor(Math.random() * 1000) / 10;
}


function isBusinessTime(businessHours: string): boolean {
  if(businessHours === '全天开放')
    return true
  try {
    //获取当前时间
    let currentTime = new Date();

    // 解析营业时间字符串
    const timeArray = businessHours.split('-');
    const startStr = timeArray[0];
    const endStr = timeArray[1];

    // 解析开始时间
    const startTimeArray = startStr.split(':');
    const startHour = Number(startTimeArray[0]);
    const startMinute = Number(startTimeArray[1]);

    // 解析结束时间
    const endTimeArray = endStr.split(':');
    const endHour = Number(endTimeArray[0]);
    const endMinute = Number(endTimeArray[1]);

    // 获取当前时间的小时和分钟
    const currentHour = currentTime.getHours();
    const currentMinute = currentTime.getMinutes();

    // 转换为分钟数来比较
    const currentMinutes = currentHour * 60 + currentMinute;
    const startMinutes = startHour * 60 + startMinute;
    const endMinutes = endHour * 60 + endMinute;

    // 判断当前时间是否在营业时间范围内
    return currentMinutes >= startMinutes && currentMinutes <= endMinutes;
  } catch (error) {
    console.error('Invalid business hours format:', error);
    return false;
  }
}

@Builder
export function AttractionDetailPageBuilder(value: object) {
  AttractionDetailPage({value: value})
}

const builderName = BuilderNameConstants.TRAVEL_ATTRACTIONDETAILPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(AttractionDetailPageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
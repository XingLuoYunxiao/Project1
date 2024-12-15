import auth, { AuthUser } from "@hw-agconnect/auth"
import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from "routermodule"
import { Spot } from "travel"
import { SpotNetFunc } from "travel/src/main/ets/service/SpotNetFunc"
import { LazyDataSource } from "utils"
import Constants from "../common/constants/Constants"
import { functionItem } from "../model/functionItem"
import { photoAccessHelper } from "@kit.MediaLibraryKit"
import { BusinessError } from "@kit.BasicServicesKit"
import { AGCError } from "@hw-agconnect/hmcore/src/main/ets/error/AGCError"
import { hilog } from "@kit.PerformanceAnalysisKit"
import {MineWaterflow} from "../view/MineWaterflow"

@Component
export struct InfoMessagePage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @StorageLink ('personPhoto') personPhoto: string = ''
  @StorageLink ('personName') personName: string = ''
  @Consume('loginPathStack') loginPathStack: NavPathStack
  @State spotNetWork: SpotNetFunc = SpotNetFunc.getInstance();
  @State spotDataSource: LazyDataSource<Spot> = this.spotNetWork.allSpotsDataSource

  dialogController: CustomDialogController= new CustomDialogController({
    builder: CustomDialogChange({
    }),
    alignment: DialogAlignment.Center,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    showInSubWindow: true,
    isModal: true,
    customStyle: false,
    cornerRadius: 10,
  })

  @Builder
  myListItem(image: ResourceStr, title:string) {
    Column({space:Constants.SMALL_SPACE}) {
        Image(image)
          .width($r('app.float.options_height'))
          .height($r('app.float.options_height'))
        Text(title)
          .fontSize($r('app.float.large_text_size'))
    }
    .justifyContent(FlexAlign.Center)
  }

  aboutToAppear() {

  }

  build() {
    Navigation(this.loginPathStack) {
      Column({ space:Constants.MIDDLE_SPACE }) {
        //登录
        Row({ space:Constants.MIDDLE_SPACE }) {
          Image(this.personName ==''? $r('app.media.defaultphoto') : this.personPhoto)
            .width($r('app.float.lg_topic_width'))
            .height($r('app.float.topic_height'))
            .borderRadius($r('app.float.large_border_radius'))
            .onClick(()=>{
              //未登录点击去登陆页面
              if(this.personName==''){
                buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.LOGIN_LOGINPAGE)
              }else{
                //登录了点击去修改页面
                // buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.LOGIN_CHANGEPHOTO)
                let PhotoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
                PhotoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
                PhotoSelectOptions.maxSelectNumber = 1;
                let photoPicker = new photoAccessHelper.PhotoViewPicker();
                photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult: photoAccessHelper.PhotoSelectResult) => {
                  console.info('PhotoViewPicker.select成功, PhotoSelectResult uri: ' + JSON.stringify(PhotoSelectResult.photoUris[0]));
                  auth.getCurrentUser().then((curuser)=>{
                    if(curuser&&typeof this.personPhoto==='string'){
                      curuser.updateProfile({displayName:this.personName,photoUrl:PhotoSelectResult.photoUris[0]}).then((val)=>{
                        this.personName=curuser.getDisplayName()
                        this.personPhoto=curuser.getPhotoUrl()
                      }).catch((e:Error)=>{
                        console.log('修改头像失败'+JSON.stringify(e))
                      })
                    }
                  }).catch((e:AGCError)=>{
                    console.log('接口还是有问题',e.code,e.message)
                  })
                }).catch((err: BusinessError) => {
                  console.error(`PhotoViewPicker.select失败,err: ${err.code}, ${err.message}`);
                });
              }
            })
              if (this.personName!='') {
                Text(this.personName)
                  .fontSize($r('app.float.large_text_size'))
                  .onClick(()=>{
                    // buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.LOGIN_CHANGEPHOTO)
                    this.dialogController.open()
                  })
              } else {
                Text('登  录')
                  .fontSize($r('app.float.large_text_size'))
                  .onClick(() => {
                    buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.LOGIN_LOGINPAGE)
                  })
              }
              Blank()
              Text('客服')
                .fontSize($r('app.float.large_text_size'))
                .onClick(() => {
                  buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.LOGIN_CUSSERVICEPAGE)
                })
              Text('设置')
                .fontSize($r('app.float.large_text_size'))
                .onClick(() => {
                  buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.LOGIN_SETTINGPAGE)
                })
            }
            .padding({
              top: 10,
              left: 10,
              right: 10
            })
            .width('100%')
            .height($r('app.float.row_height'))

        // 卡片
        Row({space:Constants.LLARGE_SPACE}) {
          ForEach(FUNCTION_PATHS,(item:functionItem,index)=>{
            ListItem() {
              if(index<4){
                this.myListItem(item.img, item.title)
              }
            }.onClick(() => {
              buildRouterModel(RouterNameConstants.ENTRY_HAP, item.turnname)
            })
          })
        }
        .justifyContent(FlexAlign.SpaceAround)
        .padding($r('app.float.lg_padding_margin'))
        .backgroundColor(Color.White)
        .borderRadius($r('app.float.regular_border_radius'))
        .height($r('app.float.row_height'))
        .width('95%')

        //其他功能
        Column(){
            ForEach(FUNCTION_PATHS,(item:functionItem,index)=>{
              ListItem(){
                if(index>3){
                  Row(){
                    Image(item.img).width(30).margin({right:6})
                    Text(item.title)
                    Blank()
                    Image(item.icon).width(40)
                  }.width('100%')
                }
              }.onClick(()=>{
                buildRouterModel(RouterNameConstants.ENTRY_HAP, item.turnname)
              })
            })
        }
        .padding({left:$r('app.float.xl_padding_margin'),right:$r('app.float.xl_padding_margin'),top:$r('app.float.md_padding_margin'),bottom:$r('app.float.md_padding_margin')})
        .width('100%')
        .backgroundColor(Color.White)

        //推荐流
        WaterFlow(){
          LazyForEach(this.spotDataSource,(item:Spot,index:number)=>{
            FlowItem() {
              MineWaterflow({listitem:item})
            }.onClick(()=>{
              buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_ATTRACTIONDETAILPAGE,new Object({item:item}))
            })
            // .onAppear(() => {
            //   // 即将触底时提前增加数据
            //   if (index + 20 == this.spotDataSource.totalCount()) {
            //     for (let i = 0; i < 100; i++) {
            //       this.spotDataSource.addData()
            //     }
            //   }
            // })
          })
        }
        .columnsTemplate("1fr 1fr")
        .columnsGap(5)
        .rowsGap(5)
        .width('100%')
        .padding($r('app.float.lg_padding_margin'))
        .backgroundColor(Color.White)
      }
      .backgroundColor($r('app.color.app_background_color'))
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
  }
}

@CustomDialog
struct CustomDialogChange {
  @StorageLink('personName') personName: string =''
  @StorageLink('personPhoto') personPhoto: string =''
  newName:string=''
  controller: CustomDialogController
  build() {
    Column() {
      Row(){
        Text('修改昵称')
          .fontSize(20)
          .height(50)
        Image($r('app.media.ic_close')).width(30)
          .onClick(()=>{
            this.controller.close()
          })
      }
      TextInput({text:this.personName})
        .onChange((val)=>{
          this.newName=val
        })
      Text('昵称限制1-30个字符')
      Button('保存').onClick(()=>{
        auth.getCurrentUser().then((curuser)=>{
          hilog.info(1,'获取用户成功',JSON.stringify(curuser))
          if(curuser){
            curuser.updateProfile({displayName:this.newName,photoUrl:this.personPhoto}).then((val)=>{
              this.personName=curuser.getDisplayName()
              this.personPhoto=curuser.getPhotoUrl()
              this.controller.close()
            }).catch((e:Error)=>{
              console.log('修改昵称失败'+JSON.stringify(e))
            })
          }
        })
      })
    }
  }
}

const FUNCTION_PATHS: functionItem[]=[
  new functionItem($r('app.media.collect'), "我的收藏",BuilderNameConstants.LOGIN_COLLECTIONPAGE),
  new functionItem($r('app.media.history'), "浏览记录",BuilderNameConstants.LOGIN_BROWSHISTORYPAGE),
  new functionItem($r('app.media.order'), "我的订单",BuilderNameConstants.LOGIN_MYORDER),
  new functionItem($r('app.media.knowledge'), "知识等级",BuilderNameConstants.LOGIN_KNOWLEDGEPAGE),
  new functionItem($r('app.media.message'),"古韵天地",'Message',$r('app.media.ic_arrow')),
  new functionItem($r('app.media.privacy'),"隐私",BuilderNameConstants.LOGIN_PRIVACYPAGE,$r('app.media.ic_arrow')),
  new functionItem($r('app.media.advice'),"意见",BuilderNameConstants.LOGIN_ADVICEPAGE,$r('app.media.ic_arrow')),
  // new functionItem($r('app.media.account'),"分享",'SharePage',$r('app.media.ic_arrow'))
];
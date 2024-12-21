import { webview } from "@kit.ArkWeb";
import { AlertDialog } from '@kit.ArkUI'
import { UserModel } from "../model/UserModel";
import { BuilderNameConstants, RouterModule } from "routermodule";
import Constants from "../common/constants/Constants";

@Component
export struct SettingPage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @StorageLink('personName') personName: string =''
  @StorageLink('personPhoto') personPhoto: string =''
  @State userModel: UserModel = UserModel.getInstance()
  settingarr:string[]=['个人信息','账号安全','隐私设置','通用设置','清理缓存','关于我们','切换账号','退出登录']

  controller: webview.WebviewController = new webview.WebviewController()
  dialogControllerConfirm: CustomDialogController = new CustomDialogController({
    builder: AlertDialog({
      primaryTitle: '确定退出吗?',
      secondaryTitle: '退出后将无法查看行程信息',
      primaryButton: {
        value: '取消',
        action: () => {
        },
      },
      secondaryButton: {
        value: '确认',
        role: ButtonRole.ERROR,
        action: () => {
          this.userModel.outlogin()
       .then(() => {
            //登出成功
         this.appPathStack.pop()
         this.personName='';
         this.personPhoto='';
       }).catch((error:Error) => {
            //登出失败
          });
        }
      },
    }),
  })

  build() {
      NavDestination(){
        Column() {
          Row(){
            Image($r('app.media.ic_back'))
              .width($r('app.float.md_topic_width'))
              .onClick(()=>{
              this.appPathStack.pop()
            })
          }
          .width('100%')
          .margin({bottom:15})
          .height(Constants.TOP_HEIGHT_PAGE)
          Column({space:10}){
            ForEach(this.settingarr,(item:string,idx:number)=>{
              if(idx==this.settingarr.length-1){
                Row(){
                  Text(item)
                  Blank()
                  Image($r('app.media.ic_arrow')).width(30)
                }
                .padding({left:15,right:15})
                .backgroundColor($r('app.color.dialog_background_blue'))
                .width('100%')
                .borderRadius(5)
                .height(60)
                .onClick(()=>{
                  //弹出确认退出框
                  this.dialogControllerConfirm.open()
                })
              }else{
                Row(){
                  Text(item)
                  Blank()
                  Image($r('app.media.ic_arrow')).width(30)
                }
                .padding({left:15,right:15})
                .borderRadius(5)
                .height(60)
                .backgroundColor($r('app.color.dialog_background_blue'))
                .width('100%')
              }
            })
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
        }
        .width('100%')
      }
      .hideTitleBar(true)
      .margin({top:30,left:20,right:20})
  }
}

@Builder
export function SettingPageBuilder() {
  SettingPage()
}

const builderName = BuilderNameConstants.LOGIN_SETTINGPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(SettingPageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}

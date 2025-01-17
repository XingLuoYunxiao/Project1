import { CustomContentDialog } from '@kit.ArkUI'
import { MineViewModel } from '../service/MineViewModel';
import { BuilderNameConstants, RouterModule } from 'routermodule';
import Constants from '../common/constants/Constants';

@Component
export struct LoginPage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @State countDown: number = 60;
  @State verificationCode: string = '获取短信验证码';
  @State isEnable: boolean = true;
  @StorageLink('personName') personName: string = ''
  @StorageLink('personPhoto') personPhoto: string = ''
  @StorageLink('personUid') personUid: string = ''
  @State isChecked: boolean = false;
  @State phoneNumber: string = '';
  @State mineViewModel:MineViewModel=MineViewModel.getInstance();

  @Builder
  buildContent(): void {
    Column() {
      Button('同意并登录').onClick(() => {
        this.isChecked = true;
        this.isSend();
        this.dialogController.close();
      })
      Text('不同意').onClick(() => {
        this.dialogController.close();
      })
    }
  }
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomContentDialog({
      primaryTitle: '用户协议及隐私保护',
      secondaryTitle: '我已阅读并同意《古韵游踪用户协议》和《隐私政策》',
      contentBuilder: () => {
        this.buildContent();
      },
    }),
  });

  build() {
    NavDestination() {
      Column() {
        Image($r('app.media.ic_back')).width($r('app.float.md_topic_width')).onClick(() => {
            this.appPathStack.pop()
          })
        Column(){
          Text('欢迎登录古韵游踪')
            .fontSize($r('app.float.title_line_height'))
          Column(){
            TextInput({ placeholder: '请输入手机号' })
              .type(InputType.PhoneNumber)
              .onChange((phoneString) => {
                this.phoneNumber = phoneString;
              })
              .width('100%');
            Text('未注册手机号验证后自动创建账号').opacity(0.7).width('100%').fontSize($r('app.float.small_text_size'))
          }.margin({top:Constants.TOP_HEIGHT_PAGE,bottom:Constants.TOP_HEIGHT_PAGE})
          Row() {
            Checkbox()
              .width(14)
              .select(this.isChecked)
              .selectedColor(0xed6f21)
              .onChange((isChecked: boolean) => {
                this.isChecked = isChecked;
              })
            Text('我已阅读并同意《古韵游踪用户协议》和《隐私政策》').opacity(0.7).fontSize($r('app.float.small_text_size'))
          }.width('100%')
            //验证码框

            Button(this.verificationCode)
              .enabled(this.isEnable)
              .onClick(() => {
                if (this.phoneNumber.length != 11) {
                  AlertDialog.show({
                    message: '请输入正确的手机号码!',
                    gridCount: 4,
                    offset: { dx: 0, dy: -20 },
                  })
                } else if (this.isChecked == false) {
                  this.dialogController.open();
                } else {
                  this.isSend();
                }
              })
              .width("100%")
              .margin({top:Constants.LLARGE_SPACE,bottom:Constants.LLARGE_SPACE})

          TextInput({placeholder:'在这里输入验证码'})
            .width('100%')
            .type(InputType.Number)
            .visibility(this.isEnable==true?Visibility.None:Visibility.Visible)
            .onChange(async (code) => {
              if (this.phoneNumber.length != 11) {
                AlertDialog.show({
                  message: '请先输入正确的手机号码!',
                  offset: { dx: 0, dy: -20 },
                })
              } else if (code.length == 6) {
                this.mineViewModel.loginDeal(code,this.phoneNumber).then((val)=>{
                  this.personUid=this.mineViewModel.personUid
                  this.personName=this.mineViewModel.personName
                  this.personPhoto=this.mineViewModel.personPhoto
                  this.appPathStack.pop()
                })
              }
            })
          Row() {
            Text('密码登录').opacity(0.7).fontSize($r('app.float.normal_text_size1'));
            Text('遇到问题').opacity(0.7).fontSize($r('app.float.normal_text_size1'));
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .margin({top:Constants.BAR_HEIGHT_PAGE})
        .padding({left:Constants.PADDING_PAGE,right:Constants.PADDING_PAGE})
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding({left:Constants.PADDING_PAGE,right:Constants.PADDING_PAGE,top:Constants.PADDING_PAGE})
    }
    .margin({top:Constants.HEADER_HEIGHT_PAGE})
    .hideTitleBar(true)
  }

  isSend() {
    this.verificationCode = `重新获取(${this.countDown--}秒)`
    this.isEnable = false;
    const id = setInterval(() => {
      if (this.countDown < 0) {
        clearInterval(id);
        this.countDown = 60;
        this.verificationCode = '重新获取验证码';
        this.isEnable = true;
      } else {
        this.verificationCode = `重新获取(${this.countDown--}秒)`;
      }
    }, 1000)
    this.mineViewModel.codeDeal(this.phoneNumber)
  }
}

@Builder
export function LoginPageBuilder() {
  LoginPage()
}

const builderName = BuilderNameConstants.LOGIN_LOGINPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(LoginPageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}


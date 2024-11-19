import { webview } from '@kit.ArkWeb'
import { CustomContentDialog } from '@kit.ArkUI'
import { MineViewModel } from '../service/MineViewModel';

@Builder
export function LoginPageBuilder() {
  LoginPage()
}

@Component
export struct LoginPage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @State countDown: number = 60;
  @State verificationCode: string = '获取短信验证码';
  @State isEnable: boolean = true;
  @StorageLink('personName') personName: string = ''
  @StorageLink('personPhoto') personPhoto: string = ''
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
  controller: webview.WebviewController = new webview.WebviewController()
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
        Image($r('app.media.ic_back')).width(30).onClick(() => {
            this.appPathStack.pop()
          })
        Text('欢迎登录古韵游踪')
          .fontSize(40)
        TextInput({ placeholder: '手机号' })
          .type(InputType.PhoneNumber)
          .onChange((phoneString) => {
            this.phoneNumber = phoneString;
          })
          .width('90%');
        Divider();
        Text('未注册手机号验证后自动创建账号')
        Row() {
          Checkbox()
            .select(this.isChecked)
            .selectedColor(0xed6f21)
            .onChange((isChecked: boolean) => {
              this.isChecked = isChecked;
            })
          Text('我已阅读并同意《古韵游踪用户协议》和《隐私政策》')
        }.width('100%')

        Row() {
          //验证码框
          TextInput()
            .width('50%')
            .type(InputType.Number)
            .onChange(async (code) => {
              if (this.phoneNumber.length != 11) {
                AlertDialog.show({
                  message: '请先输入正确的手机号码!',
                  offset: { dx: 0, dy: -20 },
                })
              } else if (code.length == 6) {
                this.mineViewModel.loginDeal(code,this.phoneNumber).then((val)=>{
                  this.personName=this.mineViewModel.personName
                  this.personPhoto=this.mineViewModel.personPhoto
                  this.appPathStack.pop()
                })

              }
            })
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
            }
            )
        }.width('100%')

        Row() {
          Text('密码登录');
          Blank();
          Text('遇到问题');
        }
      }
      .alignItems(HorizontalAlign.Start)
      .height('100%')
      .width('100%')
    }
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


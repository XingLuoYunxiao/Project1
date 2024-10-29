import { cloudFunction } from '@kit.CloudFoundationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import cloud from '@hw-agconnect/cloud'


interface IdGeneratorResponse {
  uuid: string
}

@Entry
@Component
struct CloudFunction {
  @State globalId: string = '';
  @State message:string = '';

  build() {
    Column() {
      Navigation()
        .title($r('app.string.cloud_function_title'))
        .height('50vp')
        .width('100%')
        .margin({ bottom: 10 })
        .titleMode(NavigationTitleMode.Mini)

      Column(){
        Button("调用test云函数").onClick( async()=>{
          const result =  await cloud.callFunction({
            name:'test', // 云函数名称
            version:"$latest", // 云函数版本，$latest表示为最新版
            params:{request:"你好"} // 传递参数
          })
          this.message =result.getValue().message
        })
        Text(this.message)
      }.width(200).height(100)



      Text($r('app.string.cloud_function_description'))
        .width('90%')
        .textAlign(TextAlign.Center)
        .margin({ top: 20, bottom: 20 })
        .fontSize($r('app.float.body_font_size'))
      Button({ type: ButtonType.Normal }) {
        Text($r('app.string.cloud_function_button_text'))
          .fontColor($r('app.color.white'))
          .margin({ top: 5, bottom: 5 })
      }
      .width('90%')
      .borderRadius('8vp')
      .height('30vp')
      .margin({ top: 10 })
      .onClick(() => {
        this.callIdGenerator();
      })

      Column() {
        //Text(this.globalId).fontSize($r('app.float.body_font_size'))
        Text(this.message).fontSize($r('app.float.body_font_size'))
      }
      .width('90%')
      .padding({ top: 20, bottom: 20 })
      .margin({ top: 20 })
      .backgroundColor($r('app.color.placeholder_background'))
    }.height('100%')
  }

  //云函数调用
   callIdGenerator() {
    cloudFunction.call({ name: 'test', version: "$latest" }).then(async (res: cloudFunction.FunctionResult) => {
      this.message = await res.result.toString()
      //this.globalId = (res.result as IdGeneratorResponse).uuid;
    }).catch((err: BusinessError) => {
      hilog.error(0x0000, 'CloudFunction', 'call id-generator exception, ErrCode: %{public}d ErrMessage: %{public}s',
        err.code, err.message);
    });
  }
}
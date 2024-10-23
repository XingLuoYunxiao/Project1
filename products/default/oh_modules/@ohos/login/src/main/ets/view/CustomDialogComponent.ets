import router from '@ohos.router'
/**
 * 自定义弹窗
 * 启动页的隐私协议内容需要用到自定义弹窗展示。
 */
@CustomDialog
export struct CustomDialogComponent {
  controller: CustomDialogController
  confirm?: () => void
  cancel?: () => void
  build() {
    Column( {space:10}){
      // 1.标题
      Text('欢迎使用古韵游踪APP')
        .fontSize(20)
        .fontWeight(700)
      // 2.文本
      Text('我们充分尊重用户的隐私权，并按照法律要求和业界成熟的安全标准，为您的个人信息提供相应的安全保护措施')
        .fontSize(16)
      Text('隐私协议保护声明')
        .width('100%')
        .fontColor('#ff3fcff1')

      Text('（以下简称“本声明”）以便您了解我们如何搜集、使用、披露、保护、存储及传输您的个人数据。请您仔细阅读本声明。如您有任何疑问，请告知我们。')
        .fontSize(16)
        .fontColor(Color.Gray)
      // 3.按钮
      // 不同意
      Row(){
        Button('不同意')
          .width(150)
          .fontColor('#ff5e6060')
          .backgroundColor(Color.White)
          .onClick( () => {
            if( this.cancel)
              this.cancel()
            this.controller.close()
          })

        // 同意
        Button('同意')
          .width(150)
          .fontColor('#ff3fcff1')
          .backgroundColor(Color.White)
          .onClick( () => {
            if( this.confirm)
              this.confirm()
            this.controller.close()
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(10)
  }

}
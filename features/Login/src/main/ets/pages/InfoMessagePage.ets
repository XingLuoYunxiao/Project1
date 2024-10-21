import { LoginPage } from './LoginPage'

@Component
export struct InfoMessagePage {
  @Provide('loginPathStack') loginPathStack: NavPathStack = new NavPathStack()
  @StorageProp('personName') personName: string = ''

  build() {
    Navigation(this.loginPathStack){
      Column({ space: 10 }) {
        //登录
        Row({ space: 10 }) {
          if (this.personName) {
            Image($r('app.media.doushi'))
              .width(70)
              .height(70)
              .borderRadius(35)
            Text(this.personName)
              .fontSize(18)
              .height(25)
            Blank()
            Text('客服')
            Text('设置')
          } else {
            Image($r('app.media.avatar_icon'))
              .width(70)
              .height(70)
              .borderRadius(35)
            Text('登  录')
              .fontSize(18)
              .height(25)
              .onClick(() => {
                this.loginPathStack.pushPathByName('LoginPage', 123)
              })
            Blank()
            Text('客服')
            Text('设置')
          }
        }
        .backgroundColor(Color.White)
        .padding({
          top: 10,
          left: 10,
          right: 10
        })
        .width('100%')
        .height(100)

        Row(){

        }

        // 我的账户
        Column(){
          List() {
            ListItem() {
              Row(){
                this.myListItem($r('app.media.account'), "我的账户")
              }

            }
            ListItem() {
              this.myListItem($r('app.media.attraction'), "当前景点")
            }
            ListItem() {
              this.myListItem($r('app.media.record'), "历史记录")
            }
            ListItem() {
              this.myListItem($r('app.media.setting'), "设置")
            }
          }
        }
        .backgroundColor(Color.White)
        .borderRadius(10)
        .height(300)
        .width('95%')
      }
      .backgroundColor('#ffe0dede')
      .width('100%')
      .height('100%')
    }
    .navDestination(this.loginStartRouter)
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
  }

  @Builder
  loginStartRouter(path: string){
    if( path === 'LoginPage'){
      LoginPage()
    }
  }

  @Builder myListItem(image: Resource, title:string){
    Column(){
      Row({space:10}){
        Image(image)
          .width(30)
          .height(30)
        Text(title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text(">")
          .fontSize(20)
          .fontColor('#ff919090')
      }
      .width('90%')
      .height(60)
      .backgroundColor(Color.White)

      Divider()
        .width('100%')
        .height(1)
        .color('#ffb0aeae')
    }

  }

}
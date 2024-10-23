import { CusServicePage } from './CusServicePage'
import { LoginPage } from './LoginPage'

@Component
export struct InfoMessagePage {
  @Provide('loginPathStack') loginPathStack: NavPathStack = new NavPathStack()
  @StorageProp('personName') personName: string = ''
  @Builder
  loginStartRouter(path: string){
    if( path === 'LoginPage'){
      LoginPage()
    }
    if(path==='CusServicePage'){
      CusServicePage()
    }
  }

  @Builder
  myListItem(image: Resource, title:string) {
    Column() {
        Image(image)
          .width(50)
          .height(50)
        Text(title)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
    }
  }
      build() {
        Navigation(this.loginPathStack) {
          Column({ space: 10 }) {
            //登录
            Row({ space: 10 }) {
              Image(this.personName === '' ? $r('app.media.avatar_icon') : $r('app.media.doushi'))
                .width(70)
                .height(70)
                .borderRadius(35)
              if (this.personName) {
                Text(this.personName)
                  .fontSize(18)
                  .height(25)
              } else {
                Text('登  录')
                  .fontSize(18)
                  .height(25)
                  .onClick(() => {
                    this.loginPathStack.pushPathByName('LoginPage', 123)
                  })
              }
              Blank()
              Text('客服')
                .onClick(() => {
                  this.loginPathStack.pushPathByName('CusServicePage', 123)
                })
              Text('设置')
            }
            .backgroundColor('app.color.')
            .padding({
              top: 10,
              left: 10,
              right: 10
            })
            .width('100%')
            .height(100)

            // 卡片
            Row() {
              List({space:24}) {
                ListItem() {
                    this.myListItem($r('app.media.account'), "收藏")
                }

                ListItem() {
                  this.myListItem($r('app.media.attraction'), "浏览记录")
                }

                ListItem() {
                  this.myListItem($r('app.media.record'), "我的订单")
                }

                ListItem() {
                  this.myListItem($r('app.media.setting'), "")
                }
              }
              .padding({left:14,right:14})
              .listDirection(Axis.Horizontal)
            }
            .backgroundColor($r('app.color.white'))
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
  // Divider()
  //   .width('100%')
  //   .height(1)
  //   .color('#ffb0aeae')
}
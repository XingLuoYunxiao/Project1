import { CollectHistoryMore, LISTITEM_ARRAY } from '../model/CollectHistoryModel'
import { AdvicePage } from './AdvicePage'
import { BrowsHistoryPage } from './BrowsHistoryPage'
import { CollectionPage } from './CollectionPage'
import { CusServicePage } from './CusServicePage'
import { LoginPage } from './LoginPage'
import { LoginWebPage } from './LoginWebPage'
import { MyOrderPage } from './MyOrderPage'
import { PrivacyPage } from './PrivacyPage'
import { SettingPage } from './SettingPage'

@Component
export struct InfoMessagePage {
  @Provide('loginPathStack') loginPathStack: NavPathStack = new NavPathStack()
  @StorageProp('personName') personName: string = ''
  @Builder
  loginStartRouter(path: string){
    if( path === 'LoginPage'){
      LoginWebPage()
    } else if(path === 'CusServicePage'){
      CusServicePage()
    }else if(path === 'SettingPage'){
      SettingPage()
    }
    else if(path === 'CollectionPage'){
      CollectionPage()
    }else if(path=== 'BrowsHistoryPage'){
      BrowsHistoryPage()
    }else if(path==='MyOrderPage'){
      MyOrderPage()
    }else if(path==='Message'){

    }else if(path==='Advice'){
      AdvicePage()
    }else if(path==='Share'){

    }else if(path==='Privacy'){
      PrivacyPage()
    }

  }
  //主要功能
  @Builder
  myListItem(image: Resource, title:string) {
    Column() {
        Image(image)
          .width(50)
          .height(50)
        Text(title)
          .fontSize(16)
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
                .fontSize(18)
                .height(25)
                .onClick(() => {
                  this.loginPathStack.pushPathByName('SettingPage', 123)
                })
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
                }.onClick(() => {
                  this.loginPathStack.pushPathByName('CollectionPage',111)
                })

                ListItem() {
                  this.myListItem($r('app.media.attraction'), "浏览记录")
                }.onClick(() => {
                  this.loginPathStack.pushPathByName('BrowsHistoryPage', 123)
                })

                ListItem() {
                  this.myListItem($r('app.media.record'), "我的订单")
                }.onClick(() => {
                  this.loginPathStack.pushPathByName('MyOrderPage', 123)
                })

                ListItem() {
                  this.myListItem($r('app.media.setting'), "知识等级")
                }.onClick(() => {
                  this.loginPathStack.pushPathByName('KnoledgePage', 123)
                })
              }
              .padding({left:14,right:14})
              .listDirection(Axis.Horizontal)
            }
            .backgroundColor($r('app.color.white'))
            .borderRadius(10)
            .height(120)
            .width('95%')

            //其他功能
            Column(){
              List(){
                ForEach(LISTITEM_ARRAY,(item:CollectHistoryMore,idx:number)=>{
                  ListItem(){
                    Row(){
                      Image(item.image).width(30)
                      Text(item.title)
                      Image(item.icon).width(30)
                    }
                  }.onClick(()=>{
                    this.loginPathStack.pushPathByName(item.description,123)
                  })
                })
              }
            }
            .width('100%')
            .height('100%')
            .backgroundColor(Color.White)
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
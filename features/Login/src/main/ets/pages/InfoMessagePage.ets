import auth from "@hw-agconnect/auth"
import { functionItem } from "../model/functionItem"
import { MineViewModel } from "../service/MineViewModel"

@Component
export struct InfoMessagePage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @StorageLink('personName') personName: string =''
  @StorageLink('personPhoto') personPhoto: string =''
  @Consume('loginPathStack') loginPathStack: NavPathStack
  //主要功能
  @Builder
  myListItem(image: ResourceStr, title:string) {
    Column() {
        Image(image)
          .width(50)
          .height(50)
        Text(title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
    }
  }

  aboutToAppear() {
    auth.getCurrentUser().then(user=>{
      if(user){
        AppStorage.setOrCreate('personName',user.getDisplayName())
        AppStorage.setOrCreate('personPhoto',user.getPhotoUrl())
      }
    });
  }

      build() {
        Navigation(this.loginPathStack) {
          Column({ space: 10 }) {
            //登录
            Row({ space: 10 }) {
              Image(this.personName ==''? $r('app.media.guanggao') : this.personPhoto)
                .width(70)
                .height(70)
                .borderRadius(35)
                .onClick(()=>{
                    //未登录点击去登陆页面
                    if(this.personName==''){
                      this.appPathStack.pushPathByName('LoginPage', null)
                    }else
                    //登录了点击去修改页面
                      this.appPathStack.pushPathByName('ChangePhoto', null)
                })
              if (this.personName!='') {
                Text(this.personName)
                  .fontSize(18)
                  .height(25)
                  .onClick(()=>{
                    this.appPathStack.pushPathByName('ChangePhoto', null)
                  })
              } else {
                Text('登  录')
                  .fontSize(18)
                  .height(25)
                  .onClick(() => {
                    this.appPathStack.pushPathByName('LoginPage', null)
                  })
              }
              Blank()
              Text('客服')
                .onClick(() => {
                  this.appPathStack.pushPathByName('CusServicePage', null)
                })
              Text('设置')
                .fontSize(18)
                .height(25)
                .onClick(() => {
                  this.appPathStack.pushPathByName('SettingPage', null)
                })
            }
            .backgroundColor(Color.White)
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
                ForEach(FUNCTION_PATHS,(item:functionItem,index)=>{
                  ListItem() {
                    if(index<4){
                      this.myListItem(item.img, item.title)
                    }
                  }.onClick(() => {
                    this.appPathStack.pushPathByName(item.turnname,null)
                  })
                })
              }
              .padding({left:14,right:14})
              .listDirection(Axis.Horizontal)
            }
            .backgroundColor(Color.White)
            .borderRadius(10)
            .height(120)
            .width('95%')

            //其他功能
            Column(){
              List(){
                ForEach(FUNCTION_PATHS,(item:functionItem,index)=>{
                  ListItem(){
                    if(index>3){
                      Row(){
                        Image(item.img).width(30)
                        Text(item.title)
                        Image(item.icon).width(30)
                      }
                    }
                  }.onClick(()=>{
                    this.appPathStack.pushPathByName(item.turnname,123)
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
        .hideTitleBar(true)
        .mode(NavigationMode.Stack)
      }
}
const FUNCTION_PATHS: functionItem[]=[
  new functionItem($r('app.media.account'), "收藏",'CollectionPage'),
  new functionItem($r('app.media.attraction'), "浏览记录",'BrowsHistoryPage'),
  new functionItem($r('app.media.record'), "我的订单",'MyOrderPage'),
  new functionItem($r('app.media.setting'), "知识等级",'KnowledgePage'),
  new functionItem($r('app.media.account'),"消息",'Message',$r('app.media.ic_arrow')),
  new functionItem($r('app.media.account'),"隱私",'PrivacyPage',$r('app.media.ic_arrow')),
  new functionItem($r('app.media.account'),"意見",'AdvicePage',$r('app.media.ic_arrow')),
  new functionItem($r('app.media.account'),"分享",'SharePage',$r('app.media.ic_arrow'))
];
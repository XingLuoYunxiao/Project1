import router from '@ohos.router'

@Component
export struct InfoMessagePage {
  @StorageProp('readCount') readCount: number = 0
  @StorageProp('bookCount') bookCount: number = 0
  @StorageProp('personName') personName: string = '星落'

  build() {
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
        } else {
          Image($r('app.media.avatar_icon'))
            .width(70)
            .height(70)
            .borderRadius(35)
          Text('登  录')
            .fontSize(18)
            .height(25)
            /*.onClick(() => {
              router.pushUrl({ url: "pages/LoginPage" })
            })*/
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

      Row() {
        Row() {
          Image($r('app.media.collection'))
            .width(30)
            .height(30)
            .margin({left:5})
          Text('收藏')
            .fontSize(16)
            .margin({left:10,right:20})
          Text('0个')
            .fontSize(16)
            .fontColor('#ff838282')
          Blank()
          Text('···')
            .margin({right:10})
            .fontSize(16)
            .fontColor('#ff838282')
        }
        .margin({right:5})
        .width('47.5%')
        .height(60)
        .backgroundColor(Color.White)
        .borderRadius(10)
        .padding({top:10,bottom:10,left:5})

        Row() {
          Image($r('app.media.achievement'))
            .width(30)
            .height(30)
            .margin({left:5})
          Text('成就')
            .fontSize(16)
            .margin({left:10,right:20})
          Text('0个')
            .fontSize(16)
            .fontColor('#ff838282')
          Blank()
          Text('···')
            .margin({right:10})
            .fontSize(16)
            .fontColor('#ff838282')
        }
        .width('47.5%')
        .height(60)
        .backgroundColor(Color.White)
        .borderRadius(10)
        .padding({top:10,bottom:10, right:5})
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .padding({ top: 12, bottom: 12 })

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
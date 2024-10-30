@Component
export struct MyOrderPage {
  @Consume ('loginPathStack') loginPathStack: NavPathStack

  build() {
    NavDestination(){
      Column() {
        Row(){
          Image($r('app.media.ic_back')).width(30).onClick(()=>{
            this.loginPathStack.pop()
          })
          Text('订单')
          Image($r('app.media.search')).width(30)
        }
        Tabs(){
          TabContent(){

          }
            .tabBar('全部订单')
          TabContent(){

          }
            .tabBar('待使用')
          TabContent(){
            if(''){
              Column(){
                Image($r('app.media.miaosha'))
                Text('您还没有相关订单')
                Text('没有找到订单?试试查看全部')
                Button('查看全部')
              }
            }
          }
            .tabBar('待评价')
          TabContent(){

          }
            .tabBar('退款售后')
        }
      }
      .width('100%')
    }.hideTitleBar(true)
  }
}

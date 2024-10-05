
@Component
export struct SearchHeader {
  build() {
    Row({space:5}){
      Image($r('app.media.logo'))
        .width(30)
        .height(30)
      Search({placeholder:"搜索想要去的景点"})
        .height(30)
        .layoutWeight(1)
      Badge({count: 1, position: BadgePosition.RightTop, style:{fontSize:14, badgeColor: Color.Red}}){
        Image($r('app.media.ic_public_email'))
          .width(24)
      }
    }
    .margin({top:5})
    .width('100%')
    .height(30)
  }
}
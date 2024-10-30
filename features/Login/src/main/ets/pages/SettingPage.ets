@Component
export struct SettingPage {
@Consume ('loginPathStack') loginPathStack: NavPathStack;
settingarr:string[]=['个人信息','账号安全','隐私设置','通用设置','清理缓存','关于我们','切换账号','退出登录']

  build() {
      NavDestination(){
        Column() {
          ForEach(this.settingarr,(item:string)=>{
            Row(){
              Text(item)
              Blank()
              Image($r('app.media.ic_arrow')).width(30)
            }
          })
        }
        .width('100%')
      }
  }
}

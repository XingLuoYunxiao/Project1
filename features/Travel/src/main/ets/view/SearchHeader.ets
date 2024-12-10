import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from "routermodule"

@Component
export struct SearchHeader {
  @Consume('appPathStack') appPathStack: NavPathStack;

  build() {
    Row({ space: 5 }) {
      Image($r('app.media.logo'))
        .width(40)
        .height(40)
        .borderRadius(20)
        .margin({ right: 10 });
      Search({ placeholder: '搜索目的地或景点' })
        .height(40)
        .layoutWeight(1)
        .onClick(() => {
          buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_SEARCHPAGE);
        })
        .enableKeyboardOnFocus(false)
        .borderRadius(20);
      Badge({ count: 0, position: BadgePosition.RightTop, style: { fontSize: 14, badgeColor: '#ff7f50' } }) {
        Image($r('app.media.ic_public_email')).width(24).height(24);
      }
    }
    .padding({ top: 10, bottom: 10 })
    .width('100%')
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({
      color: '#cccccc',
      radius: 5,
      offsetX: 0,
      offsetY: 2,
    });
  }
}
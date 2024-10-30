import { CollectHistoryView } from "../view/CollectHistoryView"

@Component
export struct CollectionPage {

  build() {
    NavDestination(){
      CollectHistoryView({title:'收藏',tabbarfirst:'遗迹景点',tabbarsecond:'诗词歌赋'})
    }
    .hideTitleBar(true)
  }

}


import { CollectHistoryView } from '../view/CollectHistoryView';

@Component
export struct BrowsHistoryPage {

  build() {
    NavDestination() {
      Column() {
        CollectHistoryView({title:'浏览记录',tabbarfirst:'遗迹景点',tabbarsecond:'诗词歌赋'})
      }
    }.hideTitleBar(true)
  }
}

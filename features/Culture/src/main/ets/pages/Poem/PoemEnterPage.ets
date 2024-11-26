import { PoemsPage } from "../../view/test"
import { PoemPage } from "./PoemPage"
import { SentencePage } from "./SentencePage"



@Component
export struct PoemEnterPage {
  build() {
    NavDestination() {

      Tabs() {
        TabContent() {
          PoemPage()
        }
        .tabBar('诗文')

        TabContent() {
          SentencePage()
        }
        .tabBar('名句')

        TabContent() {

        }.tabBar('其他')

      }

    }
    .hideTitleBar(true)
  }
}

@Builder
export function PoemEnterPageBuilder() {
  PoemEnterPage()
}
// const buildName = BuilderNameConstants.CULTURE_POEMDEAILPAGE
// if (!RouterModule.getBuilder(buildName)) {
//   const builder: WrappedBuilder<[object]> = wrapBuilder(PoemDetailPageBuilder)
// }
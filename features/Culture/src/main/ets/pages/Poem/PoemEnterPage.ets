import { PoemsPage } from "../../view/test"
import { PoemPage } from "./PoemPage"
import { SentencePage } from "./SentencePage"

@Builder
export function PoemEnterPageBuilder() {
  PoemEnterPage()
}

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
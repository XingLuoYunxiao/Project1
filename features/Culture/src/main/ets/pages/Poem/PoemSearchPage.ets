import { it } from "@ohos/hypium"
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule"
import { Poem } from "../../model/Poem"
import { CloudPoemService } from "../../service/CloudPoemService"

@Component
export struct PoemSearchPage {
  @State changeValue: string = ''
  @State searchLabel: string = "按标题"
  @State index: number = 1
  @State arrowPosition: ArrowPosition = ArrowPosition.END
  @State FuzzySearchResult: Poem[] | undefined = []

  build() {
    NavDestination() {
      Column() {
        Row() {
          Select([{ value: '按标题' },
            { value: '按诗人' },
            { value: '按内容' },
          ])
            .selected(this.index)
            .value(this.searchLabel)
            .font({ size: 16, weight: 500 })
            .fontColor('#182431')
            .selectedOptionFont({ size: 16, weight: 400 })
            .optionFont({ size: 16, weight: 400 })
            .arrowPosition(this.arrowPosition)
            .menuAlign(MenuAlignType.START, { dx: 0, dy: 0 })
            .optionWidth(200)
            .optionHeight(300)
            .onSelect((index: number, text?: string | undefined) => {
              console.info('Select:' + index)
              this.index = index;
              if (text) {
                this.searchLabel = text;
              }
            })
          Search({ value: this.changeValue, placeholder: '搜你想搜的诗词吧' })
            .searchButton('搜索')
            .width('88%')
            .height(40)
            .backgroundColor('#F5F5F5')
            .placeholderColor(Color.Grey)
            .placeholderFont({ size: 14, weight: 400 })
            .textFont({ size: 14, weight: 400 })
            .onSubmit(async (value: string) => {


              this.FuzzySearchResult = await CloudPoemService.fetchPoemsByFuzzySearch(value, this.searchLabel)

            })
            .onChange(async (value: string) => {
              this.changeValue = value
              this.FuzzySearchResult = await CloudPoemService.fetchPoemsByFuzzySearch(value, this.searchLabel)
            })
            .margin(20)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)

        //提示
        Column() {
          if (this.FuzzySearchResult) {
            ForEach(this.FuzzySearchResult, (item: Poem) => {
              Column() {
                Row() {
                  Text("《" + item.title + '》')
                    .fontSize($r('app.float.large_text_size'))
                    .margin({ right: 12 })
                  Text(item.writer)
                    .fontSize($r('app.float.large_text_size'))
                    .margin({ left: 20, right: 20 })
                  Text(item.content)
                    .fontSize($r('app.float.large_text_size'))
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                }
                .onClick(() => { // 点击事件
                  buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.CULTURE_POEMDETAIL,
                    new Object(item))
                })
                .width('100%')
                .justifyContent(FlexAlign.Start)
                .margin(8)

                Divider()

              }

            }, (item: Poem) => item.id.toString()
            )
          }
        }
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Start)
        .width('80%')
      }
    }
  }
}


@Builder
export function PoemSearchPageBuilder() {
  PoemSearchPage()
}

const builderName = BuilderNameConstants.CULTURE_SearchPage
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(PoemSearchPageBuilder)
  RouterModule.registerBuilder(builderName, builder)
}
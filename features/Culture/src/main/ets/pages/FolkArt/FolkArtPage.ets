import { BuilderNameConstants, RouterModule } from "routermodule"
import { FolkArt, FolkArtList } from "../../model/folkArt/FolkArtModel"


@Component
export struct FolkArtPage {
  build() {
    NavDestination() {
      Column() {
        List() {
          ForEach(FolkArtList, (item: FolkArt) => {
            ListItem() {
              this.ArtBuilder(item)
            }
          }, (item: FolkArt) => item.title)
        }
      }
    }
  }

  @Builder
  ArtBuilder(item: FolkArt) {
    Column() {
      Row() {
        Text(item.title)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')

      Divider()
        .width('80%')

      Text(item.description)
        .fontSize(18)

      Text(item.types)
        .fontSize(18)

    }
  }
}


@Builder
export function FolkArtPageBuilder(value: object) {
  FolkArtPage()
}

const builderName = BuilderNameConstants.CULTURE_FOLKART
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(FolkArtPageBuilder)
  RouterModule.registerBuilder(builderName, builder)
}
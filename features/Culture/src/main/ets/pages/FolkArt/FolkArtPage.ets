import { BuilderNameConstants, RouterModule } from "routermodule"
import { FolkArt, FolkArtList } from "../../model/folkArt/FolkArtModel"

@Component
export struct FolkArtPage {
  build() {
    NavDestination() {
      Column() {
        ForEach(FolkArtList, (item: FolkArt) => {

        })
      }

    }
  }

  @Builder
  ArtBuilder(item: FolkArt) {
    Column() {
      Text(item.title)
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
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
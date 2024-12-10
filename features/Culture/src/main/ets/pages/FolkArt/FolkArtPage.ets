import { BuilderNameConstants, RouterModule } from "routermodule"
import { downloadImageList, getPath } from "../../common/util/getImage"
import {
  bambooImageList,
  ceramicImageList,
  ChineseShadowPuppetryImageList,
  clayFigurineImageList,
  DragonDanceAndLionDance,
  embroideryImageList,
  paperCuttingImageList
} from "../../model/folkArt/FolkArtImageData"
import { FolkArt, FolkArtList } from "../../model/folkArt/FolkArtModel"

@Component
export struct FolkArtPage {
  aboutToAppear(): void {
    downloadImageList(paperCuttingImageList)
    downloadImageList(embroideryImageList)
    downloadImageList(ceramicImageList)
    downloadImageList(bambooImageList)
    downloadImageList(clayFigurineImageList)
    downloadImageList(ChineseShadowPuppetryImageList)
    downloadImageList(DragonDanceAndLionDance)
  }

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
        .width('90%')
        .strokeWidth(2)

      Text(item.description)
        .fontSize(18)


      Swiper() {
        ForEach(item.ImageList, (img: string) => {
          Column() {
            Image(getPath(img))
              .width(400)
              .objectFit(ImageFit.Contain)
          }
          .height(400)
          .width(400)

        })
      }
      .autoPlay(true)
      .loop(true)
      .interval(4000)
      .vertical(false)
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
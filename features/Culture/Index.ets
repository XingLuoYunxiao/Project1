import { BuilderNameConstants } from 'routermodule';
import { LogUtil } from 'utils/src/main/ets/puraUtils/LogUtil';

export { CulturalHeritageStartPage } from '../Culture/src/main/ets/pages/CulturalHeritageStartPage'

export { CulturalPage } from '../Culture/src/main/ets/pages/CulturalPage'

export function harInit(builderName: string): void {
  // 动态引入要跳转的页面
  switch (builderName) {
    case BuilderNameConstants.CULTURE_SENTENCE:
      LogUtil.debug('准备动态import  culture 模块下的 ./src/main/ets/pages/Poem/SentencePage')
      import("./src/main/ets/pages/Poem/SentencePage");
      break;
    case BuilderNameConstants.CULTURE_POEM:
      LogUtil.debug('准备动态import  culture 模块下的 ./src/main/ets/pages/Poem/PoemPage')
      import("./src/main/ets/pages/Poem/PoemPage");
      break;

    case BuilderNameConstants.CULTURE_POEMDETAIL:
      LogUtil.debug('准备动态import  culture 模块下的 ./src/main/ets/pages/Poem/PoemDetailPage')
      import("./src/main/ets/pages/Poem/PoemDetailPage");
      break;

    case BuilderNameConstants.CULTURE_IDIOM:
      LogUtil.debug('准备动态import  culture 模块下的 ./src/main/ets/pages/IdiomPage')
      import("./src/main/ets/pages/Idiom/IdiomPage");
      break;

    case BuilderNameConstants.CULTURE_XIEHOUYU:
      LogUtil.debug('准备动态import  culture 模块下的 ./src/main/ets/pages/xiehouyu/XiehouyuPage')
      import("./src/main/ets/pages/xiehouyu/XiehouyuPage");
      break;
    case BuilderNameConstants.CULTURE_ART:
      LogUtil.debug('准备动态import  culture 模块下的"./src/main/ets/pages/art/ArtPage')
      import("./src/main/ets/pages/art/ArtPage");
      break;
    case BuilderNameConstants.CULTURE_CALLIGRAPHY:
      LogUtil.debug('准备动态import  culture 模块下的 ./src/main/ets/pages/art/CalligraphyDetails')
      import("./src/main/ets/pages/art/CalligraphyDetails");
      break;
    case BuilderNameConstants.CULTURE_PAINTING:
      LogUtil.debug('准备动态import  culture 模块下的 ./src/main/ets/pages/art/PaintingDetails')
      import("./src/main/ets/pages/art/PaintingDetails");
      break;
    case BuilderNameConstants.CULTURE_IdiomSolitaire:
      LogUtil.debug('准备动态import  culture 模块下的 ./src/main/ets/pages/art/PaintingDetails')
      import("./src/main/ets/pages/game/IdiomSolitairePage");
      break;
    case BuilderNameConstants.CULTURE_FlyingFlowerOder:
      import("./src/main/ets/pages/game/FlyingFlowerOrderPage");
      break;
    case BuilderNameConstants.CULTURE_TEST:
      import("./src/main/ets/pages/test");
      break;
    case BuilderNameConstants.CULTURE_Building:
      import("./src/main/ets/pages/BuildingPage");
      break;
    case BuilderNameConstants.CULTURE_AIPainting:
      import("./src/main/ets/pages/game/AIPaintingPage");
      break;
    case BuilderNameConstants.CULTURE_FestivalPage2:
      import("./src/main/ets/pages/tradictionalFestival/Festival");
      break;
    case BuilderNameConstants.CULTURE_GapFillingPage:
      import("./src/main/ets/pages/game/GapFilling");
      break;
    case BuilderNameConstants.CULTURE_FOLKART:
      LogUtil.debug('准备动态import  culture 模块下的 ./src/main/ets/pages/FolkArt/FolkArtPage')
      import("./src/main/ets/pages/FolkArt/FolkArtPage");
      break;
    default:
      break;
  }
}

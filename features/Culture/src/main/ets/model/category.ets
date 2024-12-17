import { BuilderNameConstants } from "routermodule"


export interface category {
  name: string
  path: string
  ic?: ResourceStr
}


export const literatureList: category[] = [
  {
    name: "诗文",
    path: BuilderNameConstants.CULTURE_POEM,
    ic: $r('app.media.ic_poemPage')
  },
  {
    name: "名句",
    path: BuilderNameConstants.CULTURE_SENTENCE,
    ic: $r('app.media.ic_sentencePage')
  },
  {
    name: '成语',
    path: BuilderNameConstants.CULTURE_IDIOM,
    ic: $r('app.media.ic_Idiom')
  },
  {
    name: "歇后语",
    path: BuilderNameConstants.CULTURE_XIEHOUYULIST,
    ic: $r('app.media.ic_xiehouyuPage')
  }
]

export const traditionList: category[] = [
  {
    name: "美术",
    path: BuilderNameConstants.CULTURE_ART,
    ic: $r('app.media.ic_artPage')
  },
  {
    name: "节日",
    path: BuilderNameConstants.CULTURE_FestivalPage2,
    ic: $r("app.media.ic_festivalPage")
  },
  {
    name: "建筑",
    path: BuilderNameConstants.CULTURE_Building,
    ic: $r('app.media.ic_buildingPage')
  },
  {
    name: "民间艺术",
    path: BuilderNameConstants.CULTURE_FOLKART,
    ic: $r('app.media.ic_folkArtPage')
  }

]

export const gameList: category[] = [
  {
    name: "飞花令",
    path: BuilderNameConstants.CULTURE_FlyingFlowerOder,
    ic: $r('app.media.ic_FlyFlowerPage')
  },
  {
    name: '诗句填空',
    path: BuilderNameConstants.CULTURE_GapFillingPage,
    ic: $r('app.media.ic_GapFillingPage')
  },

  {
    name: "成语接龙",
    path: BuilderNameConstants.CULTURE_IdiomSolitaire,
    ic: $r("app.media.ic_chengyujielongPaage")
  },
// {
//   name: '古风绘意',
//   path: BuilderNameConstants.CULTURE_AIPainting
// }
]



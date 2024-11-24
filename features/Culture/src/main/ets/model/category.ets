import { BuilderNameConstants, RouterModule } from "routermodule"


export interface category {
  name: string
  path: string
}


export const literatureList: category[] = [
  {
    name: "诗文",
    path: BuilderNameConstants.CULTURE_POEM
  },
  {
    name: "名句",
    path: BuilderNameConstants.CULTURE_SENTENCE
  },
  {
    name: '成语',
    path: BuilderNameConstants.CULTURE_IDIOM
  },
  {
    name: "歇后语",
    path: BuilderNameConstants.CULTURE_XIEHOUYU
  }
]

export const traditionList: category[] = [
  {
    name: "美术",
    path: BuilderNameConstants.CULTURE_ART
  },
  {
    name: "节日",
    path: BuilderNameConstants.CULTURE_FESTIVAL
  },
  {
    name: "建筑",
    path: ""
  },
  {
    name: "民间艺术",
    path: ""
  }

]

export const gameList: category[] = [
  {
    name: "飞花令",
    path: BuilderNameConstants.CULTURE_FlyingFlowerOder
  },
  {
    name: "成语接龙",
    path: BuilderNameConstants.CULTURE_IdiomSolitaire
  }
]



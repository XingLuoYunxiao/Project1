import { Icon } from "./IconInterface"

export class MasterpieceI implements Icon {
  img: Resource
  id: string
  path:string

  constructor(img: Resource, id: string,path:string) {
    this.img = img
    this.id = id
    this.path = path
  }
}

export function tsetMasterPieceIArr(): MasterpieceI[] {
  let masterPiceIArr: MasterpieceI[] = [
    new MasterpieceI($r('app.media.poetry_icon'), '诗歌典籍','poetryAndClassicPage'),
    new MasterpieceI($r('app.media.class_1'), '古典小说',''),
    new MasterpieceI($r('app.media.class_2'), '中华美术','ArtPage'),
    new MasterpieceI($r('app.media.class_3'), '传统音乐',''),
    new MasterpieceI($r('app.media.class_4'), '传统节日',''),
    new MasterpieceI($r('app.media.class_5'), '开发中',''),]
  return masterPiceIArr
}
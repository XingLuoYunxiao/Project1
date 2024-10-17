import { Icon } from "./interface/IconInterface"

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
    new MasterpieceI($r('app.media.poetry_icon'), '诗歌典籍',''),
    new MasterpieceI($r('app.media.class_1'), '开发中',''),
    new MasterpieceI($r('app.media.class_2'), '开发中',''),
    new MasterpieceI($r('app.media.class_3'), '开发中',''),
    new MasterpieceI($r('app.media.class_4'), '开发中',''),
    new MasterpieceI($r('app.media.class_5'), '开发中',''),]
  return masterPiceIArr
}
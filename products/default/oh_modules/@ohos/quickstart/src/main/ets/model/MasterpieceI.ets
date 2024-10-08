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
    new MasterpieceI($r('app.media.class_1'), '诗歌典籍',''),
    new MasterpieceI($r('app.media.class_1'), '页面2',''),
    new MasterpieceI($r('app.media.class_1'), '页面3',''),
    new MasterpieceI($r('app.media.class_1'), '页面4',''),
    new MasterpieceI($r('app.media.class_1'), '页面5',''),
    new MasterpieceI($r('app.media.class_1'), '页面6',''),]
  return masterPiceIArr
}
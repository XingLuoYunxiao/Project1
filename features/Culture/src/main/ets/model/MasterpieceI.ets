import { Icon } from "./IconInterface"

export class MasterpieceI implements Icon {
  img: Resource
  id: string
  path: string

  constructor(img: Resource, id: string, path: string) {
    this.img = img
    this.id = id
    this.path = path
  }
}

export function tsetMasterPieceIArr(): MasterpieceI[] {
  let masterPiceIArr: MasterpieceI[] = [
    new MasterpieceI($r('app.media.poetry_icon'), '诗词歌赋', 'PoemEnterPage'),
    new MasterpieceI($r('app.media.class_1'), '传统建筑', ''),
    new MasterpieceI($r('app.media.class_2'), '中华美术', 'ArtPage'),
    new MasterpieceI($r('app.media.class_3'), '民间艺术', ''),
    new MasterpieceI($r('app.media.class_4'), '传统节日', 'FestivalPage'),
    new MasterpieceI($r('app.media.class_5'), '工巧技艺', 'SkillPage'),]
  return masterPiceIArr
}
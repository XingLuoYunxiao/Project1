import { Icon } from "./IconInterface"

export class AncientGames implements Icon {
  img: Resource;
  id: string;
  path: string;

  constructor(img: Resource, id: string, path: string) {
    this.img = img;
    this.id = id;
    this.path = path;
  }
}

export function tsetAncientGamesIArr(): AncientGames[] {
  let masterPiceIArr: AncientGames[] = [
    new AncientGames($r('app.media.feihualing'), '飞花令', 'FlyingFlowerOrderPage'),
    new AncientGames($r('app.media.class_2'), 'AI绘画', 'AIPaintingPage'),
    new AncientGames($r('app.media.class_2'), 'Poem', 'PoemPage'),
    new AncientGames($r('app.media.class_2'), '开发中', ''),
    new AncientGames($r('app.media.class_2'), '开发中', ''),
    new AncientGames($r('app.media.class_2'), '开发中', ''),]
  return masterPiceIArr
}

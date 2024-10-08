import type { Icon } from "./interface/IconInterface";
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
        new AncientGames({ "id": 67109020, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, '飞花令', 'FlyingFlowerOrderPage'),
        new AncientGames({ "id": 67108890, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, '开发中', ''),
        new AncientGames({ "id": 67108890, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, '开发中', ''),
        new AncientGames({ "id": 67108890, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, '开发中', ''),
        new AncientGames({ "id": 67108890, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, '开发中', ''),
        new AncientGames({ "id": 67108890, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, '开发中', ''),
    ];
    return masterPiceIArr;
}

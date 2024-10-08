import type { Icon } from "./interface/IconInterface";
export class MasterpieceI implements Icon {
    img: Resource;
    id: string;
    path: string;
    constructor(img: Resource, id: string, path: string) {
        this.img = img;
        this.id = id;
        this.path = path;
    }
}
export function tsetMasterPieceIArr(): MasterpieceI[] {
    let masterPiceIArr: MasterpieceI[] = [
        new MasterpieceI({ "id": 67109021, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, '诗歌典籍', ''),
        new MasterpieceI({ "id": 67108889, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, '开发中', ''),
        new MasterpieceI({ "id": 67108890, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, '开发中', ''),
        new MasterpieceI({ "id": 67108891, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, '开发中', ''),
        new MasterpieceI({ "id": 67108892, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, '开发中', ''),
        new MasterpieceI({ "id": 67108893, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, '开发中', ''),
    ];
    return masterPiceIArr;
}

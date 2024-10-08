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
        new MasterpieceI({ "id": 33554534, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, '诗歌典籍', ''),
        new MasterpieceI({ "id": 33554534, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, '页面2', ''),
        new MasterpieceI({ "id": 33554534, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, '页面3', ''),
        new MasterpieceI({ "id": 33554534, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, '页面4', ''),
        new MasterpieceI({ "id": 33554534, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, '页面5', ''),
        new MasterpieceI({ "id": 33554534, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, '页面6', ''),
    ];
    return masterPiceIArr;
}

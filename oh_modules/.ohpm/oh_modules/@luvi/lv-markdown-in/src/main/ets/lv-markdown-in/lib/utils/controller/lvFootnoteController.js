var i = (this && this.i) || function (b6, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.j === "function")
        r = Reflect.j(b6, target, key, desc);
    else
        for (var c6 = b6.length - 1; c6 >= 0; c6--)
            if (d = b6[c6])
                r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
let LvFootnoteController = class LvFootnoteController {
    constructor() {
        this.footnoteList = "";
    }
    setFootnoteList(item) {
        this.footnoteList = (item);
    }
    getFootnoteList() {
        return this.footnoteList;
    }
};
LvFootnoteController = i([
    Observed
], LvFootnoteController);
export { LvFootnoteController };
export const lvFootnoteController = new LvFootnoteController();

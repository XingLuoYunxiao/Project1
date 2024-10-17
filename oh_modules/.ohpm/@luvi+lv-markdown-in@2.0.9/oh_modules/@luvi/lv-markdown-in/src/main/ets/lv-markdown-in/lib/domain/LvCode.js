var i = (this && this.i) || function (o, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.j === "function")
        r = Reflect.j(o, target, key, desc);
    else
        for (var t = o.length - 1; t >= 0; t--)
            if (d = o[t])
                r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
let LvCode = class LvCode {
    constructor() {
        this.theme = "dark";
        this.indexState = false;
    }
    setTheme(value) {
        this.theme = value;
    }
    setIndexState(m) {
        this.indexState = m;
    }
    getTheme() {
        return this.theme;
    }
    getIndexState() {
        return this.indexState;
    }
};
LvCode = i([
    Observed
], LvCode);
const lvCode = new LvCode();
export { lvCode, LvCode };

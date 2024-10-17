var i = (this && this.i) || function (j1, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.j === "function")
        r = Reflect.j(j1, target, key, desc);
    else
        for (var k1 = j1.length - 1; k1 >= 0; k1--)
            if (d = j1[k1])
                r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
let LvText = class LvText {
    constructor() {
        this.textSize = 15;
        this.textColor = "#595172";
        this.textMarkBackground = "#ffffd3b8";
        this.textLineHeight = 24;
    }
    setTextSize(value) {
        this.textSize = value;
    }
    setTextColor(value) {
        this.textColor = value;
    }
    setTextMarkBackground(value) {
        this.textMarkBackground = value;
    }
    setTextLineHeight(value) {
        this.textLineHeight = value;
    }
    getTextSize() {
        return this.textSize;
    }
    getTextColor() {
        return this.textColor;
    }
    getTextMarkBackground() {
        return this.textMarkBackground;
    }
    getTextLineHeight() {
        return this.textLineHeight;
    }
};
LvText = i([
    Observed
], LvText);
const lvText = new LvText();
export { lvText, LvText };

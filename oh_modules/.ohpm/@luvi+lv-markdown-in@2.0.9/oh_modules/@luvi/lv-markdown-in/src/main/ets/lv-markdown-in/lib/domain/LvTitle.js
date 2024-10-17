var i = (this && this.i) || function (m1, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.j === "function")
        r = Reflect.j(m1, target, key, desc);
    else
        for (var n1 = m1.length - 1; n1 >= 0; n1--)
            if (d = m1[n1])
                r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
let LvTitle = class LvTitle {
    constructor() {
        this.level1Title = 32;
        this.level2Title = 28;
        this.level3Title = 24;
        this.level4Title = 20;
        this.level5Title = 16;
        this.level6Title = 12;
        this.levelTitleColor = "#ff49515d";
    }
    setLevel1Title(value) {
        this.level1Title = value;
    }
    setLevel2Title(value) {
        this.level2Title = value;
    }
    setLevel3Title(value) {
        this.level3Title = value;
    }
    setLevel4Title(value) {
        this.level4Title = value;
    }
    setLevel5Title(value) {
        this.level5Title = value;
    }
    setLevel6Title(value) {
        this.level6Title = value;
    }
    setLevelTitleColor(value) {
        this.levelTitleColor = value;
    }
    getLevel1Title() {
        return this.level1Title;
    }
    getLevel2Title() {
        return this.level2Title;
    }
    getLevel3Title() {
        return this.level3Title;
    }
    getLevel4Title() {
        return this.level4Title;
    }
    getLevel5Title() {
        return this.level5Title;
    }
    getLevel6Title() {
        return this.level6Title;
    }
    getLevelTitleColor() {
        return this.levelTitleColor;
    }
};
LvTitle = i([
    Observed
], LvTitle);
const lvTitle = new LvTitle();
export { lvTitle, LvTitle };

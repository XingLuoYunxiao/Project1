var i = (this && this.i) || function (a1, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.j === "function")
        r = Reflect.j(a1, target, key, desc);
    else
        for (var b1 = a1.length - 1; b1 >= 0; b1--)
            if (d = a1[b1])
                r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
let LvImage = class LvImage {
    constructor() {
        this.imgWidth = "200";
        this.imgHeight = null;
        this.confGlobal = false;
        this.imgUrl = "";
    }
    setImgWidth(value) {
        this.imgWidth = value;
    }
    setImgHeight(value) {
        this.imgHeight = value;
    }
    setConfGlobal(value) {
        this.confGlobal = value;
    }
    setImgUrl(value) {
        this.imgUrl = value;
    }
    getImgWidth() {
        return this.imgWidth;
    }
    getImgHeight() {
        return this.imgHeight;
    }
    getConfGlobal() {
        return this.confGlobal;
    }
    getImgUrl() {
        return this.imgUrl;
    }
};
LvImage = i([
    Observed
], LvImage);
const lvImage = new LvImage();
export { lvImage, LvImage };

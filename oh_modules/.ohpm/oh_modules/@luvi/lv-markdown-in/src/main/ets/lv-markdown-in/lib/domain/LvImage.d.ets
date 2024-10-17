@Observed
declare class LvImage {
    private imgWidth;
    private imgHeight;
    private confGlobal;
    private imgUrl;
    setImgWidth(value: string): void;
    setImgHeight(value: string): void;
    setConfGlobal(value: boolean): void;
    setImgUrl(value: string): void;
    getImgWidth(): number | string;
    getImgHeight(): number | string | null;
    getConfGlobal(): boolean;
    getImgUrl(): string;
}
declare const lvImage: LvImage;
export { lvImage, LvImage };

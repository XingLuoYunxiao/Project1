@Observed
declare class LvLink {
    private textSize;
    private textColor;
    private textUnderline;
    private linkUrl;
    setTextSize(value: number | string): void;
    setTextColor(value: string): void;
    setTextUnderline(value: boolean): void;
    setLinkUrl(value: string): void;
    getTextSize(): number | string;
    getTextColor(): string;
    getTextUnderline(): boolean;
    getLinkUrl(): string;
}
declare const lvLink: LvLink;
export { lvLink, LvLink };

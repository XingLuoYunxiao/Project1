@Observed
declare class LvText {
    private textSize;
    private textColor;
    private textMarkBackground;
    private textLineHeight;
    setTextSize(value: number | string): void;
    setTextColor(value: string): void;
    setTextMarkBackground(value: string): void;
    setTextLineHeight(value: string): void;
    getTextSize(): number | string;
    getTextColor(): string;
    getTextMarkBackground(): string;
    getTextLineHeight(): string | number;
}
declare const lvText: LvText;
export { lvText, LvText };

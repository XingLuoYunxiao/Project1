@Observed
declare class LvQuote {
    private backgroundColor;
    private borderColor;
    setBackgroundColor(value: string): void;
    setBorderColor(value: string): void;
    getBackgroundColor(): string;
    getBorderColor(): string;
}
declare const lvQuote: LvQuote;
export { lvQuote, LvQuote };

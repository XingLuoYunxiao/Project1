type Theme = "light" | "dark";
@Observed
declare class LvCode {
    private theme;
    private indexState;
    setTheme(value: Theme): void;
    setIndexState(m: boolean): void;
    getTheme(): string;
    getIndexState(): boolean;
}
declare const lvCode: LvCode;
export { lvCode, LvCode };

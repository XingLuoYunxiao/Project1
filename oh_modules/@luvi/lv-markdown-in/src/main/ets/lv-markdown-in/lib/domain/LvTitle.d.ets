@Observed
declare class LvTitle {
    private level1Title;
    private level2Title;
    private level3Title;
    private level4Title;
    private level5Title;
    private level6Title;
    private levelTitleColor;
    setLevel1Title(value: number | string): void;
    setLevel2Title(value: number | string): void;
    setLevel3Title(value: number | string): void;
    setLevel4Title(value: number | string): void;
    setLevel5Title(value: number | string): void;
    setLevel6Title(value: number | string): void;
    setLevelTitleColor(value: string): void;
    getLevel1Title(): number | string;
    getLevel2Title(): number | string;
    getLevel3Title(): number | string;
    getLevel4Title(): number | string;
    getLevel5Title(): number | string;
    getLevel6Title(): number | string;
    getLevelTitleColor(): string;
}
declare const lvTitle: LvTitle;
export { lvTitle, LvTitle };

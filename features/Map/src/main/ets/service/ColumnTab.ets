
export class ColumnTab {
  private name: string;

  private iconSelected: ResourceStr;

  constructor(name: string,  iconSelected: ResourceStr) {
    this.name = name;
    this.iconSelected = iconSelected;
  }

  getName(): string {
    return this.name;
  }

  getIconSelected(): ResourceStr {
    return this.iconSelected;
  }
}
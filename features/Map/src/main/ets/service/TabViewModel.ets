import { RouteConstants } from "../constants/RouteConstants";
import { ColumnTab } from "./ColumnTab";


export class TabViewModel {
  private tabList: ColumnTab[] = [];

  constructor() {
    RouteConstants.TOPIC_LIST.forEach((item: string, index: number) => {
      this.tabList.push(new ColumnTab(item, RouteConstants.TOPIC_ICONS_SELECTED[index]));
    });
  }

  getTabList(): ColumnTab[] {
    return this.tabList;
  }
}
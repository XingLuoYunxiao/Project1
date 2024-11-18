import { IChat } from "@ohos/Uicomponents";
import { IBaseProject } from "@ohos/Uicomponents/src/main/ets/model/IBaseProject";
import { BuildingChat } from "./BuildingChat";
import { buildingList, TraditionalBuilding } from "./Buildings";


export class BuildingProject extends IBaseProject {
  buildings: TraditionalBuilding[]
  protected chats: BuildingChat[];

  constructor(name: string, buildings: TraditionalBuilding[], chats: BuildingChat[]) {
    super(name)
    this.chats = chats
    this.buildings = buildings
  }

  addChat(chat: IChat): void {
    throw new Error("Method not implemented.");
  }

  getChat(index: number): IChat {
    throw new Error("Method not implemented.");
  }

  getAllChat(): IChat[] {
    throw new Error("Method not implemented.");
  }
}

export const buildingProject: BuildingProject =
  new BuildingProject('古典建筑', buildingList, [new BuildingChat(new Date().getTime(), [])])
import { IBaseProject, IChat } from "uicomponents";
import { SkillChat } from "./skillChat";
import { TraditionalCraft, ceramicArt, silkWeaving, metalCraft } from "./skillModel";

export class skillProject extends IBaseProject {
  skills: TraditionalCraft[] = []
  protected chats: SkillChat[] = [];

  constructor(name: string, skills: TraditionalCraft[], chats: SkillChat[]) {
    super(name)
    this.skills = skills
    this.chats = chats
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

export const skillItance: skillProject =
  new skillProject("工巧技艺", [ceramicArt, silkWeaving, metalCraft], [new SkillChat(0, [])])
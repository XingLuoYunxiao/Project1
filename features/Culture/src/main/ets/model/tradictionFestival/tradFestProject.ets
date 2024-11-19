import { IBaseProject, IChat } from "uicomponents";
import { FestivalChat } from "./festivalChat";
import { Festival, festivalList } from "./festivalModel";

export class FestivalProject extends IBaseProject {
  public static introduction: string =
    '中国传统文化是中华民族五千年文明的结晶，包含了丰富的节日文化、习俗和哲学思想。传统节日如春节、清明节、端午节和中秋节等，不仅体现了人们对美好生活的追求，也展现了尊重自然、敬祖重孝的价值观。这些节日是中华民族精神文化的重要体现，传承着我们的民族传统和情感。'
  festivals: Festival[] = []
  protected chats: FestivalChat[] = []

  constructor(name: string, festivals: Festival[], chats: FestivalChat[]) {
    super(name); // 如果 IBaseProject 有构造函数的话，需要调用它
    this.festivals = festivals;
    this.chats = chats;
  }

  public getName(): string {
    return this.name
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

export const FestivalInstance: FestivalProject =
  new FestivalProject("中国传统节日", festivalList, [new FestivalChat(0, [])])
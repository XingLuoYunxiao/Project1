import { ChatMsg } from "../model/ChatMassageModel";
import { BasicDataSource } from "../model/poetryModel/PoetryModel";

//继承自BasicDataSource
export class ChatMsgModel extends BasicDataSource<ChatMsg> {
  data: Array<ChatMsg> = [];

  // 获取指定索引的数据
  public getData(index: number): void | ChatMsg {
    if (index === this.data.length - 1) {
    }
    return this.data[index];
  }
}


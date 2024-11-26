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

  public addMessage(meg: ChatMsg) {
    this.data.push(meg);
    this.notifyDataAdd(this.data.length - 1);
    this.notifyDataReload()
  }
}


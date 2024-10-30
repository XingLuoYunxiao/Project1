import { IChat } from './IChat'

export abstract class IBaseProject {
  protected name: string
  protected abstract chats: Array<IChat>

  constructor(name: string) {
    this.name = name
  }

  getName(): string {
    return this.name
  }

  //添加一个Chat
  abstract addChat(chat: IChat)

  //获取一个聊天记录
  abstract getChat(index: number): IChat

  //获取所有聊天记录
  abstract getAllChat(): Array<IChat>
}
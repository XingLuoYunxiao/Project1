import { ChatI } from './ChatI'

abstract class BaseProject1{
  protected name:string
  protected chats: Array<ChatI>

  constructor(name:string){
    this.name = name
    this.chats = []
  }

  //添加一个Chat
  abstract addChat(chat:ChatI)

  //获取一个聊天记录
  abstract getChat(index:number):ChatI

  //获取所有聊天记录
  abstract getAllChat():Array<ChatI>

}
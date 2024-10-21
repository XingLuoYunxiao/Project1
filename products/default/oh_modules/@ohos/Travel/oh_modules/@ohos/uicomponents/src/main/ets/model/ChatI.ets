interface Info{
  type:string
  content:string
}

export abstract class ChatI{
  protected id:number
  messages:Array<Info>

  constructor(id:number,messages:Array<Info>){
    this.id = id
    this.messages = messages
  }

  //返回调用大模型api获取的数据
  abstract getData(content: string):string

  abstract addMessage(message:string):void

  abstract getMessage(index:number):string
}
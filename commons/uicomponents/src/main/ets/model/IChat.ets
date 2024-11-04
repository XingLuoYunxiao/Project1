export interface Info{
  type:string
  content:string
}

export abstract class IChat{
  abstract id:number
  protected abstract messages:Array<Info>

  //返回调用大模型api获取的数据
  abstract getData(content: string, onUpdate?: (chunk: string) => void):Promise<string>

  abstract addMessage(message:string):void

  abstract getMessage(index:number):string
}

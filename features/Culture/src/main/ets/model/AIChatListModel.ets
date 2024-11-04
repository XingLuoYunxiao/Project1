export enum ChatMessageType {
  Text,
  Image,
}

export class ChatMsgModel {
  author: string;
  message: string; // 文本内容或者图片的URL
  messageType: ChatMessageType; // 根据类型判断是把message属性的值作为文本用Text渲染还是作为图片的URL用Image()渲染
  sentTime: string;
  authorImage: ResourceStr;

  constructor(
    author: string = '',
    message: string = '',
    messageType: ChatMessageType = ChatMessageType.Text,
    authorImage: ResourceStr = $r('app.media.ic_system_head'),
    sentTime: string = new Date().toISOString()

  ) {
    this.author = author;
    this.message = message;
    this.messageType = messageType;
    this.sentTime = sentTime;
    this.authorImage = authorImage;
  }
}

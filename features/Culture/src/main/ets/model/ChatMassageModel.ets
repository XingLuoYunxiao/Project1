//消息类型
export enum ChatMessageType {
  Text,
  Image,
}

//角色类型
export enum ROLE {
  system = 'system',
  IdiomSystem = '成语接龙',
  FlyFlowerSystem = '飞花令',
  user = '用户'
}

export class ChatMsg {
  role: ROLE;
  message: string; // 文本内容或者图片的URL
  messageType: ChatMessageType; // 根据类型判断是把message属性的值作为文本用Text渲染还是作为图片的URL用Image()渲染
  sentTime: string; //发送时间
  roleHeadImg: ResourceStr; //用户头像

  constructor(
    author: ROLE = ROLE.system,
    message: string = '',
    messageType: ChatMessageType = ChatMessageType.Text,
    authorImage: ResourceStr = $r('app.media.ic_system_head'),
    sentTime: string = new Date().toISOString()

  ) {
    this.role = author;
    this.message = message;
    this.messageType = messageType;
    this.sentTime = sentTime;
    this.roleHeadImg = authorImage;
  }
}

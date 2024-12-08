import { SpanType } from '../common/constants/chatConstant';

/**
 * 聊天内容item
 */
export class SpanItem {
  spanType: SpanType;
  text: string;
  imgSrc: string;
  constructor(spanType: SpanType, text: string, imgSrc: string) {
    this.spanType = spanType;
    this.text = text;
    this.imgSrc = imgSrc;
  }
}

//每条聊天信息
@Observed
export class MessageBase {
  maxWidth: number = 0; // 最大宽度
  isSelf: boolean = true; // 是否本人发言
  userName: string = ''; // 发言人信息
  spanItems: Array<SpanItem> = []; // Span、ImageSpan 信息列表
  constructor(self: boolean, userName: string, maxWidth: number) {
    this.isSelf = self;
    this.userName = userName;
    this.maxWidth = maxWidth;
  }
}

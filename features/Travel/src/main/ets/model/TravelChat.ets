import { IChat, Info } from '@ohos/uicomponents'

export class TravelChat extends IChat {
  id: number;
  protected messages: Array<Info>;

  constructor(id: number, messages: Array<Info>) {
    super();
    this.id = id;
    this.messages = messages;
  }

  getData(content: string): string {
    return 'hello';
  }

  addMessage(message: string): void {
    throw new Error('Method not implemented.');
  }

  getMessage(index: number): string {
    throw new Error('Method not implemented.');
  }
}
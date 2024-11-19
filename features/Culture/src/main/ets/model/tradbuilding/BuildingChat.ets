import { IChat, Info } from "uicomponents";

export class BuildingChat extends IChat {
  id: number
  protected messages: Info[];

  // 传入创建对话时的时间戳作为chat 的ID
  constructor(id: number, messages: Info[]) {
    super();
    this.id = id
    this.messages = messages
  }

  getData(content: string, onUpdate?: ((chunk: string) => void) | undefined): Promise<string> {
    throw new Error("Method not implemented.");
  }

  addMessage(message: string): void {
    throw new Error("Method not implemented.");
  }

  getMessage(index: number): string {
    throw new Error("Method not implemented.");
  }
}
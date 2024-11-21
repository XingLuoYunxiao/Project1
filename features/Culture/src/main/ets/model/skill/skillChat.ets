
import { IChat, Info } from "uicomponents";


export class SkillChat extends IChat {
  id: number;
  protected messages: Info[];

  constructor(id: number, messages: Array<Info>) {
    super();
    this.id = id;
    this.messages = messages;
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

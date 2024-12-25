import { ChatMsg } from "../../../model/ChatMassageModel";
import { ChatMsgModel } from "../../../viewmodel/MessageViewModel";
import { MessageComponent } from "../../MessageComponent";

@Component
export struct chatComponent {
  @Prop MessageDataModel: ChatMsgModel

  build() {
    Column() {
      List({ space: 10 }) {
        LazyForEach(this.MessageDataModel, (item: ChatMsg) => {
          ListItem() {
            MessageComponent({ role: item.role, roleHeadImg: item.roleHeadImg, msg: item.message });
          }
        });
      }
      .cachedCount(20);
    }
  }
}
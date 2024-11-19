import {baseFuncViewComponent} from '../view/baseFuncComponent'
import { PromptWords,promptMap } from "../model/promptWords";
@Component
export  struct AppreciateView{

  @Prop  importContent:string[]
  build() {
    baseFuncViewComponent({funcView:promptMap.get("赏"),importContent:this.importContent})
  }
}
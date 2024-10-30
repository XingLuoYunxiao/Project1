import { promptMap } from "../model/promptWords"
import { baseFuncViewComponent } from "./baseFuncView"

@Component
export  struct TranslateView{

  @Prop  importContent:string[]
  build() {
    baseFuncViewComponent({funcView:promptMap.get("译"),importContent:this.importContent})
  }
}

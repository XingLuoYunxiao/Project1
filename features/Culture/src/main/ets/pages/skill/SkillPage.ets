import { skillItance as skillInstance, skillProject } from "../../model/skill/skillProject"

@Component
export struct SkillPage {
  @State skillInstance: skillProject = skillInstance

  build() {
    Column() {
      Text(skillInstance.getName())


    }
  }
}
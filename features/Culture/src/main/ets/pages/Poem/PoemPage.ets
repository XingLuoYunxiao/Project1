
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from 'routermodule';

import { PoemSplitPage } from './PoemSplitPage';

let addEXPId: number = 0

const TAG: string = 'PoemPage'

@Component
export struct PoemPage { // 定义一个组件类PoemPage

  @Provide('PoemListStack') PoemListStack: NavPathStack = new NavPathStack()

  // 构建组件UI结构
  aboutToAppear(): void {
    RouterModule.createRouter(RouterNameConstants.CULTURE_POEMLIST, this.PoemListStack)

  }

  build() {
    NavDestination() {
      PoemSplitPage()
    }
    .hideTitleBar(true)

  }

  aboutToDisappear(): void {
    // 退出页面时取消对经验值的添加
    clearTimeout(addEXPId)
  }
}


@Builder
export function PoemPageBuilder() {
  PoemPage()
}

const builderName = BuilderNameConstants.CULTURE_POEM
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(PoemPageBuilder)
  RouterModule.registerBuilder(builderName, builder)
}
import { BuilderNameConstants, RouterModule } from 'routermodule';
import { TalkToAI } from './ai';


@Component
export struct testPage {
  aboutToAppear(): void {
    console.log('testPage')
  }

  build() {
    NavDestination() {
      TalkToAI()
      
    }
  }
}


@Builder
export function testPageBuilder() {
  testPage()
}

const builderName = BuilderNameConstants.CULTURE_TEST
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(testPageBuilder)
  RouterModule.registerBuilder(builderName, builder)
}
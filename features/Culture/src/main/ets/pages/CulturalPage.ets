import { BuilderNameConstants, buildRouterModel, RouterModel, RouterNameConstants } from "routermodule";
import { category, gameList, literatureList, traditionList, } from "../model/category";
import { LogUtil } from 'utils/src/main/ets/puraUtils/LogUtil'

let TAG: string = "CulturalPage  "

@Component
export struct CulturalPage {
  @Consume('appPathStack') appPathStack: NavPathStack;
  @Consume('culturePathStack') culturePathStack: NavPathStack;

  // @Builder
  // routerMap(builderName: string, param?: object) {
  //   RouterModule.getBuilder(builderName).builder(param);
  // }

  build() {
    Navigation(this.culturePathStack) {
      Column({ space: 15 }) {
        Text('文化天地')
          .fontSize($r('app.float.large_text_size'))
          .onClick(() => {
            LogUtil.debug('你点击了动态路由')
            buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.CULTURE_SENTENCE)
          })

        groupComponent({ groupName: "文学", groupData: literatureList })

        groupComponent({ groupName: "文化", groupData: traditionList })
        groupComponent({ groupName: "小游戏", groupData: gameList })

        // List({ space: 20 }) {
        //   ForEach(literatureList, (item: category) => {
        //     ListItem() {
        //       Column() {
        //         Text(item.name)
        //           .fontSize(24)
        //       }
        //       .width(100)
        //       .height(60)
        //       .backgroundColor(Color.Gray)
        //       .onClick(() => {
        //         LogUtil.debug('你点击了动态路由')
        //         buildRouterModel(RouterNameConstants.ENTRY_HAP, item.path)
        //       })
        //     }
        //
        //   },
        //     (item: category) => item.name)
        //
        // }

      }
      .height('90%')
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.SpaceAround)
    }
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)

    //.navDestination(this.routerMap)

  }
}

@Component
struct groupComponent {
  @Prop groupName: string
  @Prop groupData: category[]

  build() {

    Column() {
      Row() {
        Text(this.groupName).fontSize(24)
          .margin({ left: 15 })
      }
      .backgroundColor($r('app.color.main_background'))
      .justifyContent(FlexAlign.Start)
      .height(60)
      .width('90%')
      .borderRadius(20)

      Grid() {
        ForEach(this.groupData, (item: category) => {
          GridItem() {
            Text(item.name)
              .fontSize(24)
              .borderRadius(20)
              .onClick(() => {
                buildRouterModel(RouterNameConstants.ENTRY_HAP, item.path)
              })

          }
        })

      }
      .width('80%')
      .height(100)
      .columnsGap(10)
      .rowsGap(30)
      .columnsTemplate('1fr 1fr')

    }
    .width('100%')

  }
}
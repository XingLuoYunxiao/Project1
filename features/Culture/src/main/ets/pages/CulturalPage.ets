import { BuilderNameConstants, buildRouterModel, RouterModel, RouterNameConstants } from "routermodule";
import { category, gameList, literatureList, traditionList, } from "../model/category";
import { LogUtil } from 'utils/src/main/ets/puraUtils/LogUtil'
import { cloudStorage } from '@kit.CloudFoundationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { CloudStorageConstants } from "../common/constants/cloudStorageConstants";
import { CloudStorageService } from "../service/CloudStorage";


let TAG: string = "CulturalPage  "


@Component
export struct CulturalPage {
  @Consume('appPathStack') appPathStack: NavPathStack;
  @Consume('culturePathStack') culturePathStack: NavPathStack;

  build() {
    Navigation(this.culturePathStack) {
      Column({ space: 15 }) {
        Text('文化天地')
          .fontSize($r('app.float.large_text_size'))

        Text('测试页面')
          .fontSize($r('app.float.large_text_size'))
          .onClick(() => {
            buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.CULTURE_TEST)
          })

        groupComponent({ groupName: "文学", groupData: literatureList })
        groupComponent({ groupName: "文化", groupData: traditionList })
        groupComponent({ groupName: "小游戏", groupData: gameList })


      }
      .height('90%')
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.SpaceAround)
    }
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)

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
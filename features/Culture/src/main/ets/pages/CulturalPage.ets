import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from "routermodule";
import { category, gameList, literatureList, traditionList, } from "../model/category";
import { LogUtil } from 'utils/src/main/ets/puraUtils/LogUtil'

import { downloadImage } from "../common/util/getImage";

import { CloudStorageConstants } from "../common/constants/cloudStorageConstants";
import { BreakpointTypeEnum } from "utils";


let TAG: string = "CulturalPage  "


@Component
export struct CulturalPage {
  @Consume('appPathStack') appPathStack: NavPathStack;
  @Consume('culturePathStack') culturePathStack: NavPathStack;
  @StorageProp('currentBreakpoint') currentBreakpoint: string = BreakpointTypeEnum.MD;

  aboutToAppear(): void {
    downloadImage(CloudStorageConstants.constantsMap)
  }

  build() {
    Navigation(this.culturePathStack) {
      Scroll() {

        Column({ space: 15 }) {
          // Text('文化天地')
          //   .fontSize($r('app.float.title_text_size'))

          Text('测试页面')
            .fontSize($r('app.float.large_text_size'))
            .onClick(() => {
              buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.CULTURE_TEST)
            })

          groupComponent({ groupName: "文学", groupData: literatureList })
          groupComponent({ groupName: "文化", groupData: traditionList })
          groupComponent({ groupName: "小游戏", groupData: gameList })

        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.SpaceAround)
      }
      .scrollable(ScrollDirection.Vertical)
    }
    .mode((this.currentBreakpoint === BreakpointTypeEnum.MD || BreakpointTypeEnum.SM) ? NavigationMode.Stack :
    NavigationMode.Split)
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
      .justifyContent(FlexAlign.Start)
      .height(60)
      .width('90%')
      .borderRadius(20)

      Divider()
        .strokeWidth(2)
        .margin({ bottom: 10 })

      Grid() {
        ForEach(this.groupData, (item: category) => {
          GridItem() {
            Column() {
              Image(item.ic)
                .width(200)
                .borderRadius(20)
              Text(item.name)
                .fontSize(24)
                .borderRadius(20)
            }
            .onClick(() => {
              LogUtil.debug('你点击了' + item.name)
              buildRouterModel(RouterNameConstants.ENTRY_HAP, item.path)
            })

          }
        })

      }
      .enableScrollInteraction(false)
      .scrollBar(BarState.Off)
      .width('80%')
      // .height(300)
      .columnsGap(10)
      .rowsGap(30)
      .columnsTemplate('1fr 1fr')

    }
    .width('100%')

  }
}
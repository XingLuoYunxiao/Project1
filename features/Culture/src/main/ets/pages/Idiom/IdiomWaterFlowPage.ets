import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule";
import { BreakpointTypeEnum } from "utils";
import { RandomUtil } from "utils/src/main/ets/puraUtils/RandomUtil";
import { realIdiomDataModel } from "../../model/Idiom/DataModel";

import { realIdiom } from "../../model/Idiom/RealIdiom";
import { CloudIdiomService } from "../../service/CloudIdiomService";

@Component
export struct IdiomWaterFlowPage {
  @State data: realIdiomDataModel = new realIdiomDataModel()
  @State minSize: number = 60
  @State maxSize: number = 160
  @State pageNumber: number = 1
  @State startId: number = 0
  scroller: Scroller = new Scroller()
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointTypeEnum.MD;
  private itemWidthArray: number[] = []
  private itemHeightArray: number[] = []

  // 计算FlowItem宽/高
  getSize() {
    let ret = Math.floor(Math.random() * this.maxSize)
    return (ret > this.minSize ? ret : this.minSize)
  }

  // 设置FlowItem宽/高数组
  setItemSizeArray() {
    for (let i = 0; i < 100; i++) {
      this.itemWidthArray.push(this.getSize())
      this.itemHeightArray.push(this.getSize())
    }
  }

  aboutToAppear() {
    this.startId = RandomUtil.randomLimit(20000)
    this.setItemSizeArray()
    this.fetchData()
  }

  async fetchData() {
    let realIdiomData: realIdiom[] | undefined =
      await CloudIdiomService.fetchIdiomsAfterId(this.startId) //获取startId 后面20条数据
    this.startId += 40
    if (realIdiomData) {
      realIdiomData.forEach((r) => {
        this.data.pushData(r)
      })
    }
  }

  build() {
    NavDestination() {
      Column() {
        if (this.currentBreakpoint === 'sm' || this.currentBreakpoint === 'md') {
          WaterFlow() {
            LazyForEach(this.data, (item: realIdiom, index: number) => {
              FlowItem() {
                Column() {

                  Text(item.word)
                    .fontSize(16)
                }

              }
              .onAppear(() => {
                // 即将触底时提前增加数据
                this.fetchData()
              })
              .onClick(() => {
                buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.CULTURE_IDIOM,
                  new Object(item))
              })
              .backgroundColor($r('app.color.main_background'))
              .height(this.itemHeightArray[index % 100])
              .margin(5)
              .width('100%')
            }, (item: realIdiom) => item.id.toString())
          }
          .cachedCount(40)
          .columnsTemplate("1fr 1fr 1fr ")
          .columnsGap(10)
          .rowsGap(5)
          .backgroundColor(Color.White)
          .width('100%')
          .height('100%')
        } else {
          WaterFlow() {
            LazyForEach(this.data, (item: realIdiom, index: number) => {
              FlowItem() {
                Column() {

                  Text(item.word)
                    .fontSize(16)
                }

              }
              .onAppear(() => {
                // 即将触底时提前增加数据
                this.fetchData()
              })
              .onClick(() => {
                buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.CULTURE_IDIOM,
                  new Object(item))
              })
              .backgroundColor($r('app.color.main_background'))
              .height(this.itemHeightArray[index % 100])
              .margin(5)
              .width('100%')
            }, (item: realIdiom) => item.id.toString())
          }
          .cachedCount(40)
          .columnsTemplate("1fr 1fr 1fr 1fr 1fr")
          .columnsGap(10)
          .rowsGap(5)
          .backgroundColor(Color.White)
          .width('100%')
          .height('100%')
        }

      }
    }

  }
}

@Builder
export function IdiomWaterFlowPageBuilder() {
  IdiomWaterFlowPage()
}

const builderName = BuilderNameConstants.CULTURE_IDIOMWATERFLOW
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(IdiomWaterFlowPageBuilder)
  RouterModule.registerBuilder(builderName, builder)
}
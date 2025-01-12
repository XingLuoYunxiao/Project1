import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule";
import { BreakpointTypeEnum } from "utils";
import { RandomUtil } from "utils/src/main/ets/puraUtils/RandomUtil";
import { realIdiomDataModel } from "../../model/Idiom/DataModel";

import { realIdiom } from "../../model/Idiom/RealIdiom";
import { CloudIdiomService } from "../../service/CloudIdiomService";
import { CommonConstants } from '../../common/constants/commonConstants';

let heightMap: Map<number, number> = new Map<number, number>()

@Component
export struct IdiomWaterFlowPage {
  @State data: realIdiomDataModel = new realIdiomDataModel()
  @State minSize: number = 60
  @State maxSize: number = 160
  @State pageNumber: number = 1
  @State startId: number = 0
  @State count: number = 0
  scroller: Scroller = new Scroller()
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointTypeEnum.MD;
  private itemWidthArray: number[] = []
  private itemHeightArray: number[] = []

  // 计算FlowItem宽/高
  getSize() {
    let ret = Math.floor(Math.random() * this.maxSize)
    return (ret > this.minSize ? ret : this.minSize)
  }

  getHeight(id: number): number {
    if (!heightMap.has(id)) {
      // 如果没有为给定ID设置高度，则创建一个新的随机高度并保存。
      const height = this.getSize();
      heightMap.set(id, height);
    }
    return heightMap.get(id) as number;
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
      await CloudIdiomService.fetchIdiomsAfterId(this.startId) //获取startId 后面40条数据
    this.startId += CommonConstants.fetchNumber
    if (realIdiomData) {
      realIdiomData.forEach((r) => {
        this.data.pushData(r)
      })
    }
  }

  build() {
    NavDestination() {
      Column() {

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

              this.count++
              if (this.count === CommonConstants.fetchNumber - 3) {
                this.fetchData()
                this.count = 0
              }
            })

            .onClick(() => {
              buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.CULTURE_IDIOM,
                new Object(item))
            })
            .backgroundColor($r('app.color.main_background'))
            .height(this.getHeight(item.id))
            .margin(5)
            .width('100%')
          }, (item: realIdiom) => item.id.toString())
        }
        .cachedCount(40)
        .columnsTemplate(this.currentBreakpoint === BreakpointTypeEnum.LG ? "1fr 1fr 1fr 1fr 1fr" : "1fr 1fr 1fr ")
        .columnsGap(10)
        .rowsGap(5)
        .backgroundColor(Color.White)
        .width('100%')
        .height('100%')
      }

    }

  }

  @Builder
  itemBuilder(word: string) {
    Text(word)
      .fontSize(16)
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
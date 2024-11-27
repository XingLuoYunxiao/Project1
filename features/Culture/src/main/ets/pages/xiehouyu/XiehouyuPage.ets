import { BuilderNameConstants, RouterModule } from "routermodule"
import { getXiehouyuFormCloud } from "../../common/constants/CloundDb/getXiehouyuDataFormCloudDb"
import { CommonConstants } from "../../common/constants/commonConstants"
import { addExp } from "../../common/util/addExp"
import { BasicDataSource } from "../../model/poetryModel/PoetryModel"
import { Xiehouyu } from "../../model/Xiehouyu"

let addEXPId: number = 0

@Component
export struct XiehouyuPage {
  @State xieList: Xiehouyu[] = []
  @State xieSet: Set<number> = new Set()

  async aboutToAppear(): Promise<void> {
    let res: Xiehouyu[] = await this.getXiehouyuList()
    res.forEach(item => {
      xiehouyuModel.pushData(item)
    })

    //每10秒浏览页面加5经验
    addEXPId = setTimeout(() => {
      addExp(CommonConstants.expTypeKnowledge, 5)
    }, 10000)
  }

  aboutToDisappear(): void {
    clearTimeout(addEXPId)
  }

  async getXiehouyuList(): Promise<Xiehouyu[]> {
    let count: number = 0
    let resIds: number[] = []

    // 生成不重复的随机ID
    while (count < 30) {
      let rand: number = Math.floor(Math.random() * (14032 - 1) + 1);
      // if (this.xieSet.has(rand)) {
      //   continue
      // } else {
      //   this.xieSet.add(rand)
      //
      // }
      resIds.push(rand)
      count++
    }

    // 使用 for...of 循环，支持异步操作
    let resXieList: Xiehouyu[] = []
    for (let id of resIds) {
      let xieItem: Xiehouyu | undefined = await getXiehouyuFormCloud.fetchXiehouyuById(id)
      if (xieItem) {
        console.log('获取歇后语：' + JSON.stringify(xieItem))
        resXieList.push(xieItem)
      }
    }

    return resXieList
  }

  build() {
    NavDestination() {
      Column() {
        List({ space: 10 }) {
          LazyForEach(xiehouyuModel, (item: Xiehouyu) => {
            ListItem() {
              Row() {
                Text(item.riddle)
                  .fontSize(24)
                Text('——' + item.answer)
                  .fontSize(24)
              }
              .backgroundColor($r('app.color.main_background'))
              .width('100%')
              .padding(20)
              .borderRadius(20)

            }
          },
            (item: Xiehouyu) => item.id.toString())
        }
        .edgeEffect(EdgeEffect.Spring)
        .onReachEnd(async () => {
          let res: Xiehouyu[] = await this.getXiehouyuList()
          res.forEach(item => {
            xiehouyuModel.pushData(item)
          })
          xiehouyuModel.notifyDataReload()
        })
        .cachedCount(20)

      }
      .width('100%')
    }

  }
}


class XiehouyuModel extends BasicDataSource<Xiehouyu> {
  data: Xiehouyu[] = []

  public getData(index: number): void | Xiehouyu {
    if (index === this.data.length - 1) {
    }
    return this.data[index];
  }
}

const xiehouyuModel: XiehouyuModel = new XiehouyuModel()


@Builder
export function XiehouyuPageBuilder() {
  XiehouyuPage()
}

const builderName = BuilderNameConstants.CULTURE_XIEHOUYU
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(XiehouyuPageBuilder)
  RouterModule.registerBuilder(builderName, builder)
}


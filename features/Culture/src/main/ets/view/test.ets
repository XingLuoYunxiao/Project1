import { Poem } from "../model/Poem"
import { cloudDatabase } from "@kit.CloudFoundationKit"
import { BusinessError } from "@kit.BasicServicesKit"


@Component
export struct PoemsPage {
  @State poemsList: Poem[] = []
  @State pageNumber: number = 1

  async aboutToAppear(): Promise<void> {
    let res: Poem[] | undefined = await fetchAllData(this.pageNumber)
    if (res) {
      res.forEach(poem => {
        this.poemsList.push(poem); // 添加数据
      });

    }
  }

  build() {
    Column() {

      List({ space: 10 }) {
        ForEach(this.poemsList, (item: Poem) => {
          ListItem() {
            this.PoemItem(item)
          }
        })
      }
      .onReachEnd(async () => { // 滑动到底部时触发
        this.pageNumber++; // 页码增加
        let res: Poem[] | undefined = await fetchAllData(this.pageNumber)

        if (res) {
          res.forEach(poem => {
            this.poemsList.push(poem); // 添加数据
          });
        }
      })
    }
    .width('100%')
  }

  @Builder
  PoemItem(poem: Poem) {
    Column({ space: 10 }) {
      Text(poem.title)// 诗歌标题
        .fontSize($r('app.float.normal_text_size1'));
      Text(poem.writer)// 诗人
        .fontSize($r('app.float.normal_text_size1'));
      Text(poem.dynasty)// 朝代
        .fontSize($r('app.float.normal_text_size1'));
      Text(poem.content)// 诗歌内容
        .fontSize($r('app.float.normal_text_size1'));
    }
    .borderRadius(25) // 圆角
    .backgroundColor('#fff5eee6') // 背景颜色
    .padding(20) // 内边距
    .justifyContent(FlexAlign.Center) // 垂直居中
    .width('100%') // 宽度
  }
}


async function fetchAllData(pageNumber: number = 1): Promise<Poem[] | undefined> {
  try {
    let databaseZone = cloudDatabase.zone('Travel');
    let condition = new cloudDatabase.DatabaseQuery(Poem);

    // 每次查询 15 条记录
    const limit = 15;
    // 计算跳过多少条记录，公式：skip = (pageNumber - 1) * limit
    const skip = (pageNumber - 1) * limit;

    // 设置查询条件：分页查询
    condition.limit(15, skip)

    condition.equalTo('writer', '李白') // 查询writer == 李白  的数据
    condition.contains('type', '爱国') // 查询 type这个string里，包含爱国的 数据，即字符串匹配
    condition.contains('type', '爱国').and().equalTo('dynasty', '唐代') // 复合查询，查询唐代的爱国诗词

    return new Promise((resolve, reject) => {
      databaseZone.query(condition, (err: BusinessError, poemArray: Poem[]) => {
        if (err) {
          console.error(`查询失败，错误代码: ${err.code}, 错误信息: ${err.message}`);
          reject(err)
        } else {
          console.info(`查询成功，结果: ${JSON.stringify(poemArray)}`);
          resolve(poemArray)
        }
      })
    })
  } catch (err) {
    console.error(`捕获到错误: ${err.message}`);
    return undefined; // 确保函数返回 undefined
  }
}
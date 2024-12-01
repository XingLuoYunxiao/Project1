import { Poem } from "../model/Poem";
import { BasicDataSource } from "../model/poetryModel/PoetryModel";

// 诗歌数据模型类，继承自BasicDataSource
export class PoemModel extends BasicDataSource<Poem> {
  data: Array<Poem> = []; // 诗歌数据数组

  // 获取指定索引的数据
  public getData(index: number): void | Poem {
    if (index === this.data.length - 1) {
    }
    return this.data[index];
  }
}
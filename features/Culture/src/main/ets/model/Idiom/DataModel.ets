import { BasicDataSource } from '../poetryModel/PoetryModel';
import { realIdiom } from './RealIdiom';

export class realIdiomDataModel extends BasicDataSource<realIdiom> {
  data: Array<realIdiom> = []; // 诗歌数据数组

  // 获取指定索引的数据
  public getData(index: number): void | realIdiom {
    if (index === this.data.length - 1) {
    }
    return this.data[index];
  }
}
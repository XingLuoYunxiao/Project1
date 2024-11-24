import { cloudDatabase } from '@kit.CloudFoundationKit';
import { Poem } from '../model/Poem';
import { BusinessError } from '@kit.BasicServicesKit';
import { Writer } from '../model/Writer';
import { Sentence } from '../model/Sentence';

export class CloudPoemService {
  //不设置查询条件
  public static async fetchAllData(pageNumber: number = 1): Promise<Poem[] | undefined> {
    try {
      let databaseZone = cloudDatabase.zone('Travel');
      let condition = new cloudDatabase.DatabaseQuery(Poem);

      // 每次查询 15 条记录
      const limit = 15;
      // 计算跳过多少条记录，公式：skip = (pageNumber - 1) * limit
      const skip = (pageNumber - 1) * limit;

      // 设置查询条件：分页查询
      condition.limit(15, skip)


      return new Promise((resolve, reject) => {
        databaseZone.query(condition, (err: BusinessError, poemArray: Poem[]) => {
          if (err) {
            console.error(`查询失败，错误代码: ${err.code}, 错误信息: ${err.message}`);
            reject(err);
          } else {
            console.info(`查询成功，结果: ${JSON.stringify(poemArray)}`);
            resolve(poemArray);
          }
        });
      });
    } catch (err) {
      console.error(`捕获到错误: ${err.message}`);
      return undefined; // 确保函数返回 undefined
    }
  }

  // 封装获取分页数据的函数
  public static async fetchPoemDataByType(type: string, pageNumber: number = 1): Promise<Poem[] | undefined> {
    try {
      let databaseZone = cloudDatabase.zone('Travel');
      let condition = new cloudDatabase.DatabaseQuery(Poem);

      // 每次查询 15 条记录
      const limit = 15;
      // 计算跳过多少条记录，公式：skip = (pageNumber - 1) * limit
      const skip = (pageNumber - 1) * limit;

      // 设置查询条件：分页查询
      condition.contains('type', type)
        .limit(limit, skip) // 每页 15 条,跳过前面已查询的记录


      return new Promise((resolve, reject) => {
        databaseZone.query(condition, (err: BusinessError, poemArray: Poem[]) => {
          if (err) {
            console.error(`查询失败，错误代码: ${err.code}, 错误信息: ${err.message}`);
            reject(err);
          } else {
            console.info(`查询成功，结果: ${JSON.stringify(poemArray)}`);
            resolve(poemArray);
          }
        });
      });
    } catch (err) {
      console.error(`捕获到错误: ${err.message}`);
      return undefined; // 确保函数返回 undefined
    }
  }

  //根据诗人，类型，朝代获取数据
  public static async fetchPoem(poet: string, type: string, dynasty: string,
    pageNumber: number = 1): Promise<Poem[] | undefined> {
    let databaseZone = cloudDatabase.zone('Travel');
    let condition = new cloudDatabase.DatabaseQuery(Poem);

    // 每次查询 20 条记录
    const limit = 20;
    // 计算跳过多少条记录，公式：skip = (pageNumber - 1) * limit
    const skip = (pageNumber - 1) * limit;

    try {
      // 1 如果诗人 = '全部'
      if (poet === '全部') {
        // 1.1 如果诗人 = '全部', 类型 = '全部'
        if (type === '全部') {
          // 1.1.1 如果诗人 = '全部', 类型 = '全部', 朝代 = '全部'，不设置任何条件
          if (dynasty === '全部') {
            // 不设置任何查询条件
            condition.limit(15, skip);
          } else {
            // 1.1.2 如果诗人 = '全部', 类型 = '全部', 朝代 ≠ '全部'，查询指定朝代的诗歌
            condition.equalTo('dynasty', dynasty);
          }
        }
        // 1.2 如果诗人 = '全部', 类型 ≠ '全部'
        else {
          // 1.2.1 如果诗人 = '全部', 类型 ≠ '全部', 朝代 = '全部'，查询指定类型的诗歌
          if (dynasty === '全部') {
            condition.contains('type', type);
          } else {
            // 1.2.2 如果诗人 = '全部', 类型 ≠ '全部', 朝代 ≠ '全部'，查询指定类型和朝代的诗歌
            condition.contains('type', type).equalTo('dynasty', dynasty);
          }
        }
      }
      // 2 如果诗人 ≠ '全部'
      else {
        // 2.1 如果诗人 ≠ '全部', 类型 = '全部'
        if (type === '全部') {
          // 2.1.1 如果诗人 ≠ '全部', 类型 = '全部', 朝代 = '全部'，只查询指定诗人的诗歌
          if (dynasty === '全部') {
            condition.equalTo('writer', poet);
          } else {
            // 2.1.2 如果诗人 ≠ '全部', 类型 = '全部', 朝代 ≠ '全部'，查询指定诗人和朝代的诗歌
            condition.equalTo('writer', poet).equalTo('dynasty', dynasty);
          }
        }
        // 2.2 如果诗人 ≠ '全部', 类型 ≠ '全部'
        else {
          // 2.2.1 如果诗人 ≠ '全部', 类型 ≠ '全部', 朝代 = '全部'，查询指定诗人和类型的诗歌
          if (dynasty === '全部') {
            condition.equalTo('writer', poet).contains('type', type);
          } else {
            // 2.2.2 如果诗人 ≠ '全部', 类型 ≠ '全部', 朝代 ≠ '全部'，查询指定诗人、类型和朝代的诗歌
            condition.equalTo('writer', poet).contains('type', type).equalTo('dynasty', dynasty);
          }
        }
      }

      // 设定分页查询
      condition.limit(limit, skip);

      return new Promise((resolve, reject) => {
        databaseZone.query(condition, (err: BusinessError, poemArray: Poem[]) => {
          if (err) {
            console.error(`查询失败，错误代码: ${err.code}, 错误信息: ${err.message}`);
            reject(err);
          } else {
            console.info(`查询成功，结果: ${JSON.stringify(poemArray)}`);
            resolve(poemArray);
          }
        });
      });

    } catch (err) {
      console.error(`捕获到错误: ${err.message}`);
      return undefined; // 确保函数返回 undefined
    }
  }

  //根据诗人name获取诗人数据
  public static async fetchWriterData(writer: string): Promise<Writer[] | undefined> {

    let databaseZone = cloudDatabase.zone('Travel');
    let condition = new cloudDatabase.DatabaseQuery(Writer);

    condition.equalTo('name', writer).limit(1)

    try {
      return new Promise((resolve, reject) => {
        databaseZone.query(condition, (err: BusinessError, writerData: Writer[]) => {
          if (err) {
            console.error(`查询失败，错误代码: ${err.code}, 错误信息: ${err.message}`);
            reject(err)
          } else {
            console.info(`查询成功，结果: ${JSON.stringify(writerData)}`);
            resolve(writerData)
          }
        })
      })

    } catch (err) {
      return undefined
    }
  }

  //诗人name和poem的title获取poem数据
  public static async fetchDataByWriterAndTitle(writer: string, title: string): Promise<Poem[] | undefined> {
    try {
      let databaseZone = cloudDatabase.zone('Travel');
      let condition = new cloudDatabase.DatabaseQuery(Poem);


      // 设置查询条件：分页查询
      condition.equalTo('writer', writer).and().equalTo('title', title).limit(1)


      return new Promise((resolve, reject) => {
        databaseZone.query(condition, (err: BusinessError, poemArray: Poem[]) => {
          if (err) {
            console.error(`查询失败，错误代码: ${err.code}, 错误信息: ${err.message}`);
            reject(err);
          } else {
            console.info(`查询成功，结果: ${JSON.stringify(poemArray)}`);
            resolve(poemArray);
          }
        });
      });
    } catch (err) {
      console.error(`捕获到错误: ${err.message}`);
      return undefined; // 确保函数返回 undefined
    }
  }

  //获取名句数据
  public static async fetchSentence(
    pageNumber: number = 1): Promise<Sentence[] | undefined> {
    let databaseZone = cloudDatabase.zone('Travel');
    let condition = new cloudDatabase.DatabaseQuery(Sentence);

    // 每次查询 20 条记录
    const limit = 20;
    // 计算跳过多少条记录，公式：skip = (pageNumber - 1) * limit
    const skip = (pageNumber - 1) * limit;

    try {
      // 设定分页查询
      condition.limit(limit, skip);

      return new Promise((resolve, reject) => {
        databaseZone.query(condition, (err: BusinessError, SentenceArray: Sentence[]) => {
          if (err) {
            console.error(`查询失败，错误代码: ${err.code}, 错误信息: ${err.message}`);
            reject(err);
          } else {
            console.info(`查询成功，结果: ${JSON.stringify(SentenceArray)}`);
            resolve(SentenceArray);
          }
        });
      });

    } catch (err) {
      console.error(`捕获到错误: ${err.message}`);
      return undefined; // 确保函数返回 undefined
    }
  }

  //诗句是否在数据库里
  public static async isPoemSentence(str: string): Promise<boolean> {
    try {
      let databaseZone = cloudDatabase.zone('Travel');
      let condition = new cloudDatabase.DatabaseQuery(Poem);

      // 设置查询条件：包含指定字符串
      condition.contains('content', str);

      return new Promise((resolve, reject) => {
        databaseZone.query(condition, (err: BusinessError, poemArray: Poem[]) => {
          if (err) {
            console.error(`查询失败，错误代码: ${err.code}, 错误信息: ${err.message}`);
            reject(false);
          } else {
            console.info(`查询成功，结果: ${JSON.stringify(poemArray)}`);
            resolve(poemArray.length > 0);
          }
        });
      });
    } catch (err) {
      console.error(`捕获到错误: ${err.message}`);
      return false; // 确保函数返回 false
    }
  }

  // 获取包含特定字符的诗句所在的整首诗
  public static async fetchPoemSentenceByChar(char: string, begins: number): Promise<Poem | undefined> {

    try {
      let databaseZone = cloudDatabase.zone('Travel');
      let condition = new cloudDatabase.DatabaseQuery(Poem);

      // 设置查询条件：包含指定字符
      condition.greaterThan('numId', begins).contains('content', char).limit(1);

      return new Promise((resolve, reject) => {
        databaseZone.query(condition, (err: BusinessError, poemArray: Poem[]) => {
          if (err) {
            console.error(`查询失败，错误代码: ${err.code}, 错误信息: ${err.message}`);
            reject(undefined);
          } else {
            console.info(`查询成功，结果: ${JSON.stringify(poemArray)}`);

            resolve(poemArray[0]);
          }
        });
      });
    } catch (err) {
      console.error(`捕获到错误: ${err.message}`);
      return undefined;
    }
  }

  public static extractSentence(poem: Poem, char: string): string | undefined {
    // 分割诗句，每一句以句号结尾
    if (poem.content) {
      const sentences = poem.content.split(/[\。]/).map(s => s.trim()).filter(s => s.length > 0);
      for (const sentence of sentences) {
        if (sentence.includes(char)) {
          return sentence; // 返回包含特定字符的句子
        }
      }
      return undefined;
    } else {
      return undefined
    }
  }
}
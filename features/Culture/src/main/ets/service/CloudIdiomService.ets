import { cloudDatabase } from "@kit.CloudFoundationKit";
import { Idiom } from "../model/Idiom/Idiom";
import { BusinessError } from "@kit.BasicServicesKit";
import { realIdiom } from "../model/Idiom/RealIdiom";
import Logger from "utils/src/main/ets/utils/Logger"

// 从云数据库获取成语
export class CloudIdiomService {
  // 根据id获取成语
  public static async fetchIdiomById(id: number = 1): Promise<realIdiom | undefined> {

    try {
      let databaseZone = cloudDatabase.zone('Travel');
      let condition = new cloudDatabase.DatabaseQuery(Idiom);

      // 设置查询条件：分页查询
      condition.equalTo('id', id).limit(1)

      return new Promise((resolve, reject) => {
        databaseZone.query(condition, (err: BusinessError, IdiomArray: Idiom[]) => {
          if (err) {
            console.error(`查询失败，错误代码: ${err.code}, 错误信息: ${err.message}`);
            reject(err);
          } else {
            console.info(`查询成功，结果: ${JSON.stringify(IdiomArray)}`);

            let real: realIdiom = new realIdiom()
            real.id = IdiomArray[0].id
            real.word = IdiomArray[0].word
            real.abbr = IdiomArray[0].abbr

            // 尝试解析JSON数据，并处理可能的错误
            try {
              real.data = JSON.parse(IdiomArray[0].data);
            } catch (parseError) {
              console.error(`数据解析失败，错误信息: ${parseError.message}`);
              reject(parseError);
              return;
            }

            resolve(real);
          }
        });
      });
    } catch (err) {
      console.error(`捕获到错误: ${err.message}`);
      return undefined;
    }
  }

  //根据字符串搜索成语
  public static async fetchIdiomByWord(word: string): Promise<realIdiom | undefined> {
    try {
      let databaseZone = cloudDatabase.zone('Travel');
      let condition = new cloudDatabase.DatabaseQuery(Idiom);

      // 设置查询条件：分页查询
      condition.contains('word', word).limit(1)

      return new Promise((resolve, reject) => {
        databaseZone.query(condition, (err: BusinessError, IdiomArray: Idiom[]) => {
          if (err) {
            console.error(`查询失败，错误代码: ${err.code}, 错误信息: ${err.message}`);
            reject(err);
          } else {
            console.info(`查询成功，结果: ${JSON.stringify(IdiomArray)}`);

            let real: realIdiom = new realIdiom()
            real.id = IdiomArray[0].id
            real.word = IdiomArray[0].word
            real.abbr = IdiomArray[0].abbr

            // 尝试解析JSON数据，并处理可能的错误
            try {
              real.data = JSON.parse(IdiomArray[0].data);
            } catch (parseError) {
              console.error(`数据解析失败，错误信息: ${parseError.message}`);
              reject(parseError);
              return;
            }

            resolve(real);
          }
        });
      });
    } catch (err) {
      console.error(`捕获到错误: ${err.message}`);
      return undefined;
    }
  }

  // 随机获取一个成语
  public static async fetchIdiomByRandom(): Promise<realIdiom> {
    const totalIdioms = 49000; // 成语在数据库的数量
    let attempts = 0;
    const maxAttempts = 10; // 最大尝试次数，防止无限循环

    while (attempts < maxAttempts) {
      let rand: number = Math.floor(Math.random() * totalIdioms) + 1;
      let temp: realIdiom | undefined = await CloudIdiomService.fetchIdiomById(rand);

      if (temp && temp.word.length === 4) {
        return temp;
      }

      attempts++;
    }

    throw new Error("无法找到有效的成语");
  }

  // 判断传入的字符串是否是成语
  public static async isIdiom(word: string): Promise<boolean> {
    // 检查字符串长度是否为4
    if (word.length !== 4) {
      return false;
    }

    try {
      let databaseZone = cloudDatabase.zone('Travel');
      let condition = new cloudDatabase.DatabaseQuery(Idiom);

      // 设置查询条件：精确匹配成语
      condition.equalTo('word', word).limit(1);

      return new Promise((resolve, reject) => {
        databaseZone.query(condition, (err: BusinessError, IdiomArray: Idiom[]) => {
          if (err) {
            console.error(`查询失败，错误代码: ${err.code}, 错误信息: ${err.message}`);
            reject(err);
          } else {
            console.info(`查询成功，结果: ${JSON.stringify(IdiomArray)}`);

            // 如果查询结果不为空，则说明该成语存在
            const isIdiom = IdiomArray.length > 0;
            resolve(isIdiom);
          }
        });
      });
    } catch (err) {
      console.error(`捕获到错误: ${err.message}`);
      return false;
    }
  }


  // 根据首字符获取成语
  public static async fetchIdiomByFirstChar(firstChar: string): Promise<realIdiom | undefined> {
    if (firstChar.length !== 1) {
      throw new Error("输入的字符长度必须为1");
    }

    try {
      let databaseZone = cloudDatabase.zone('Travel');
      let condition = new cloudDatabase.DatabaseQuery(Idiom);

      // 设置查询条件：以首字符开头，且成语长度为4，限制返回5个结果
      condition.beginsWith('word', firstChar).limit(5);

      return new Promise((resolve, reject) => {
        databaseZone.query(condition, (err: BusinessError, IdiomArray: Idiom[]) => {
          if (err) {
            console.error(`查询失败，错误代码: ${err.code}, 错误信息: ${err.message}`);
            reject(err);
          } else {
            console.info(`查询成功，结果: ${JSON.stringify(IdiomArray)}`);

            if (IdiomArray.length === 0) {
              resolve(undefined);
            } else {
              // 过滤出长度为4的成语
              const validIdioms = IdiomArray.filter(idiom => idiom.word.length === 4);

              if (validIdioms.length === 0) {
                resolve(undefined);
              } else {
                // 从过滤后的成语中随机选择一个
                const randomIndex = Math.floor(Math.random() * validIdioms.length);
                const randomIdiom = validIdioms[randomIndex];

                let real: realIdiom = new realIdiom();
                real.id = randomIdiom.id;
                real.word = randomIdiom.word;
                real.abbr = randomIdiom.abbr;

                // 尝试解析JSON数据，并处理可能的错误
                try {
                  real.data = JSON.parse(randomIdiom.data);
                } catch (parseError) {
                  console.error(`数据解析失败，错误信息: ${parseError.message}`);
                  reject(parseError);
                  return;
                }

                resolve(real);
              }
            }
          }
        });
      });
    } catch (err) {
      console.error(`捕获到错误: ${err.message}`);
      return undefined;
    }
  }
}



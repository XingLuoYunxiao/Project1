import { cloudDatabase } from "@kit.CloudFoundationKit";
import { Idiom } from "../../../model/Idiom/Idiom";
import { BusinessError } from "@kit.BasicServicesKit";
import { realIdiom } from "../../../model/Idiom/RealIdiom";
import Logger from "utils/src/main/ets/utils/Logger"

// 从云数据库获取成语
export class getIdiomFormCloud {
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
}



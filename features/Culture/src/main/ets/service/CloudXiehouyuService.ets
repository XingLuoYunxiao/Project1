import { cloudDatabase } from "@kit.CloudFoundationKit";
import { Idiom } from "../model/Idiom/Idiom";
import { BusinessError } from "@kit.BasicServicesKit";
import Logger from "utils/src/main/ets/utils/Logger"
import { Xiehouyu } from "../model/Xiehouyu";

// 从云数据库获取成语
export class CloudXiehouyuService {
  // 根据id获取歇后语
  public static async fetchXiehouyuById(id: number = 1): Promise<Xiehouyu | undefined> {

    try {
      let databaseZone = cloudDatabase.zone('Travel');
      let condition = new cloudDatabase.DatabaseQuery(Xiehouyu);

      // 设置查询条件：分页查询
      condition.equalTo('id', id).limit(1)

      return new Promise((resolve, reject) => {
        databaseZone.query(condition, (err: BusinessError, XieArray: Xiehouyu[]) => {
          if (err) {
            console.error(`查询失败，错误代码: ${err.code}, 错误信息: ${err.message}`);
            reject(err);
          } else {
            console.info(`查询成功，结果: ${JSON.stringify(XieArray)}`);


            resolve(XieArray[0]);
          }
        });
      });
    } catch (err) {
      console.error(`捕获到错误: ${err.message}`);
      return undefined;
    }
  }
}



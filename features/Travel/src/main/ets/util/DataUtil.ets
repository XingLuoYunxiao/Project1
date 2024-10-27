import { common } from '@kit.AbilityKit';
import { util } from '@kit.ArkTS';

export class DataUtil {

  static async readJsonFromRawFile<T>(fileName: string): Promise<T[]> {
    return new Promise(async (resolve, reject) => {
      try {
        let context = getContext() as common.UIAbilityContext;
        // 使用resourceManager获取rawfile内容
        const rawFileContent = await context.resourceManager.getRawFileContent(fileName);

        // 创建TextDecoder实例，用于解码UTF-8编码的数据
        const textDecoder = util.TextDecoder.create('utf-8', { ignoreBOM: true });

        // 解码rawFileContent，转换为字符串
        const decodedString = textDecoder.decodeToString(rawFileContent, { stream: false });

        // 使用JSON.parse将字符串转换为对象
        const dataObject: T[] = JSON.parse(decodedString);

        resolve(dataObject);
      } catch (error) {
        console.error('Error reading JSON from raw file:', error)
        reject(error);
      }
    })
  }

}
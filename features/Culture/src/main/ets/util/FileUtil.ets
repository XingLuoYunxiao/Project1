import { common } from "@kit.AbilityKit";
import { util } from "@kit.ArkTS";
import { BusinessError } from '@kit.BasicServicesKit';

export class cultureFileUtil {
  /**
   * 从资源文件中读取 JSON 并解析为数组
   * @param fileName 资源文件名
   * @returns 解析后的数组
   */
  static async getDataFromRawfile<T>(fileName: string): Promise<T[]> {
    return new Promise((resolve, reject) => {
      try {
        let context = getContext() as common.UIAbilityContext;
        context.resourceManager.getRawFileContent(fileName, (error: BusinessError, value: Uint8Array) => {
          if (error != null) {
            console.error("Error while reading file: " + error);
            reject(error);
          } else {
            let rawFile = value;

            let textDecoderOptions: util.TextDecoderOptions = { ignoreBOM: true };
            let textDecoder = util.TextDecoder.create("utf-8", textDecoderOptions);
            let result = textDecoder.decodeWithStream(rawFile, { stream: false });
            console.log(result);

            let dataArr: T[] = JSON.parse(result);
            resolve(dataArr);
          }
        });
      } catch (error) {
        let code = (error as BusinessError).code;
        let message = (error as BusinessError).message;
        console.error(`Failed to get raw file content, error code: ${code}, message: ${message}.`);
        reject(error);
      }
    });
  }
}

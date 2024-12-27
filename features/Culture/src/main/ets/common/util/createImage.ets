import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { CommonConstants } from '../constants/commonConstants';

// 定义响应数据的接口
interface GeneratedTypeLiteralInterface_1 {
  url: string;
}

interface ApiResponse {
  created: number;
  data: GeneratedTypeLiteralInterface_1[];
}

export class CreateImage {
  static ZhiPuImage(prompt: string): Promise<string> {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();

      httpRequest.request(
        CommonConstants.ZhiPuCreateImageURL,
        {
          method: http.RequestMethod.POST,
          extraData: JSON.stringify({
            model: CommonConstants.CreateImageModelCode,
            prompt: prompt // 使用传入的prompt参数
          }),
          expectDataType: http.HttpDataType.STRING,
          usingCache: true,
          priority: 1,
          header: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + CommonConstants.ZhiPuKey
          },
          readTimeout: 60000,
          connectTimeout: 60000,
          usingProtocol: http.HttpProtocol.HTTP1_1,
          usingProxy: false,
        },

        (err: BusinessError, data: http.HttpResponse) => {
          httpRequest.off('headersReceive');
          httpRequest.destroy();

          if (!err) {
            if (typeof data.result === 'string') {
              const response: ApiResponse = JSON.parse(data.result);
              console.info('Result:', response);
              console.info('Image URL:', response.data[0].url);
              resolve(response.data[0].url); // 成功时返回URL
            } else {
              console.error('Unexpected result type:', typeof data.result);
              reject(new Error('Unexpected result type'));
            }
          } else {
            console.info('error:', JSON.stringify(err));
            reject(new Error(JSON.stringify(err))); // 抛出错误
          }
        }
      );
    });
  }
}

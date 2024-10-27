import http from '@ohos.net.http';
import util from '@ohos.util';


export interface StreamResponse2{
  choices: Array<{
    delta: {
      role: string;
      content: string;
    };
    index: number;
  }>;

}


export class HttpGet{
  private static travelPassword:string = 'MvZBmiYOGqZwMwImGcDs:RnzZhRIwimchQTzsnMss'
  private static useTravelModel:string = 'generalv3.5';
  private static travelUrl:string = 'https://spark-api-open.xf-yun.com/v1/chat/completions';
  private static travelTemplate = '请按照下面模板回答，路线需要具体（至少10个具体景点）：\n' +
    '**路线方案**\n' +
    '**路线方案一**：具体景点->具体景点->具体景点->具体景点->具体景点->具体景点->具体景点->\n' +
    '**路线方案二**：\n' +
    '**路线方案三**：\n' +
    '\n' +
    '**对比说明**：\n' +
    '**方案一**：\n' +
    '**方案二**：\n' +
    '**方案三**：\n' +
    '\n' +
    '**推荐路径 方案**：'


  /*
    static async travelDetailGet(context:string): Promise<string>{
      let httpRequest = http.createHttp();
      try {
        let response = await httpRequest.request(
          HttpGet.travelUrl,

          {
            method: http.RequestMethod.POST,
            header: {
              'Content-Type': 'application/json',
              'Authorization': `Bearer ${HttpGet.travelPassword}`
            },
            extraData:{
              "model": HttpGet.useTravelModel,
              "messages": [
                {
                  "role": "user",
                  "content": `${context}`
                }
              ],
              //"stream": true
            }
          }
        );
        console.log("TagTest ", response.responseCode + " " + response.result)
        if (response.responseCode === 200) {
          let responseData = JSON.parse(response.result.toString())
          let streamResponse = new StreamResponse(responseData.choices)
          console.log("TagTest ", streamResponse.choices[0].message.content)
          return streamResponse.choices[0].message.content
        } else {
          throw new Error(`HTTP request failed with status ${response.responseCode}`);
        }
        }catch (error){
        console.log(error)
      } finally {
        httpRequest.destroy();
      }
      return "error"
    }
  */
  //使用流式请求传输方式
  static async travelDetailGet(context:string, onUpdate: (chunk: string) => void): Promise<string>{
    let fullContent = '';
    let httpRequest = http.createHttp();
    httpRequest.on("dataReceive", (data:ArrayBuffer) => {
      let textDecoderOptions: util.TextDecoderOptions = {
        fatal: false,
        ignoreBOM : true
      }
      let decodeToStringOptions: util.DecodeToStringOptions = {
        stream: true
      }
      let textDecoder = util.TextDecoder.create('utf-8', textDecoderOptions);
      let retStr = textDecoder.decodeToString(new Uint8Array(data), decodeToStringOptions);

      const lines = retStr.split('\n');

      for (const line of lines)
      {
        if (line.trim().startsWith('data: '))
        {
          const jsonData = line.trim().substring(5);

          try {
            const parsedData: StreamResponse2 = JSON.parse(jsonData);
            if (parsedData.choices && parsedData.choices.length > 0)
            {
              const content = parsedData.choices[0].delta.content;
              if (content)
              {
                fullContent += content;
                console.log('Received content:', content);
                onUpdate(content);//调用回调函数，更新UI
              }
            }
          }catch (e)
          {
            console.log("HttpGet error " + e)
          }

        }
      }
    });

    try {
      let response = await httpRequest.requestInStream(
        HttpGet.travelUrl,

        {
          method: http.RequestMethod.POST,
          header: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${HttpGet.travelPassword}`
          },
          extraData:{
            "model": HttpGet.useTravelModel,

            "max_tokens": 1024,
            "top_k": 4,
            "temperature": 0.5,
            "messages": [
              {
                "role": "system",
                "content": "你是一个专业的旅游家,请根据我给出的具体游玩景点，给出游玩景点内部景点的路径规划，给出3种不同的各具特色的路径方案，先直接给出三种路径方案（不要讲解），将三种方案按序号排序。然后对三种方案进行对比，说明为什么要选择这个方案。不要对内部景点进行讲解，除非我的内容要求讲解。"
              },
              {
                "role": "user",
                "content": `${context};${this.travelTemplate}`
              }
            ],
            "stream": true
          }
        }
      );
      console.log("TagTest ", response.toString())
      if (response.toString() === '200') {
        return fullContent;
      } else {
        throw new Error(`HTTP request failed with status ${response.toString()}`);
      }
    }catch (error){
      console.log(error)
    } finally {
      httpRequest.off("dataReceive");
      httpRequest.destroy();
    }
    return "error"
  }
}



import { IChat, Info } from 'uicomponents';
import { http } from '@kit.NetworkKit';
import { util } from '@kit.ArkTS';
import { StreamResponse2 } from 'utils';


export class TravelChat extends IChat {
  id: number;
  protected messages: Array<Info>;

  //标志数据接收完毕
  isEnd: boolean = false;

  private static travelPassword:string = 'MvZBmiYOGqZwMwImGcDs:RnzZhRIwimchQTzsnMss'
  private static useTravelModel:string = 'generalv3.5';
  private static travelUrl:string = 'https://spark-api-open.xf-yun.com/v1/chat/completions';
  private static travelTemplate = '请按照下面模板回答(纯文本格式)，路线需要具体，推荐路径需要有理由（根据该景点，给出至少10个该景点的具体内部景点的游玩路线，入口和出口根据实际路径给出）：\n' +
    '路线方案\n' +
    '路线方案一：入口名称->具体景点->具体景点->具体景点->具体景点->具体景点->具体景点->具体景点->...->出口名称\n' +
    '路线方案二：\n' +
    '路线方案三：\n' +
    '\n' +
    '对比说明：\n' +
    '对比方案一：\n' +
    '对比方案二：\n' +
    '对比方案三：\n' +
    '\n' +
    '推荐路径 方案：（这里是具体理由）'

  constructor(id: number, messages: Array<Info>) {
    super();
    this.id = id;
    this.messages = messages;
  }

  //流式返回
  async getData(content: string, onUpdate: (chunk: string) => void): Promise<string>{
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

    httpRequest.on("dataEnd", () => {
      console.log("Data end");
      return fullContent;
    })

    try {
      let response = await httpRequest.requestInStream(
        TravelChat.travelUrl,

        {
          method: http.RequestMethod.POST,
          header: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${TravelChat.travelPassword}`
          },
          extraData:{
            "model": TravelChat.useTravelModel,

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
                "content": `${content};${TravelChat.travelTemplate}`
              }
            ],
            "stream": true
          }
        }
      );
      console.log("TagTest ", response.toString())
      if (response.toString() !== '200') {
        throw new Error(`HTTP request failed with status ${response.toString()}`);
      }
    }catch (error){
      console.log(error)
    } finally {
      httpRequest.off("dataReceive");
      httpRequest.off("dataEnd");
      httpRequest.destroy();
    }
    return fullContent
  }

  async getTravelDetail(content:string): Promise<string>{
    let httpRequest = http.createHttp();
    try {
      let response = await httpRequest.request(
        TravelChat.travelUrl,
        {
          method: http.RequestMethod.POST,
          header: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${TravelChat.travelPassword}`
          },
          extraData:{
            "model": TravelChat.useTravelModel,

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
                "content": `${content};${TravelChat.travelTemplate}`
              }
            ],
            "stream": false
          }
        }
      );
      console.log("TagTest ", response.responseCode + " " + response.result)
      if (response.responseCode === 200) {
        let responseData = JSON.parse(response.result.toString()).choices[0].message.content as string
        //let streamResponse = new StreamResponse(responseData.choices)
        console.log("HttpRequestData TagTest ", responseData)
        return responseData
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

  addMessage(message: string): void {
    throw new Error('Method not implemented.');
  }

  getMessage(index: number): string {
    throw new Error('Method not implemented.');
  }
}
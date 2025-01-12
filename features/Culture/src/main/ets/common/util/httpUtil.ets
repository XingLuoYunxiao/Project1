import { http } from "@kit.NetworkKit";
import { util } from "@kit.ArkTS";
import { PromptWords } from "../../model/promptWords";
import { ChatMsg, ROLE } from "../../model/ChatMassageModel";

// 定义接口 Delta 和 Choice
interface Delta {
  role: string;
  content: string;
}

interface Choice {
  delta: Delta;
  index: number;
}

// 定义接口 StreamResponseInterface
interface StreamResponseInterface {
  choices: Array<Choice>;
}

class StreamResponse implements StreamResponseInterface {
  choices: Array<Choice>;

  constructor(choices: Array<Choice>) {
    this.choices = choices;
  }
}

export class httpToAI {
  // 定义静态属性Password，保存API调用所需的认证密钥。
  private static Password: string = 'MvZBmiYOGqZwMwImGcDs:RnzZhRIwimchQTzsnMss';
  // 定义静态属性useTravelModel，指定使用的AI模型版本。
  private static useTravelModel: string = 'generalv3.5';
  // 定义静态属性Url，保存向AI服务发起请求的目标地址。
  private static Url: string = 'https://spark-api-open.xf-yun.com/v1/chat/completions';

  // 定义公共静态异步方法askAI，接收对话上下文、提示词对象和更新UI的回调函数作为参数。
  public static async askAI(
    context: string, // 用户输入或上下文信息
    prompt: PromptWords, // 包含系统提示词的对象
    onUpdate: (chunk: string) => void // 当接收到新的内容时用于更新UI的回调函数
  ) {
    let fullContent = ''; // 用于累积从服务器接收到的所有文本内容

    // 创建一个新的HTTP请求实例
    let httpRequest = http.createHttp();

    // 注册事件监听器，当接收到数据时触发
    httpRequest.on("dataReceive", (data: ArrayBuffer) => {
      // 初始化文本解码选项，不抛出错误且忽略BOM
      let textDecoderOptions: util.TextDecoderOptions = {
        fatal: false,
        ignoreBOM: true
      };

      // 初始化解码为字符串的选项，启用流模式
      let decodeToStringOptions: util.DecodeToStringOptions = {
        stream: true
      };

      // 创建UTF-8编码的文本解码器
      let textDecoder = util.TextDecoder.create('utf-8', textDecoderOptions);

      // 将ArrayBuffer转换为字符串并使用换行符分割成数组
      let retStr = textDecoder.decodeToString(new Uint8Array(data), decodeToStringOptions);
      const lines = retStr.split('\n');

      // 遍历每一行数据
      for (const line of lines) {
        if (line.trim().startsWith('data: ')) { // 检查行是否以'data: '开始
          const jsonData = line.trim().substring(5); // 去掉前缀'data: '

          try {
            // 解析JSON格式的数据
            const parsedData: StreamResponse = JSON.parse(jsonData);

            // 检查是否存在choices并且至少有一个元素
            if (parsedData.choices && parsedData.choices.length > 0) {

              // 获取当前选择的内容（如果有）
              const content = parsedData.choices[0].delta.content;
              if (content) {
                fullContent += content; // 累积接收到的内容
                console.log('Received content:', content); // 打印日志
                onUpdate(content); // 调用回调函数更新UI
              }
            }
          } catch (e) {
            console.log("HttpGet error " + e); // 捕获并打印解析错误
          }
        }
      }
    });

    //
    try {
      // 发送POST请求到AI服务，包含必要的头部信息和消息体
      let response = await httpRequest.requestInStream(
        httpToAI.Url,
        {
          method: http.RequestMethod.POST,
          header: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${httpToAI.Password}` // 使用Bearer Token认证
          },
          extraData: {
            model: httpToAI.useTravelModel, // 指定使用的AI模型
            max_tokens: 1024, // 设置最大返回token数量
            top_k: 4, // 设置top-k采样参数
            temperature: 0.5, // 设置生成文本的随机性温度值
            messages: [
              {
                role: "system",
                content: prompt.prompt // 系统提示词
              },
              {
                role: "user",
                content: context // 用户提供的上下文信息
              }
            ],
            stream: true // 启用流式响应
          }
        }
      );

      console.log("TagTest ", response.toString()); // 打印响应状态

      // 如果响应状态是200，表示请求成功
      if (response.toString() === '200') {
        return fullContent; // 返回累积的全部内容
      } else {
        throw new Error(`HTTP request failed with status ${response.toString()}`); // 抛出错误
      }
    } catch (error) {
      console.log(error); // 打印任何发生的错误
    } finally {
      httpRequest.off("dataReceive"); // 移除事件监听器
      httpRequest.destroy(); // 销毁HTTP请求实例
    }

    return "error"; // 如果发生错误，返回"error"
  }


  // public static async TalkToAI(
  //   meg: ChatMsg,
  //   onUpdate: (chunk: string) => void, // 当接收到新的内容时用于更新UI的回调函数
  //   id?: string,
  //   sid?: string
  // ) {
  //   let fullContent = ''; // 用于累积从服务器接收到的所有文本内容
  //   // 创建一个新的HTTP请求实例
  //   let httpRequest = http.createHttp();
  //
  //   // 注册事件监听器，当接收到数据时触发
  //   httpRequest.on("dataReceive", (data: ArrayBuffer) => {
  //     // 初始化文本解码选项，不抛出错误且忽略BOM
  //     let textDecoderOptions: util.TextDecoderOptions = {
  //       fatal: false,
  //       ignoreBOM: true
  //     };
  //
  //     // 初始化解码为字符串的选项，启用流模式
  //     let decodeToStringOptions: util.DecodeToStringOptions = {
  //       stream: true
  //     };
  //
  //     // 创建UTF-8编码的文本解码器
  //     let textDecoder = util.TextDecoder.create('utf-8', textDecoderOptions);
  //
  //     // 将ArrayBuffer转换为字符串并使用换行符分割成数组
  //     let retStr = textDecoder.decodeToString(new Uint8Array(data), decodeToStringOptions);
  //     const lines = retStr.split('\n');
  //
  //     // 遍历每一行数据
  //     for (const line of lines) {
  //       if (line.trim().startsWith('data: ')) { // 检查行是否以'data: '开始
  //         const jsonData = line.trim().substring(5); // 去掉前缀'data: '
  //
  //         try {
  //           // 解析JSON格式的数据
  //           const parsedData: StreamResponse = JSON.parse(jsonData);
  //
  //           // 检查是否存在choices并且至少有一个元素
  //           if (parsedData.choices && parsedData.choices.length > 0) {
  //
  //             // 获取当前选择的内容（如果有）
  //             const content = parsedData.choices[0].delta.content;
  //             if (content) {
  //               fullContent += content; // 累积接收到的内容
  //               console.log('Received content:', content); // 打印日志
  //               onUpdate(content); // 调用回调函数更新UI
  //             }
  //           }
  //         } catch (e) {
  //           console.log("HttpGet error " + e); // 捕获并打印解析错误
  //         }
  //       }
  //     }
  //   });
  //
  //   //
  //   try {
  //     // 发送POST请求到AI服务，包含必要的头部信息和消息体
  //     let response = await httpRequest.requestInStream(
  //       httpToAI.Url,
  //       {
  //         method: http.RequestMethod.POST,
  //         header: {
  //           'Content-Type': 'application/json',
  //           'Authorization': `Bearer ${httpToAI.Password}` // 使用Bearer Token认证
  //         },
  //         extraData: {
  //           model: httpToAI.useTravelModel, // 指定使用的AI模型
  //           max_tokens: 1024, // 设置最大返回token数量
  //           top_k: 4, // 设置top-k采样参数
  //           temperature: 0.5, // 设置生成文本的随机性温度值
  //           messages: [
  //             {
  //               role: meg.role,
  //               content: meg.content // 系统提示词
  //             }
  //           ],
  //           stream: true // 启用流式响应
  //         }
  //       }
  //     );
  //
  //     console.log("TagTest ", response.toString()); // 打印响应状态
  //
  //     // 如果响应状态是200，表示请求成功
  //     if (response.toString() === '200') {
  //       return response; // 返回累积的全部内容
  //     } else {
  //       throw new Error(`HTTP request failed with status ${response.toString()}`); // 抛出错误
  //     }
  //   } catch (error) {
  //     console.log(error); // 打印任何发生的错误
  //   } finally {
  //     httpRequest.off("dataReceive"); // 移除事件监听器
  //     httpRequest.destroy(); // 销毁HTTP请求实例
  //   }
  //
  //   return "error"; // 如果发生错误，返回"error"
  // }
}



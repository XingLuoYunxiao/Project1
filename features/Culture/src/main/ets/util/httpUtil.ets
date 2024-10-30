import { http } from "@kit.NetworkKit";
import { util } from "@kit.ArkTS";
import { PromptWords } from "../model/promptWords";

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
  private static Password: string = 'MvZBmiYOGqZwMwImGcDs:RnzZhRIwimchQTzsnMss';
  private static useTravelModel: string = 'generalv3.5';
  private static Url: string = 'https://spark-api-open.xf-yun.com/v1/chat/completions';

  public static async askAI(
    context: string,
    prompt: PromptWords,
    onUpdate: (chunk: string) => void
  ) {
    let fullContent = '';
    let httpRequest = http.createHttp();

    httpRequest.on("dataReceive", (data: ArrayBuffer) => {
      let textDecoderOptions: util.TextDecoderOptions = {
        fatal: false,
        ignoreBOM: true
      };
      let decodeToStringOptions: util.DecodeToStringOptions = {
        stream: true
      };
      let textDecoder = util.TextDecoder.create('utf-8', textDecoderOptions);
      let retStr = textDecoder.decodeToString(new Uint8Array(data), decodeToStringOptions);

      const lines = retStr.split('\n');

      for (const line of lines) {
        if (line.trim().startsWith('data: ')) {
          const jsonData = line.trim().substring(5);

          try {
            const parsedData: StreamResponse = JSON.parse(jsonData);
            if (parsedData.choices && parsedData.choices.length > 0) {
              const content = parsedData.choices[0].delta.content;
              if (content) {
                fullContent += content;
                console.log('Received content:', content);
                onUpdate(content); //调用回调函数，更新UI
              }
            }
          } catch (e) {
            console.log("HttpGet error " + e);
          }
        }
      }
    });

    //
    try {
      let response = await httpRequest.requestInStream(
        httpToAI.Url,
        {
          method: http.RequestMethod.POST,
          header: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${httpToAI.Password}`
          },
          extraData: {
            model: httpToAI.useTravelModel,
            max_tokens: 1024,
            top_k: 4,
            temperature: 0.5,
            messages: [
              {
                role: "system",
                content: prompt.prompt
              },
              {
                role: "user",
                content: context
              }
            ],
            stream: true
          }
        }
      );
      console.log("TagTest ", response.toString());
      if (response.toString() === '200') {
        return fullContent;
      } else {
        throw new Error(`HTTP request failed with status ${response.toString()}`);
      }
    } catch (error) {
      console.log(error);
    } finally {
      httpRequest.off("dataReceive");
      httpRequest.destroy();
    }
    return "error";
  }
}

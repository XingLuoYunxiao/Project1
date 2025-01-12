// public static async TalkToGLM_4(msg: ChatMsg, request_id: number, onUpdate: (chunk: string) => void) {
//   let fullContent = '';
//   let httpRequest = http.createHttp();
//
//
//   httpRequest.on("dataReceive", (data: ArrayBuffer) => {
//     let textDecoderOptions: util.TextDecoderOptions = {
//       fatal: false,
//       ignoreBOM: true
//     };
//     let decodeToStringOptions: util.DecodeToStringOptions = {
//       stream: true
//     };
//     let textDecoder = util.TextDecoder.create('utf-8', textDecoderOptions);
//     let retStr = textDecoder.decodeToString(new Uint8Array(data), decodeToStringOptions);
//
//     const lines = retStr.split('\n');
//
//     for (const line of lines) {
//       if (line.trim().startsWith('data: ')) {
//         const jsonData = line.trim().substring(5);
//
//         try {
//           const parsedData: StreamResponse = JSON.parse(jsonData);
//           if (parsedData.choices && parsedData.choices.length > 0) {
//             const content = parsedData.choices[0].delta.content;
//             if (content) {
//               fullContent += content;
//               console.log('Received content:', content);
//               onUpdate(content); //调用回调函数，更新UI
//             }
//           }
//         } catch (e) {
//           console.log("HttpGet error " + e);
//         }
//       }
//     }
//   });
//
//   try {
//     // 发送POST请求到AI服务，包含必要的头部信息和消息体
//     let response = await httpRequest.requestInStream(
//       CommonConstants.ZhiPu_GLM_4,
//       {
//         method: http.RequestMethod.POST,
//         header: {
//           'Content-Type': 'application/json',
//           'Authorization': `Bearer ${httpToAI.Password}` // 使用Bearer Token认证
//         },
//         extraData: {
//           model: "glm-4-flash", // 指定使用的AI模型
//           max_tokens: 1024, // 设置最大返回token数量
//           top_k: 4, // 设置top-k采样参数
//           temperature: 0.5, // 设置生成文本的随机性温度值
//           messages: [
//             {
//               role: msg.role,
//               content: msg.message // 系统提示词
//             },
//
//           ],
//           request_id: request_id,
//           stream: true // 启用流式响应
//         }
//       }
//     );
//
//     console.log("TagTest ", response.toString()); // 打印响应状态
//
//     // 如果响应状态是200，表示请求成功
//     if (response.toString() === '200') {
//       return fullContent; // 返回累积的全部内容
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
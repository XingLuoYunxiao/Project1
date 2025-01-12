import { async } from "@hw-agconnect/cloud/src/main/ets/storage/upload/task";
import { AxiosError, AxiosResponse } from "@ohos/axios";
import { CommonConstants } from "../common/constants/commonConstants";
import { AIMsg, ChatMsg, ROLE } from "../model/ChatMassageModel";
import { apiRequestData, axiosInstance, TalkAI_axiosInstance } from "./api";

interface Messages {
  role: ROLE,
  content: string
}

interface ResponseFormat {
  type: 'text' | 'json_object'; // 指定模型输出格式
}

interface RequestParams {
  model: 'lite' | 'generalv3' | 'pro-128k' | 'generalv3.5' | 'max-32k' | '4.0Ultra'; // 指定访问的模型版本
  user?: string; // 用户的唯一id
  messages: Messages[]; // 输入数组
  temperature?: number; // 核采样阈值，取值范围[0, 2]，默认值1.0
  top_p?: number; // 生成过程中核采样方法概率阈值，取值范围(0, 1]，默认值1
  top_k?: number; // 从k个中随机选择一个(非等概率)，取值范围[1, 6]，默认值4
  presence_penalty?: number; // 重复词的惩罚值，取值范围[-2.0,2.0]，默认0
  frequency_penalty?: number; // 频率惩罚值，取值范围[-2.0,2.0]，默认0
  stream?: boolean; // 是否流式返回结果，默认是false
  max_tokens?: number; // 模型回答的tokens的最大长度，根据模型版本不同而不同
  response_format?: ResponseFormat; // 指定模型的输出格式
  tool_calls_switch?: boolean; // 设置为true时，触发function call结果中tool_calls以数组格式返回，默认为 false，则以json格式返回
  tool_choice?: 'auto' | 'none' | 'required'; // 设置模型自动选择调用的函数
}

interface FunctionArguments {
  name: string; // 模型生成的应调用的函数名称
  arguments: string; // 模型生成的函数调用参数的JSON格式
  id: string; // 命中函数的唯一标识符
  type: 'function'; // 模型调用的工具类型
}

interface ChoiceMessage {
  role: string; // 大模型的角色
  content: string; // 大模型输出的内容
}

interface Choice {
  message: ChoiceMessage; // 大模型结果
  index: number; // 大模型的结果序号，在多候选中使用
}

interface Usage {
  prompt_tokens: number; // 用户输入信息，消耗的token数量
  completion_tokens: number; // 大模型输出信息，消耗的token数量
  total_tokens: number; // 用户输入+大模型输出，总的token数量
}

export interface ResponseParams {
  code: number; // 错误码：0表示成功，非0表示错误
  message: string; // 错误码的描述信息
  sid: string; // 本次请求的唯一id
  choices: Choice[]; // 大模型结果的数组
  usage: Usage; // 本次请求消耗的token数量
}


export const TalkTo_XUNFEI_AI = async (msg: AIMsg): Promise<ResponseParams> => {
  const url: string = CommonConstants.AIUrl; // 使用真实的 URL
  const requestData: RequestParams = {
    model: 'generalv3.5',
    max_tokens: 1024, // 设置最大返回token数量
    temperature: 0.5, // 设置生成文本的随机性温度值
    messages: [
      {
        role: msg.role,
        content: msg.content // 系统提示词
      }
    ],
    stream: false // 设置为false，以不启用流式响应
  }

  try {
    // 设置为json类型响应
    const response: AxiosResponse<ResponseParams> = await TalkAI_axiosInstance.post<ResponseParams>(url, requestData);

    return response.data;
  } catch (error) {
    const axiosError: AxiosError = error as AxiosError;
    console.error('请求错误:', axiosError.message);
    throw new Error('询问AI失败:' + axiosError.message); // 抛出错误
  }
}


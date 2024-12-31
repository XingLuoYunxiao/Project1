import axios, { AxiosError, AxiosResponse } from '@ohos/axios';
import { CommonConstants } from '../common/constants/commonConstants';

// 定义响应数据的接口
interface GeneratedTypeLiteralInterface_1 {
  url: string;
}

// 定义 API 响应类型
export interface ApiResponse {
  created: number;
  data: GeneratedTypeLiteralInterface_1[];
}

// 定义请求数据的接口
export interface apiRequestData {
  model: string;
  prompt: string;
}

// 创建 axios 实例
export const axiosInstance = axios.create({
  baseURL: 'https://api.example.com', // 默认的基本 URL
  timeout: 50000, // 超时时间
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ' + CommonConstants.ZhiPuKey, // 替换为实际的 token
  },
});

// 创建 axios 实例
export const TalkAI_axiosInstance = axios.create({
  baseURL: 'https://api.example.com', // 默认的基本 URL
  timeout: 50000, // 超时时间
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ' + CommonConstants.AIPassword, // 替换为实际的 token
  },

});



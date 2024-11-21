import { AxiosError, AxiosResponse } from "@ohos/axios";
import { CommonConstants } from "../common/constants/commonConstants";
import { apiRequestData, ApiResponse, axiosInstance } from "./api";

// ZhiPuImage 函数
export const ZhiPuImage2 = async (prompt: string): Promise<string> => {
  const url: string = CommonConstants.ZhiPuCreateImageURL; // 使用真实的 URL
  const requestData: apiRequestData = {
    model: 'cogview-3-plus',
    prompt: prompt,
  };

  try {
    // 确保 response 变量的类型明确
    const response: AxiosResponse<ApiResponse> = await axiosInstance.post<ApiResponse>(url, requestData);

    // 确保 imageUrl 的类型明确
    const imageUrl: string = response.data.data[0].url; // 获取图片 URL
    console.info('Image URL:', imageUrl);
    return imageUrl; // 返回图片 URL
  } catch (error) {
    const axiosError: AxiosError = error as AxiosError;
    console.error('请求错误:', axiosError.message);
    throw new Error('获取图片失败: ' + axiosError.message); // 抛出错误
  }
};
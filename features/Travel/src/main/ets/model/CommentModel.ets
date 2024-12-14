import { Logger } from '@hw-agconnect/hmcore'
import { Params } from './FuncParams'
import Constants from '../constants/Constants'
import { cloudFunction } from '@kit.CloudFoundationKit'
import { spotComment } from './spotComment'
import { promptAction } from '@kit.ArkUI'


//并发查询评论数据
@Concurrent
export async function loadCommentsData(spotId: number, pageNum: number){
  try{
    let params: Params = {
      type: 'query',
      filter: [
        {spotId: spotId}
      ],
      limit:20,
      pageNum: pageNum
    }
    const res = await cloudFunction.call({ name: 'get-comment-data', data: params})
    let data = res.result
    return JSON.parse(JSON.stringify(data)).data
  } catch (e) {
    Logger.error(Constants.COMMENT_TAG, 'SpotModel loadComments failed', e);
  }
  return []
}

@Concurrent
export async function addCommentData(comment: spotComment): Promise<void> {
  if( !comment.content){
    promptAction.showToast({message: '评论内容不能为空', duration: 2000})
    return
  }
  try{
    let params: Params = {
      type: 'add',
      document: [comment]
    }
    const res = await cloudFunction.call({ name: 'get-comment-data', data: params}).then((data) => {
      if(JSON.parse(JSON.stringify(data.result)).success === true){
        promptAction.showToast({message: '评论成功', duration: 2000})
      }else{
        promptAction.showToast({message: '评论失败', duration: 2000})
      }
    })

  } catch (e) {
    Logger.error(Constants.COMMENT_TAG, 'SpotModel loadComments failed', e);
  }
}

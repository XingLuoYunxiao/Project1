//收藏,浏览记录,更多功能的数据模型
export class CollectHistoryMore {
  id?: number=0;
  title: string='';
  image: ResourceStr='';
  description?: string='';
  category?: string='';
  icon?:ResourceStr='';

}

export const LISTITEM_ARRAY:CollectHistoryMore[] = [
  { image:$r('app.media.account'), title:'消息',icon:$r('app.media.ic_arrow'),description:'Message' },
  { image:$r('app.media.account'),title:'隐私策略',icon:$r('app.media.ic_arrow'),description:'Privacy' },
  { image:$r('app.media.account'),title:'意见反馈',icon:$r('app.media.ic_arrow') ,description:'Advice'},
  { image:$r('app.media.account'), title:'分享好友',icon:$r('app.media.ic_arrow'),description:'Share'}
]


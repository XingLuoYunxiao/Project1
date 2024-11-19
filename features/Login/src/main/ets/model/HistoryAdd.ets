@Observed
class HistoryAdd{
  id: number;
  spotId: number;
  viewTime: Date;  // 假设 viewTime 是字符串类型，存储日期时间
  viewCount: number; // 代表查看次数，假设是数字类型
  type: string;
  userId: string;
  poemId: number;   // 假设 poemId 是数字类型，关联到某个诗歌 ID
  spotname: string;
  spot_img:string;
  isChoose:boolean;

  constructor(
    id: number,
    spotId: number,
    viewTime: Date,
    viewCount: number,
    type: string,
    userId: string,
    poemId: number,
  spotname: string,
  spot_img:string,
    isChoose:boolean
  ) {
    this.id = id;
    this.spotId = spotId;
    this.viewTime = viewTime;
    this.viewCount = viewCount;
    this.type = type;
    this.userId = userId;
    this.poemId = poemId;
    this.spotname=spotname;
    this.spot_img=spot_img;
    this.isChoose=isChoose
  }
}

export {HistoryAdd}
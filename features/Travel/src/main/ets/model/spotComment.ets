import { cloudDatabase } from "@kit.CloudFoundationKit"

export class spotComment extends cloudDatabase.DatabaseObject{
  public id: number | undefined
  public userId: string | undefined
  public spotId: number | undefined
  public content: string | undefined
  // 回复时间
  public replyTime: Date | undefined

  // 回复人的id，-1代表是景点的评论，而不是回复
  public parentId: number | undefined

  public naturalbase_ClassName(): string {
    return 'spotComment';
  }

}
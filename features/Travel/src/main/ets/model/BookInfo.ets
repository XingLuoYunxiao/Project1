import { cloudDatabase } from '@kit.CloudFoundationKit';

class BookInfo extends cloudDatabase.DatabaseObject{
  public naturalbase_ClassName(): string {
    return "BookInfo";
  }
  public id: number | undefined;
  public bookName: string | undefined;
  public author: string | undefined;
  public price: number | undefined;
  public publisher: string | undefined;
  public publishTime: Date | undefined;
}

export { BookInfo };
import { cloudDatabase } from '@kit.CloudFoundationKit';

class Poem extends cloudDatabase.DatabaseObject {
  public numId: number = 0;
  public id: string = '';
  public title: string | undefined;
  public dynasty: string | undefined;
  public writer: string = '';
  public content: string | undefined;
  public type: string | undefined;
  public remark: string | undefined;
  public shangxi: string | undefined;
  public translation: string | undefined;

  public naturalbase_ClassName(): string {
    return 'Poem';
  }
}

export { Poem };

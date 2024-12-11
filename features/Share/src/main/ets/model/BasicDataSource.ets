
export abstract class BasicDataSource<T> implements IDataSource {
  private listeners: DataChangeListener[] = [];

  public abstract totalCount(): number;

  public abstract getData(index: number): T | void;

  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener)
    if (pos >= 0) {
      this.listeners.splice(pos, 1);
    }
  }

  notifyDataReload(): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      listener.onDataReloaded();
    });
  }

  notifyDataAdd(index: number): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      listener.onDataAdd(index);
    })
  }

  notifyDataChange(index: number): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      listener.onDataChange(index);
    })
  }

  notifyDataDelete(index: number): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      listener.onDataDelete(index);
    })
  }

  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      listener.onDataMove(from, to);
    })
  }
}

/**
 * 朋友圈用户数据
 */
export class friendMoment {
  id: string; // 唯一id
  userName: string; // 用户名
  avatar: ResourceStr; // 头像
  text?: string; // 文字
  image?: ResourceStr; // 发布动态图片
  video?: ResourceStr; // 发布动态视频

  constructor(id: string, userName: string, avatar: ResourceStr, text?: string, image?: ResourceStr,
    video?: ResourceStr) {
    this.id = id;
    this.userName = userName;
    this.avatar = avatar;
    if (text !== undefined) {
      this.text = text;
    }
    if (image !== undefined) {
      this.image = image;
    }
    ;
    if (video !== undefined) {
      this.video = video;
    }
  }
}


export class CommentData<T> extends BasicDataSource<T> {
  // 懒加载数据
  private comments: Array<T> = [];

  totalCount(): number {
    return this.comments.length;
  }

  // 获取指定数据项
  getData(index: number): T {
    return this.comments[index];
  }

  pushData(data: T): void {
    this.comments.push(data);
    // 在数组头部添加数据
    this.notifyDataAdd(this.comments.length - 1);
  }

  addDataFirst(data: T): void {
    this.comments.unshift(data);
    // 在数组头部添加数据
    this.notifyDataAdd(0);
  }

  notifyDataDeleteAll(): void {
    this.comments=[]
  }
}
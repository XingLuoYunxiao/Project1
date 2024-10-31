
interface chuci{
  title:string
  section:string
  author:string
  content:string
}

interface shijing{
  title:string
  chapter:string
  section:string
  content:string
}

interface lunyu{
  chapter:string
  paragraphs:string
}

interface shici{
  title:string
  auth:string
  dynasty:string
  content:string
}
interface shishuwujing{
  chapter:string
  paragraphs:string
}


//基础数据源类
export abstract class BasicDataSource<T> implements IDataSource {
  private listeners: DataChangeListener[] = [];
  data:Array<T> =[]


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

  public totalCount(): number {
    return this.data.length;
  }

  public addData(index: number, data: T): void {
    this.data.splice(index, 0, data);
  }
  public pushData(data: T): void {
    this.data.push(data);
    this.notifyDataAdd(this.data.length - 1);
  }
}


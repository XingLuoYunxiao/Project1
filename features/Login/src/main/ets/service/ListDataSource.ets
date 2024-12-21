class BasicDataSource<T> implements IDataSource{
  private listeners: DataChangeListener[] = [];

  public totalCount(): number {
    return 0;
  }

  public getData(index: number): T | undefined {
    return undefined;
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const position = this.listeners.indexOf(listener);
    if (position >= 0) {
      this.listeners.splice(position, 1);
    }
  }

  notifyDataReload(): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      listener.onDataReloaded();
    })
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

@Observed
export class ListDataSource<T> extends BasicDataSource<T> {
  listData:T[]=[];

  public totalCount(): number {
    return this.listData.length;
  }

  public getData(index: number): T {
    return this.listData[index];
  }

  public pushData(data:T): void {
      this.listData.push(data);
      this.notifyDataAdd(this.listData.length - 1);
  }

  public appendArrayData(addData: Array<T>): void {
    this.listData.push(...addData);
    this.notifyDataReload();
  }

  public deleteData(index: number): void {
    this.listData.splice(index, 1);
    this.notifyDataDelete(index);
  }

  notifyDataDeleteAll(): void {
    this.listData=[]
  }

}
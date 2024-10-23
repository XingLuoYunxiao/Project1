import { DataUtil } from '../util/DataUtil'
import { Spot } from './ISpot'

export class SpotDataSource implements IDataSource{
  private dataArray: Spot[] = []
  private listeners: DataChangeListener[] = []

  constructor(){
    this.loadData()
  }

  async loadData(){
    this.dataArray = await DataUtil.readJsonFromRawFile<Spot>('SpotData.json')
    this.notifyDataReload()
  }


  public getData(index: number) : Spot{
    return this.dataArray[index]
  }

  totalCount(): number {
    return this.dataArray.length
  }

  registerDataChangeListener(listener: DataChangeListener): void{
    if( this.listeners.indexOf( listener) < 0){
      this.listeners.push(listener)
    }
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener)
    if( pos >= 0){
      this.listeners.splice(pos, 1)
    }
  }


  // 通知控制器数据重新加载
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded()
    })
  }

  // 通知控制器数据增加
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index)
    })
  }

  // 通知控制器数据变化
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index)
    })
  }

  // 通知控制器数据删除
  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index)
    })
  }

  // 通知控制器数据位置变化
  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to)
    })
  }

  //通知控制器数据批量修改
  notifyDatasetChange(operations: DataOperation[]): void {
    this.listeners.forEach(listener => {
      listener.onDatasetChange(operations);
    })
  }

  public addLastItem(): void {
    let newItem = this.AddNewItem(this.dataArray.length)
    this.dataArray.splice(this.dataArray.length, 0, newItem)
    this.notifyDataAdd(this.dataArray.length - 1)
  }



  AddNewItem(index: number): Spot {
    let randomNumber: number = getRandomInt(1,20)
    return this.dataArray[randomNumber]
  }

  /* 后边的都可以仿照上面完成，就不一一完成了// 增加数据
  public add1stItem(): void {
    this.dataArray.splice(0, 0, this.dataArray.length)
    this.notifyDataAdd(0)
  }


  // 在指定索引位置增加一个元素
  public addItem(index: number): void {
    this.dataArray.splice(index, 0, this.dataArray.length)
    this.notifyDataAdd(index)
  }

  // 删除第一个元素
  public delete1stItem(): void {
    this.dataArray.splice(0, 1)
    this.notifyDataDelete(0)
  }

  // 删除第二个元素
  public delete2ndItem(): void {
    this.dataArray.splice(1, 1)
    this.notifyDataDelete(1)
  }

  // 删除最后一个元素
  public deleteLastItem(): void {
    this.dataArray.splice(-1, 1)
    this.notifyDataDelete(this.dataArray.length)
  }

  // 在指定索引位置删除一个元素
  public deleteItem(index: number): void {
    this.dataArray.splice(index, 1)
    this.notifyDataDelete(index)
  }

  // 重新加载数据
  public reload(): void {
    this.dataArray.splice(1, 1)
    this.dataArray.splice(3, 2)
    this.notifyDataReload()
  }*/
}

function getRandomInt(min:number, max:number) {
  min = Math.ceil(min); // 向上取整
  max = Math.floor(max); // 向下取整
  return Math.floor(Math.random() * (max - min + 1)) + min; // 包含最大值
}

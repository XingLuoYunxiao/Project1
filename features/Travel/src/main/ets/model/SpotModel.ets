import { Spot } from './Spot';
import Logger from 'utils/src/main/ets/utils/Logger';
import { cloudFunction } from '@kit.CloudFoundationKit';
import { OrderBy, Params } from './FuncParams';
import { BusinessError } from '@kit.BasicServicesKit';
import { promptAction } from '@kit.ArkUI';

const TAG = '[SpotModel]';


export class SpotModel {

  //获取景点数据
  public getAllSpotData(): Promise<Spot[]> {
    // 初始化
    // 初始化
    return new Promise(async (resolve, reject) => {
      try{
        let params: Params = {
          type: 'query',
        }
        const res = await cloudFunction.call({ name: 'get-spot-data', data: params})
        let data = res.result
        resolve(JSON.parse(JSON.stringify(data)).data as Spot[])
        //let result: mySpot[] = await this.database.collection(mySpot).query().get()
        /*let spots = result.map(item => new Spot(item.id, item.name, item.summary, item.category, item.rating,
          {latitude: item.latitude, longitude: item.longitude  }, item.ticketPrice, item.openingHours, item.imageUrl, item.cityCode, item.cityId, item.cityName, item.address));*/
      }catch (e){
        Logger.error(TAG, 'SpotModel getSpotData failed', e);
        reject(e)
      }
    })
  }


  //获取更多的景点数据
  public getSpotData(pageNum: number): Promise<Spot[]> {
    // 初始化
    return new Promise(async (resolve, reject) => {
      try{
        let params: Params = {
          type: 'query',
          limit: 20,
          pageNum: pageNum
        }
        const res = await cloudFunction.call({ name: 'get-spot-data', data: params})
        let data = res.result
        resolve(JSON.parse(JSON.stringify(data)).data as Spot[])
        //let result: mySpot[] = await this.database.collection(mySpot).query().get()
        /*let spots = result.map(item => new Spot(item.id, item.name, item.summary, item.category, item.rating,
          {latitude: item.latitude, longitude: item.longitude  }, item.ticketPrice, item.openingHours, item.imageUrl, item.cityCode, item.cityId, item.cityName, item.address));*/
      }catch (e){
        Logger.error(TAG, 'SpotModel getSpotData failed', e);
        reject(e)
      }
    })
  }

  //获取特定条件的景点数据
  public getSpotDataByCondition(condition: string[] , pageNum: number, orderBy: OrderBy): Promise<Spot[]> {
    // 初始化
    return new Promise(async (resolve, reject) => {
      try{
        let params: Params = {
          type: 'query',
          filter: [
            condition[0] ? {cityName:`${condition[0]}`}: {cityName: '所有'},
            condition[1] ? {category:`${condition[1]}`} : {category: '全部分类'}
          ],
          limit: 20,
          pageNum: pageNum,
          orderBy: orderBy ? orderBy : {field: '', type: null}
        }
        const res = await cloudFunction.call({ name: 'get-spot-data', data: params})
        let data = res.result
        resolve(JSON.parse(JSON.stringify(data)).data as Spot[])
      }catch (e){
        Logger.error(TAG, 'SpotModel getSpotDataByCondition failed', e);
        reject(e)
      }
    })
  }

  //获取附近的景点数据
  public getSpotDataByCityName(condition: string[] ): Promise<Spot[]> {
    // 初始化
    return new Promise(async (resolve, reject) => {
      try{
        let params: Params = {
          type: 'query',
          filter: [
            condition[0] ? {cityName:`${condition[0]}`}: {cityName: '所有'},
            condition[1] ? {category:`${condition[1]}`} : {category: '全部分类'}
          ],
        }
        const res = await cloudFunction.call({ name: 'get-spot-data', data: params})
        let data = res.result
        resolve(JSON.parse(JSON.stringify(data)).data as Spot[])
      }catch (e){
        Logger.error(TAG, 'SpotModel getSpotDataByCondition failed', e);
        reject(e)
      }
    })
  }

  //获取特定条件的景点数据
  public getSearchNameCondition(condition: string ): Promise<Spot[]> {
    // 初始化
    return new Promise(async (resolve, reject) => {
      try{
        let params: Params = {
          type: 'query',
          filter: [
            {name:`${condition}`}
          ]
        }
        const res = await cloudFunction.call({ name: 'get-spot-data', data: params})
        let data = res.result
        resolve(JSON.parse(JSON.stringify(data)).data as Spot[])
      }catch (e){
        Logger.error(TAG, 'SpotModel getSpotDataByCondition failed', e);
        reject(e)
      }
    })
  }

  //获取火热景点数据
  public getHotSpotData(): Promise<Spot[]> {
    // 初始化
    return new Promise(async (resolve, reject) => {
      try{
        let params: Params = {
          type: 'query',
          limit: 3,
          orderBy: {field: 'rating', type: 'desc'}
        }
        const res = await cloudFunction.call({ name: 'get-spot-data', data: params})
        let data = res.result
        resolve(JSON.parse(JSON.stringify(data)).data as Spot[])
      }catch (e){
        Logger.error(TAG, 'SpotModel getHotSpotData failed', e);
        reject(e)
      }
    })
  }

  async addCollectData(spotid:number,personUid:string){
    cloudFunction.call({
      name: 'get-hiscol-data',
      data: {
        personUid:personUid,
        fiel:spotid,
        sort:"spot",
        table:'collectadd'
      }
    }).then((value: cloudFunction.FunctionResult) => {
      console.info(`收藏成功添加 ${JSON.stringify(value.result)}`);
      promptAction.showToast({message: '收藏成功', duration: 2000})
    }).catch((err: BusinessError) => {
      console.error(`收藏添加失败, Code: ${err.code}, message: ${err.message}`);
      promptAction.showToast({message: `收藏失败 ${err.message}`, duration: 2000})
    })
  }

  //删除收藏记录
  async delCollectData(spotid:number,personUid:string){
    cloudFunction.call({
      name: 'get-hiscol-data',
      data: {
        personUid:personUid,
        fiel:spotid,
        sort:"spot",
        table:'collectdel'
      }
    }).then((value: cloudFunction.FunctionResult) => {
      console.info(`收藏成功删除 ${JSON.stringify(value.result)}`);
      promptAction.showToast({message: '收藏删除成功', duration: 2000})
    }).catch((err: BusinessError) => {
      console.error(`收藏删除失败, Code: ${err.code}, message: ${err.message}`);
      promptAction.showToast({message: `收藏删除失败 ${err.message}`, duration: 2000})
    })
  }

  async addHistoryData(spotid:number,personUid:string){
    cloudFunction.call({
      name: 'get-hiscol-data',
      data: {
        personUid:personUid,
        fiel:spotid,
        sort:"spot",
        table:'browsingadd'
      }
    }).then((value: cloudFunction.FunctionResult) => {
      console.info(`浏览记录成功添加 ${JSON.stringify(value.result)}`);
      promptAction.showToast({message: '浏览记录提添加成功', duration: 2000})
    }).catch((err: BusinessError) => {
      console.error(`浏览记录添加失败, Code: ${err.code}, message: ${err.message}`);
      promptAction.showToast({message: `浏览记录添加失败 ${err.message}`, duration: 2000})

    })
  }

}
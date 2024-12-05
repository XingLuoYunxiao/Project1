import { Spot } from "./Spot";
import Logger from "utils/src/main/ets/utils/Logger";
import { cloudFunction } from "@kit.CloudFoundationKit";
import { SpotParams } from "./SpotFuncParams";

const TAG = '[SpotModel]';

export class SpotModel {

  //获取景点数据
  public getAllSpotData(): Promise<Spot[]> {
    // 初始化
    return new Promise(async (resolve, reject) => {
      try{
        let params:SpotParams = {
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
        let params:SpotParams = {
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

  //获取火热景点数据
  public getHotSpotData(): Promise<Spot[]> {
    // 初始化
    return new Promise(async (resolve, reject) => {
      try{
        let params:SpotParams = {
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

}
import cloud, { Database } from "@hw-agconnect/cloud";
import { mySpot } from "./mySpot";
import  theSpot  from '../../resources/rawfile/ProjectOne_28_cn.json';
import { Spot } from "./Spot";
import Logger from "utils/src/main/ets/utils/Logger";

const TAG = '[SpotModel]';

export class SpotModel {
  database:Database = cloud.database({
    zoneName:'Travel',
    objectTypeInfo: theSpot
  })

  //获取景点数据
  public getSpotData(): Promise<Spot[]> {
    // 初始化
    return new Promise(async (resolve, reject) => {
      try{
        let result: mySpot[] = await this.database.collection(mySpot).query().get()
        let spots = result.map(item => new Spot(item.id, item.name, item.summary, item.category, item.rating,
          {latitude: item.latitude, longitude: item.longitude  }, item.ticketPrice, item.openingHours, item.imageUrl, item.cityCode, item.cityId, item.cityName, item.address));
        resolve(spots)
      }catch (e){
        Logger.error(TAG, 'SpotModel getSpotData failed', e);
        reject(e)
      }
    })

  }
}
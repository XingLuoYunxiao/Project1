import { Location } from "utils";
import { TravelPlan } from "../service/TravelPlan";
import { ISpot } from "./ISpot";
import { cloudDatabase } from "@kit.CloudFoundationKit";


@Observed
export class Spot extends cloudDatabase.DatabaseObject implements ISpot {
  public id: number | undefined;
  public name: string | undefined;
  public summary: string  | undefined;
  public category : string | undefined; // 分类
  public rating : number  | undefined;
  public ticketPrice: number | undefined;
  public openingHours: string | undefined;
  public imageUrl: string | undefined
  public latitude: number | undefined;
  public longitude: number | undefined;
  public cityCode:string | undefined //城市编码
  public cityId:string | undefined//城市ID
  public cityName:string | undefined//城市名称
  public areaName?:string | undefined//镇名称
  public address?:string | undefined//地址
  public proId?:string | undefined//省份ID
  public proName?:string | undefined//省份名称
  public areaId?:string | undefined//镇ID





  public naturalbase_ClassName(): string {
    return 'mySpot';
  }

}

export { Location };

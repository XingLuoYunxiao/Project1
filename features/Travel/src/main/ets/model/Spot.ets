import { IBaseProject, IChat } from "uicomponents";
import { Location } from "utils";
import { TravelPlan } from "../service/TravelPlan";
import { ISpot } from "./ISpot";
import { TravelChat } from "./TravelChat";
import { cloudDatabase } from "@kit.CloudFoundationKit";

export interface custom{
  travelPlans: TravelPlan[];
  recommendedRoute: string;
}

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
  chats: TravelChat[] = [new TravelChat(0 ,[])];

  static idCount = 0
  static resContent:string | undefined = undefined
  static customTravel:custom = {travelPlans:[], recommendedRoute:''}



  public naturalbase_ClassName(): string {
    return 'mySpot';
  }


  addChat(): void {
    Spot.idCount += 1
    let newChat = new TravelChat(Spot.idCount ,[])
    this.chats.push(newChat)
  }

  sendRequest(content:string, onUpdate: (chunk: string) => void): void {
    this.chats[0].getData(content, onUpdate);
  }

  async sendTravelRequest(context:string){
    let str = await this.chats[0].getTravelDetail(context)
    Spot.resContent = str
    let result: custom = this.parseTravelPlans(str);
    console.log('travelPlanTest result:', result)
    return result
  }


  parseTravelPlans(template: string): custom{
    // 正则表达式匹配路线方案
    const routeOptionsRegex = /路线方案[一二三]：\s*(.*?)(?=路线方案[一二三]|对比说明)/gs;

    // 匹配对比说明
    const descriptionsRegex = /对比方案[一二三]：\s*(.*?)(?=对比方案[一二三]|推荐路径)/gs;

    // 匹配推荐路径
    const recommendedRouteRegex = /推荐路径\s*方案：\s*(.*)/s;

    const travelPlans: TravelPlan[] = [];

    // 提取路线方案
    const routeMatches = Array.from(template.matchAll(routeOptionsRegex));
    const descriptionMatches = Array.from(template.matchAll(descriptionsRegex));

    routeMatches.forEach((routeMatch, index) => {
      const routeText = routeMatch[1].trim();
      const routes = routeText.split('->').map(site => site.trim()).filter(site => site);

      const descMatch = descriptionMatches[index];
      const description = descMatch ? descMatch[1].trim() : '';

      if (routes.length > 0) {
        travelPlans.push({
          id: index + 1,
          sites: routes,
          description: description
        });
      }
    });

    // 提取推荐路径
    const recommendedRouteMatch = template.match(recommendedRouteRegex);
    const recommendedRoute = recommendedRouteMatch ? recommendedRouteMatch[1].trim() : '';

    Spot.customTravel = {travelPlans, recommendedRoute}

    return {
      travelPlans,
      recommendedRoute
    } as custom;
  }



  getChat(index: number): IChat {
    return this.chats[index];
  }

  getAllChat(): IChat[] {
    return this.chats;
  }

  /*getData(): Promise<Spot[]> {
    return new Promise<Spot[]>(async (resolve, reject) => {
      try{
        this.spots = await Spot.netWork.getSpotData();
        resolve(this.spots);
      }catch (e){
        return reject(e);
      }
    }).catch( (error:BusinessError) => {
      return Promise.reject(error);
    });
  }*/

}

export { Location };

import { IBaseProject, IChat } from "uicomponents";
import { Location } from "utils";
import { TravelPlan } from "../service/TravelPlan";
import { ISpot } from "./ISpot";
import { TravelChat } from "./TravelChat";

export interface custom{
  travelPlans: TravelPlan[];
  recommendedRoute: string;
}

@Observed
export class Spot extends IBaseProject implements ISpot {
  id: string;
  name: string;
  summary: string;
  category: string; // 分类
  rating: number;
  location: Location;
  ticketPrice: number;
  openingHours: string;
  image: string
  cityCode:string //城市编码
  cityId:string //城市ID
  cityName:string //城市名称
  address?:string //地址
  proId?:string //省份ID
  proName?:string //省份名称
  areaId?:string //镇ID
  areaName?:string //镇名称

  chats: TravelChat[] = [new TravelChat(0 ,[])];

  static idCount = 0
  static resContent:string | undefined = undefined
  static customTravel:custom = {travelPlans:[], recommendedRoute:''}

  constructor( id: string, name: string, summary: string, category: string, rating:number, location: Location, ticketPrice: number,
  openingHours: string, image: string, cityCode:string, cityId:string, cityName:string, address?:string ) {
    super(name);
    this.id = id;
    this.name = name;
    this.summary = summary;
    this.category = category;
    this.rating = rating;
    this.location = location;
    this.ticketPrice = ticketPrice;
    this.openingHours = openingHours;
    this.image = image;
    this.cityCode = cityCode;
    this.cityId = cityId;
    this.cityName = cityName;
    this.address = address;
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

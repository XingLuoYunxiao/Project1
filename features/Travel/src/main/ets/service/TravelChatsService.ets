import { IChat } from "uicomponents";
import { TravelChat } from "../model/TravelChat";
import { TravelPlan } from "./TravelPlan";


export interface custom{
  travelPlans: TravelPlan[];
  recommendedRoute: string;
}

export class TravelChatsService{
  private static instance: TravelChatsService = new TravelChatsService();
  private static chats: TravelChat[] | undefined = undefined;
  private static idCount = 0
  resContent:string | undefined = undefined
  customTravel:custom = {travelPlans:[], recommendedRoute:''}

  static getInstance(): TravelChatsService {
    if(!TravelChatsService.instance === undefined)
      TravelChatsService.instance = new TravelChatsService();
    return TravelChatsService.instance;
  }

  constructor() {
    this.init();
  }

  init(){
    TravelChatsService.chats = [];
    TravelChatsService.chats.push(new TravelChat(++TravelChatsService.idCount, []))
  }

  getChats(){
    if(TravelChatsService.chats === undefined){
      this.init()
    }
    return TravelChatsService.chats;
  }


  addChat(): void {
    if(TravelChatsService.chats === undefined){
      this.init()
    }else{
      TravelChatsService.idCount += 1
      let newChat = new TravelChat(TravelChatsService.idCount ,[])
      TravelChatsService.chats.push(newChat)
    }
  }

  sendRequest(content:string, onUpdate: (chunk: string) => void): void {
    if(TravelChatsService.chats === undefined){
      this.init()
    }else{
      TravelChatsService.chats[0].getData(content, onUpdate);
    }
  }

  async sendTravelRequest(context:string){
    if(TravelChatsService.chats === undefined){
      this.init()
    }
    let str = await TravelChatsService.chats![0].getTravelDetail(context)
    this.resContent = str
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

    this.customTravel = {travelPlans, recommendedRoute}

    return {
      travelPlans,
      recommendedRoute
    } as custom;
  }



  getChat(index: number): IChat {
    if(TravelChatsService.chats === undefined){
      this.init()
    }
    return TravelChatsService.chats![index];
  }

  getAllChat(): IChat[] {
    if(TravelChatsService.chats === undefined){
      this.init()
    }
    return TravelChatsService.chats!;
  }

  /*getData(): Promise<TravelChatsService[]> {
    return new Promise<TravelChatsService[]>(async (resolve, reject) => {
      try{
        this.TravelChatsServices = await TravelChatsService.netWork.getTravelChatsServiceData();
        resolve(this.TravelChatsServices);
      }catch (e){
        return reject(e);
      }
    }).catch( (error:BusinessError) => {
      return Promise.reject(error);
    });
  }*/
}
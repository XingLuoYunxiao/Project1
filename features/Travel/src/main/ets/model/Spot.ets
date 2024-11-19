import { IBaseProject, IChat } from "uicomponents";
import { Location } from "utils";
import { ISpot } from "./ISpot";
import { TravelChat } from "./TravelChat";


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

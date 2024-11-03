import { IBaseProject, IChat } from "@ohos/Uicomponents";
import { ISpot } from "./ISpot";
import { TravelChat } from "./TravelChat";

export interface Location {
  latitude: number;
  longitude: number;
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
  cityId?:string //城市ID
  cityName?:string //城市名称
  address?:string //地址
  proId?:string //省份ID
  proName?:string //省份名称
  areaId?:string //镇ID
  areaName?:string //镇名称

  chats: TravelChat[] = [new TravelChat(0 ,[])];

  static idCount = 0

  constructor( id: string, name: string, summary: string, category: string, rating:number, location: Location, ticketPrice: number,
    openingHours: string, image: string) {
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

}
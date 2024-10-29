import { IBaseProject, IChat } from "@ohos/uicomponents";
import { ISpot } from "./ISpot";
import { TravelChat } from "./TravelChat";

export interface Location {
  latitude: number;
  longitude: number;
}

export class Spot extends IBaseProject implements ISpot {

  id: string;
  name: string;
  description: string;
  feature: string;
  rating: number;
  location: Location;
  ticketPrice: number;
  openingHours: string;
  image: string
  chats: TravelChat[] = [new TravelChat(0 ,[])];
  static idCount = 0

  constructor( id: string, name: string, description: string, feature: string, rating:number, location: Location, ticketPrice: number,
    openingHours: string, image: string) {
    super(name);
    this.id = id;
    this.name = name;
    this.description = description;
    this.feature = feature;
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
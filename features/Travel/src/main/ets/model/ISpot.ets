import {IBaseProject, IChat} from '@ohos/uicomponents'
// ISpot.ets - 景点接口
export interface ISpot {
  id: string;
  name: string;
  description: string;
}

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
  protected chats: Array<IChat>;

  constructor(name: string, id: string, description: string, feature: string, rating:number, location: Location, ticketPrice: number,
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
    this.chats = [];
  }



  addChat(chat: IChat): void {
    throw new Error('Method not implemented.');
  }

  getChat(index: number): IChat {
    throw new Error('Method not implemented.');
  }

  getAllChat(): IChat[] {
    throw new Error('Method not implemented.');
  }

}
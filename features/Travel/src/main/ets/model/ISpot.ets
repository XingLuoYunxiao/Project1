
// ISpot.ets - 景点接口
interface ISpot {
  id: string;
  name: string;
  description: string;
  location: Location;
  ticketPrice: number;
  openingHours: string;

}

interface Location {
  latitude: number;
  longitude: number;
}
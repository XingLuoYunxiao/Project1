// ISpot.ets - 景点接口
interface ISpot {
  id: string;
  name: string;
  description: string;
  location: Location;
  ticketPrice: number;
  openingHours: string;
  getDetails(): SpotDetails;
}

interface Location{
  latitude: number;
  longitude: number;
}

// IPathPlanner.ets - 路径规划器接口
interface IPathPlanner {
  planPath(start: Location, end: Location, preferences: PathPreferences): Promise<Path>;
  optimizePath(path: Path): Promise<Path>;
}

// ITicketService.ets - 票务服务接口
interface ITicketService {
  checkAvailability(spotId: string, date: Date): Promise<boolean>;
  calculatePrice(spotId: string, quantity: number): Promise<number>;
  bookTicket(spotId: string, userId: string, quantity: number): Promise<Booking>;
}

// IHotelService.ets - 酒店服务接口
interface IHotelService {
  searchNearby(location: Location, radius: number): Promise<Hotel[]>;
  checkAvailability(hotelId: string, checkIn: Date, checkOut: Date): Promise<RoomAvailability[]>;
  bookRoom(hotelId: string, roomType: string, checkIn: Date, checkOut: Date): Promise<HotelBooking>;
}

// ITravelPlanBuilder.ets - 旅游方案建造者接口
interface ITravelPlanBuilder {
  reset(): void;
  addSpot(spot: ISpot): ITravelPlanBuilder;
  addHotel(hotel: Hotel): ITravelPlanBuilder;
  addActivity(activity: Activity): ITravelPlanBuilder;
  setTimeSlots(timeSlots: TimeSlot[]): ITravelPlanBuilder;
  build(): TravelPlan;
}
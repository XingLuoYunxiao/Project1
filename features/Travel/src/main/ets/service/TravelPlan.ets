import { Spot } from "../model/Spot";

export interface TravelPlan {
  id: number;
  sites: string[];
  description: string;
}

export interface Params{
  spot: Spot;
  travelPlan: TravelPlan;
}
import { Location, Spot } from '../model/ISpot'

class InnerSpot {
  id: string
  name: string
  description: string
  location?: Location

  constructor(id:string, name: string, description: string, location?: Location) {
    this.id = id
    this.name = name
    this.description = description
    this.location = location
  }


}
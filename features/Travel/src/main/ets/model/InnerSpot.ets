import { ISpot } from './ISpot'
import { Location } from './Spot'

class InnerSpot implements ISpot {
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
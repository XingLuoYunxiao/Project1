import { Location } from 'utils'
import { ISpot } from './ISpot'

class InnerSpot implements ISpot {
  id: number
  name: string
  summary: string
  location?: Location

  constructor(id:number, name: string, description: string, location?: Location) {
    this.id = id
    this.name = name
    this.summary = description
    this.location = location
  }


}
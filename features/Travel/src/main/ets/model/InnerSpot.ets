import { Location } from '@ohos/Utils'
import { ISpot } from './ISpot'

class InnerSpot implements ISpot {
  id: string
  name: string
  summary: string
  location?: Location

  constructor(id:string, name: string, description: string, location?: Location) {
    this.id = id
    this.name = name
    this.summary = description
    this.location = location
  }


}
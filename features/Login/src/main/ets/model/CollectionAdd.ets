@Observed
class CollectionAdd {
  id:number;
  spotId:number;
  userId:string;
  type:string;
  spotname: string;
  spot_img:string;
  isChoose:boolean;
  rating?:number;
  ticketPrice?:number;
  openningHours?:string;
  areaName?:string;

  constructor(id:number,spotId:number,userId:string,type:string,spotname:string,spot_img:string,isChoose:boolean,rating?:number,
  ticketPrice?:number,
  openningHours?:string,
  areaName?:string) {
    this.id =id;
    this.spotId = spotId;
    this.userId =userId;
    this.type = type;
    this.spotname=spotname;
    this.spot_img=spot_img;
    this.isChoose=isChoose;
    this.rating=rating;
    this.ticketPrice=ticketPrice;
    this.openningHours=openningHours;
    this.areaName=areaName
  }
}

export {CollectionAdd}
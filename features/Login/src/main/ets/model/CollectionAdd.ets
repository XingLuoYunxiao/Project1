@Observed
class CollectionAdd {
  id:number;
  spotId:number;
  userId:string;
  type:string;
  spotname: string;
  spot_img:string;
  isChoose:boolean;

  constructor(id:number,spotId:number,userId:string,type:string,spotname:string,spot_img:string,isChoose:boolean) {
    this.id =id;
    this.spotId = spotId;
    this.userId =userId;
    this.type = type;
    this.spotname=spotname;
    this.spot_img=spot_img;
    this.isChoose=isChoose
  }
}

export {CollectionAdd}
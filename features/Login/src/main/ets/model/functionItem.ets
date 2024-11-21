export class functionItem{
  img:ResourceStr;
  title:string;
  turnname:string;
  icon?:ResourceStr;

  constructor(img:ResourceStr, title:string,turnname:string, icon?:ResourceStr) {
    this.img=img;
    this.title=title;
    this.turnname=turnname
    this.icon=icon
  }
}
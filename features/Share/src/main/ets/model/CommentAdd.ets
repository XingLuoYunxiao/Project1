@Observed
class CommentAdd{
  id:number;
  momentid:string;
  text:string;
  image:string;
  photo:string;
  name:string

  constructor(id:number,momentid:string,text:string,image:string,photo:string,name:string) {
    this.id=id;
    this.momentid=momentid;
    this.text=text;
    this.image=image;
    this.photo=photo;
    this.name=name
  }
}
export {CommentAdd}
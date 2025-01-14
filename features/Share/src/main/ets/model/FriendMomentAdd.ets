import { Comment } from './Comment';

@Observed
class FriendMomentAdd{
  id: number;
  userId: string;
  userphoto:string;
  username:string;
  text: string;
  image: string;
  good:number;
  location: string;
  time:string;
  comment?: Comment;
  video?: string;

  constructor(id: number, userId: string, text: string, image: string, good: number, location: string,userphoto:string,
  username:string,time:string, comment?:Comment,video?: string) {
    this.id = id;
    this.userId = userId;
    this.text = text;
    this.image = image;
    this.video = video;
    this.good = good;
    this.location = location;
    this.comment = comment;
    this.time=time;
    this.userphoto=userphoto;
    this.username=username;
  }
}
export {FriendMomentAdd}
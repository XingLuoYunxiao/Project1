import { BuilderNameConstants, RouterModule } from 'routermodule';
import { LazyDataSource } from 'utils';
import Constants from '../common/constants/Constants'
import { CommentData } from '../model/BasicDataSource';
import { Comment } from '../model/Comment';
import { FriendMomentAdd } from '../model/FriendMomentAdd';
import { ShareViewModel } from '../service/ShareViewModel';

@Component
struct ShareDetail {
  @State value: object = new Object()
  @Consume('appPathStack') appPathStack: NavPathStack
  @State shareViewModel:ShareViewModel=ShareViewModel.getInstance();
  @Provide commentListData: CommentData<Comment> = this.shareViewModel.commentList
  everymoment:FriendMomentAdd|null=null
  //获取路由参数
  aboutToAppear(): void {
   this.everymoment=JSON.parse(JSON.stringify(this.value)).item as FriendMomentAdd
    this.shareViewModel.commentDeal(this.everymoment.id.toString())
  }

  build() {
    NavDestination(){
      Column(){
        Row(){
          Image($r('app.media.ic_back')).width($r('app.float.md_topic_width')).onClick(()=>{
            this.appPathStack.pop()
          })
          Image(this.everymoment?.userphoto).width(40)
            .height(40)
            .margin({left:12,right:12})
            .borderRadius(20)
          Text(this.everymoment?.username).fontSize(16)
          Blank()
          Text(this.everymoment?.location)
        }
        .padding({left:12,right:12})
        .width('100%')
        Image(this.everymoment?.image)
          .width('100%')
          .height(400)
          .margin({top:10,bottom:10})
        Text(this.everymoment?.text).width('100%').padding({left:12,right:12})
        Text(`共${this.shareViewModel.count}条评论`).padding({left:12,right:12})
          .fontSize($r('app.integer.publish_multimedia_updates_userText_fontSize'))
          .fontColor($r('app.color.publish_multimedia_updates_title_font_color'))
          .opacity($r('app.float.publish_multimedia_updates_opacity'))
          .margin({top:10,bottom:10})
          .width('100%')
        LazyForEach(this.commentListData,(item:Comment)=>{
          ListItem(){
            Row({space:10}){
              Image(item.photo).width(40).height(40).borderRadius(20)
              Column(){
                Text(item.name)
                  .fontSize($r('app.integer.publish_multimedia_updates_userText_fontSize'))
                  .fontColor($r('app.color.publish_multimedia_updates_title_font_color'))
                  .lineHeight($r('app.integer.publish_multimedia_updates_userText_line_height'))
                  .opacity($r('app.float.publish_multimedia_updates_opacity'))
                  .margin({ top: $r('app.integer.publish_multimedia_updates_userText_margin_top') })
                Text(item.text)
              }
            }.width('100%')
          }
          .padding({left:12,right:12})
        })
      }.width('100%')
    }
  .margin({top:40})
  .hideTitleBar(true)
  }
}

@Builder
export function ShareDetailBuilder(value:object) {
  ShareDetail({value:value})
}

const builderName = BuilderNameConstants.SHARE_DETAILSHPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ShareDetailBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
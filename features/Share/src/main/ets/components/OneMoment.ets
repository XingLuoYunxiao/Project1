import { ImageText } from './ImageText';
import { ListConstants } from '../common/constants/ListConstants';
import { SpotNetFunc } from 'travel/src/main/ets/service/SpotNetFunc';
import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from 'routermodule';
import { FriendMomentAdd } from '../model/FriendMomentAdd';
import { CommentInputDialog } from '../pages/CommentInputDialog';
import { promptAction } from '@kit.ArkUI';
import { Comment } from '../model/Comment';
import { ShareViewModel } from '../service/ShareViewModel';
import { Good } from '../model/Good';

@Reusable
@Component
export struct OneMoment {
  @Prop moment: FriendMomentAdd;
  @State SpotNetWork:SpotNetFunc = SpotNetFunc.getInstance()
  @State textInComment: string = ""; // 评论中的文字
  @State imageInComment: ResourceStr|Resource = ''; // 评论中的图片列表
  @StorageLink ('personUid') personUid: string = ''
  @StorageLink ('personPhoto') personPhoto: string = ''
  @StorageLink ('personName') personName: string = ''
  @State userPhoto:string=''
  @State userName:string=''
  @State good:Resource=$r("app.media.publish_multimedia_updates_ic_thumbsup")
  @State shareViewModel:ShareViewModel=ShareViewModel.getInstance();
  @State showgood:number=this.moment.good

  aboutToReuse(params: Record<string, Object>): void {
    this.moment = params.moment as FriendMomentAdd;
  }

  async aboutToAppear(): Promise<void> {
    const isGood=await this.shareViewModel.goodsDeal(this.moment.id,this.personUid)
    if(isGood){
      this.good=$r('app.media.good')
    }
    // this.shareViewModel.getUserinfo(this.moment.userId).then((info)=>{
    //   this.userPhoto=info.userPhoto
    //   this.userName=info.userName
    // })
  }

  dialogController: CustomDialogController= new CustomDialogController({
    builder: CommentInputDialog({
      //需要从弹窗中获取
      textInComment: $textInComment,
      imageInComment: $imageInComment,
      //一点击就知道到了分享的类型,传给弹窗
      momentid:this.moment.id,
      publish: () => this.publishComment()
    }),
    alignment: DialogAlignment.Bottom,
    customStyle: true,
    offset: {
      dx: $r('app.integer.image_comment_dialog_offset_x'),
      dy: $r('app.integer.image_comment_dialog_offset_y')
    }
  });

  publishComment(): void {
    if (this.textInComment!=''||(this.imageInComment as Resource).id!=$r('app.media.add').id) {
        const comment: Comment =new Comment();
        comment.setMomentid(`${this.moment.id}`);
        comment.setText(this.textInComment);
        comment.setUid(this.personUid)
        comment.setImage(this.imageInComment.toString());
        comment.setTime(new Date().toString());
        this.shareViewModel.commentAdd(comment)
    } else {
      promptAction.showToast({
        message: $r('app.string.publish_multimedia_updates_input_comment'),
      });
    }
    // this.scroller.scrollToIndex(0, true, ScrollAlign.START);
  }

  build() {
    Column() {
      Row() {
        //发表用户的头像
        Image(this.moment.userphoto)
          .autoResize(false)
          .width($r('app.integer.publish_multimedia_updates_user_image_width'))
          .height($r('app.integer.publish_multimedia_updates_user_image_height'))
          .borderRadius($r('app.integer.publish_multimedia_updates_user_image_border_radius'))
        Column() {
          //发表用户的用户名
          Text(this.moment.username)
            .fontSize($r('app.integer.publish_multimedia_updates_useName_fontSize'))
            .fontColor($r('app.color.publish_multimedia_updates_title_font_color'))
            .lineHeight($r('app.integer.publish_multimedia_updates_useName_line_height'))
            .fontFamily($r('app.string.publish_multimedia_updates_harmony_hei_ti'))
            .fontWeight(FontWeight.Medium)
          //发表的文字内容
          Text(this.moment.text)
            .fontSize($r('app.integer.publish_multimedia_updates_userText_fontSize'))
            .fontColor($r('app.color.publish_multimedia_updates_title_font_color'))
            .lineHeight($r('app.integer.publish_multimedia_updates_userText_line_height'))
            .opacity($r('app.float.publish_multimedia_updates_opacity'))
            .margin({ top: $r('app.integer.publish_multimedia_updates_userText_margin_top') })
            .maxLines(3)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .margin({ left: $r('app.integer.publish_multimedia_updates_user_col_margin_left') })
        .layoutWeight(ListConstants.LAYOUT_WEIGHT)
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Top)
      .width($r('app.string.publish_multimedia_updates_layout_100'))
      .constraintSize({ minHeight: $r('app.integer.publish_multimedia_updates_oneMoment_height') })
      .padding({
        left: $r('app.integer.publish_multimedia_updates_row_padding_left'),
        right: $r('app.integer.publish_multimedia_updates_row_padding_right'),
        top: $r('app.integer.publish_multimedia_updates_row_padding_top'),
        bottom: $r('app.integer.publish_multimedia_updates_row_padding_bottom')
      })

        //TODO 修改
        if (this.moment.image && JSON.stringify(this.moment.image) !== JSON.stringify($r('app.media.add'))) {
          Column() {
            Image(this.moment.image)
              .width(160)
              .height(200)
          }
          .alignItems(HorizontalAlign.Start)
          .width($r('app.string.publish_multimedia_updates_layout_100'))
          .padding({
            left: $r('app.integer.publish_multimedia_updates_image_group_padding_left'),
            right: $r('app.integer.publish_multimedia_updates_image_group_padding_right')
          })
        }

        // if (this.moment.video && JSON.stringify(this.moment.video) !== JSON.stringify($r("app.media.add_video"))) {
        //   Column() {
        //     Video({
        //       src: this.moment.video
        //     })
        //       .width($r('app.integer.publish_multimedia_updates_single_image_width'))
        //       .height($r('app.integer.publish_multimedia_updates_single_image_height'))
        //       .borderRadius($r('app.integer.publish_multimedia_updates_single_image_radius'))
        //       .autoPlay(false)
        //       //视频播放的控制栏是否显示
        //       .controls(false)
        //       .loop(true)
        //       .objectFit(ImageFit.Cover)
        //       //是否静音
        //       .muted(true)
        //   }
        //   .alignItems(HorizontalAlign.Start)
        //   .width($r('app.string.publish_multimedia_updates_layout_100'))
        //   .padding({
        //     left: $r('app.integer.publish_multimedia_updates_image_group_padding_left'),
        //     right: $r('app.integer.publish_multimedia_updates_image_group_padding_right')
        //   })
        // }

      Row() {
        ImageText({
          imageStr: $r("app.media.location"),
          text: this.moment.location
        }).width(80)
          .onClick(() => {
            this.shareViewModel.taskPoolExecuteQuery(this.moment.location).then((res)=>{
              if(res.length!=0){
                buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_ATTRACTIONDETAILPAGE,new Object({item:res[0]}))
              }
            })
          })
        ImageText({
          imageStr: this.good as Resource,
          text: this.showgood.toString()
        })
          .margin({ left:60})
          .onClick(() => {
            const good=new Good()
            good.setItemId(this.moment.id)
            good.setUserId(this.personUid)
            //未点赞
            if(this.good.id==$r("app.media.publish_multimedia_updates_ic_thumbsup").id){
              this.good=$r('app.media.good')
              this.showgood+=1
              this.shareViewModel.updateGood(this.moment.id.toString(),1)
              this.shareViewModel.goodUpdate(good,true)
            }else {
              this.good=$r("app.media.publish_multimedia_updates_ic_thumbsup")
              this.showgood-=1
              this.shareViewModel.updateGood(this.moment.id.toString(),-1)
              this.shareViewModel.goodUpdate(good,false)
            }
          })
        ImageText({
          imageStr: $r("app.media.publish_multimedia_updates_ic_message"),
          text: $r('app.string.publish_multimedia_updates_message')
        })
          .margin({ left: $r('app.integer.publish_multimedia_updates_message_margin_left') })
          .onClick(() => {
            this.dialogController.open();
          })
      }
      .width($r('app.string.publish_multimedia_updates_layout_100'))
      .margin({
        top: $r('app.integer.publish_multimedia_updates_handler_margin_top'),
        bottom: $r('app.integer.publish_multimedia_updates_handler_margin_bottom')
      })
      .padding({
        left: $r('app.integer.publish_multimedia_updates_handler_padding_left'),
        right: $r('app.integer.publish_multimedia_updates_handler_padding_right')
      })
    }
    .onClick(()=>{
      buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.SHARE_DETAILSHPAGE,new Object({item:this.moment}))
    })
    .width($r('app.string.publish_multimedia_updates_layout_100'))
  }
}

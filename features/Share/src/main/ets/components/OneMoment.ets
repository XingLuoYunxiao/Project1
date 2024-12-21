import { ImageText } from './ImageText';
import { ListConstants } from '../common/constants/ListConstants';
import { SpotNetFunc } from 'travel/src/main/ets/service/SpotNetFunc';
import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from 'routermodule';
import { FriendMomentAdd } from '../model/FriendMomentAdd';
import { CommentInputDialog } from '../pages/CommentInputDialog';
import { promptAction } from '@kit.ArkUI';
import { Comment } from '../model/Comment';
import { ShareViewModel } from '../service/ShareViewModel';

@Reusable
@Component
export struct OneMoment {
  @Prop moment: FriendMomentAdd;
  @State SpotNetWork:SpotNetFunc = SpotNetFunc.getInstance()
  @State textInComment: string = ""; // 评论中的文字
  @State imageInComment: ResourceStr = ''; // 评论中的图片列表
  @StorageLink ('personUid') personUid: string = ''
  @StorageLink ('personPhoto') personPhoto: string = ''
  @StorageLink ('personName') personName: string = ''
  @State good:Resource=$r("app.media.publish_multimedia_updates_ic_thumbsup")
  @State shareViewModel:ShareViewModel=ShareViewModel.getInstance();
  aboutToReuse(params: Record<string, Object>): void {
    this.moment = params.moment as FriendMomentAdd;
  }

  dialogController: CustomDialogController= new CustomDialogController({
    builder: CommentInputDialog({
      //需要从弹窗中获取
      textInComment: $textInComment,
      imagesInComment: $imageInComment,
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
    if (this.textInComment||this.imageInComment) {
        const comment: Comment =new Comment();
        comment.setMomentid(`${this.moment.id}`);
        comment.setText(this.textInComment);
        comment.setImage(this.imageInComment);
        comment.setPhoto(this.personPhoto)
        comment.setName(this.personName)
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
          text: $r('app.string.publish_multimedia_updates_thumbs_up')
        })
          .margin({ left:60})
          .onClick(() => {
            if(this.good.id==$r("app.media.publish_multimedia_updates_ic_thumbsup").id){
              this.good=$r('app.media.good')
              const count=++this.moment.good
              this.shareViewModel.updateGood(this.moment.id.toString(),count)
            }else {
              const count=--this.moment.good
              this.good=$r("app.media.publish_multimedia_updates_ic_thumbsup")
              this.shareViewModel.updateGood(this.moment.id.toString(),count)
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

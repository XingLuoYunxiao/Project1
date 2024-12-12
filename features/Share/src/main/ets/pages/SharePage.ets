import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule";
import Constants from "../common/constants/Constants";
import { ListConstants } from "../common/constants/ListConstants";
import { OneMoment } from "../components/OneMoment";
import { CommentData, friendMoment} from "../model/BasicDataSource";
import { FriendMomentAdd } from "../model/FriendMomentAdd";
import { ShareViewModel } from "../service/ShareViewModel";
import auth from "@hw-agconnect/auth";

const typeVideo: string = 'video';
const typeText: string = 'text';
const typeImage: string = 'image';

@Component
export struct SharePage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @Consume('loginPathStack') loginPathStack: NavPathStack
  listScroller: ListScroller = new ListScroller(); // scroller控制器
  @State shareViewModel:ShareViewModel=ShareViewModel.getInstance();
  @Provide commentList: CommentData<FriendMomentAdd> = this.shareViewModel.shareList
  private cachedCountNumber: number = 5; // 懒加载缓存数
  @State dialogType: string = typeText; // 弹窗类型
  @StorageProp ('personPhoto') personPhoto: string = ''
  private scroller: ListScroller = new ListScroller();


  aboutToAppear(): void {
    this.shareViewModel.shareDeal()
    // 加载初始数据
  }

  getCurrentDate(): string {
    const date: Date = new Date();
    return `${date.getFullYear()}-${date.getMonth()}-${date.getDay()} ${date.getHours()}:${date.getMinutes()}:${date.getSeconds()}`;
  }


  // @Builder
  // MyMenu() {
  //   Menu() {
  //     MenuItem({
  //       startIcon: $r("sys.media.ohos_ic_public_text"),
  //       content: $r('app.string.publish_multimedia_updates_post')
  //     })
  //       .onClick(() => {
  //         this.dialogType = typeText
  //         if (this.dialogController !== null) {
  //           // 打开评论输入弹窗
  //           this.dialogController.open();
  //         }
  //       })
  //     MenuItem({
  //       startIcon: $r("sys.media.save_button_picture"),
  //       content: $r('app.string.publish_multimedia_updates_photo')
  //     })
  //       .onClick(() => {
  //         this.dialogType = typeImage
  //         if (this.dialogController !== null) {
  //           // 打开评论输入弹窗
  //           this.dialogController.open();
  //         }
  //       })
  //     MenuItem({
  //       startIcon: $r("sys.media.ohos_ic_public_video"),
  //       content: $r('app.string.publish_multimedia_updates_video')
  //     })
  //       .onClick(() => {
  //         this.dialogType = typeVideo
  //         if (this.dialogController !== null) {
  //           // 打开评论输入弹窗
  //           this.dialogController.open();
  //         }
  //       })
  //   }
  //   .width($r('app.string.publish_multimedia_updates_layout_40'))
  // }


  build() {
    Navigation(this.loginPathStack){
        Row(){
          Image(this.personPhoto)
            .width($r('app.integer.publish_multimedia_updates_user_image_width'))
            .height($r('app.integer.publish_multimedia_updates_user_image_height'))
            .borderRadius($r('app.integer.publish_multimedia_updates_user_image_border_radius'))
          Text('古韵天地').fontSize(20).layoutWeight(1).textAlign(TextAlign.Center)
          // Image($r('sys.media.ohos_ic_public_add'))
          //   .bindMenu(this.MyMenu())
          //   .width(26)
          //   .height(26)
          Image($r('sys.media.ohos_ic_public_add'))
            .width(26)
            .height(26)
            .onClick(()=>{
              buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.SHARE_PUBLISHPAGE)
            })
        }
        .width('100%')
        .height(50)
        Column() {
          List({ space: ListConstants.LIST_SPACE, scroller: this.listScroller }) {
            // TODO：高性能知识点：列表数据较多，不需要全部渲染上屏，采用LazyForEach。
            LazyForEach(this.commentList, (moment: FriendMomentAdd) => {
              ListItem() {
                OneMoment({ moment: moment});
              }
            }, (moment: FriendMomentAdd) => `${moment.id}`)
          }
          // TODO：高性能知识点：为保证滑动流畅，采用cachedCount缓存前后节点。
          .scrollBar(BarState.Off)
          .cachedCount(this.cachedCountNumber)
          .width($r('app.string.publish_multimedia_updates_layout_100'))
          .height($r('app.string.publish_multimedia_updates_layout_94'))
          .listDirection(Axis.Vertical)
          .divider({
            strokeWidth: $r('app.integer.publish_multimedia_updates_divider_width'),
            color: $r('app.color.publish_multimedia_updates_divider_color'),
            startMargin: $r('app.integer.publish_multimedia_updates_list_divider_margin'),
            endMargin: $r('app.integer.publish_multimedia_updates_list_divider_margin')
          })
        }
        .padding({
          top: $r('app.integer.publish_multimedia_updates_toolbar_padding_top'),
          bottom: $r('app.integer.publish_multimedia_updates_toolbar_padding_bottom')
        })
        .width($r('app.string.publish_multimedia_updates_layout_100'))
    }
    .padding({left:Constants.PADDING_PAGE,right:Constants.PADDING_PAGE,top:Constants.PADDING_PAGE})
    .hideTitleBar(true)
  }
}

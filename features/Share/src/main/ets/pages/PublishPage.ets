import { BuilderNameConstants, RouterModule } from "routermodule";
import { photoAccessHelper } from "@kit.MediaLibraryKit";
import Constants from "../common/constants/Constants";
import { CommentData, friendMoment} from "../model/BasicDataSource";
import { promptAction } from "@kit.ArkUI";
import { FriendMomentAdd } from "../model/FriendMomentAdd";
import { FriendMoment } from "../model/FriendMoment";
import { ShareViewModel } from "../service/ShareViewModel";
import auth from '@hw-agconnect/auth'

@Component
struct PublishPage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @State selectedImages: ResourceStr = $r('app.media.add');
  @State textInPublish: string = ""; // 文字
  @StorageLink ('personUid') personUid: string = ''
  @StorageLink ('personPhoto') personPhoto: string = ''
  @StorageLink ('personName') personName: string = ''
  @State shareViewModel:ShareViewModel=ShareViewModel.getInstance();
  @State selectedImagesArr:ResourceStr[]=[]
  // @Consume commentList: CommentData

  async getPictureFromAlbum() {
    // 拉起相册，选择图片
    let PhotoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
    // 选择图库内媒体资源种类
    PhotoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
    // 设置最大媒体文件选择数量
    PhotoSelectOptions.maxSelectNumber = 9;
    // 创建photoPicker
    let photoPicker = new photoAccessHelper.PhotoViewPicker();
    // 使用photoAccessHelper获取媒体资源信息
    let photoSelectResult: photoAccessHelper.PhotoSelectResult = await photoPicker.select(PhotoSelectOptions);
    // 获取对应资源文件uri地址
    //TODO 多图实现
    this.selectedImages = photoSelectResult.photoUris[0];
    this.selectedImagesArr=photoSelectResult.photoUris
  }

  getCurrentDate(): string {
    const date: Date = new Date();
    return `${date.getFullYear()}-${date.getMonth()}-${date.getDay()} ${date.getHours()}:${date.getMinutes()}:${date.getSeconds()}`;
  }

  publish(): void {
    const content: FriendMoment = new FriendMoment();
    content.setUserId(this.personUid)
    content.setText(this.textInPublish)
    content.setImage(this.selectedImages)
    content.setGood(0)
    content.setLocation('后海')
    content.setUserPhoto(this.personPhoto)
    content.setUserName(this.personName)
    this.shareViewModel.shareAdd(content)
    // this.scroller.scrollToIndex(0, true, ScrollAlign.START);

      if(!(this.textInPublish||this.selectedImages)){
        promptAction.showToast({
          message: $r('app.string.publish_multimedia_updates_input_comment'),
        });
      }
  }


  build() {
    NavDestination(){
      Column(){
        Row(){
          Image($r('app.media.ic_back')).width($r('app.float.md_topic_width')).onClick(()=>{
            this.appPathStack.pop()
          })
          Button('发表').onClick(()=>{
            this.publish()
            this.appPathStack.pop()
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        TextArea()
          .backgroundColor(Color.White)
          .onChange((val)=>{
              this.textInPublish=val
          })
          .defaultFocus(true)
        Image(this.selectedImages)
          .width(100)
          .height(100)
          .margin({left:15})
          .alignSelf(ItemAlign.Start)
          .onClick(()=>{this.getPictureFromAlbum()})
      }.padding({left:Constants.PADDING_PAGE,right:Constants.PADDING_PAGE,top:Constants.PADDING_PAGE})
    }
    .margin({top:Constants.HEADER_HEIGHT_PAGE})
    .hideTitleBar(true)
  }
}
@Builder
export function PublishPageBuilder() {
  PublishPage()
}

const builderName = BuilderNameConstants.SHARE_PUBLISHPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(PublishPageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}
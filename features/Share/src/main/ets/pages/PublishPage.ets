import { BuilderNameConstants, RouterModule } from "routermodule";
import { photoAccessHelper } from "@kit.MediaLibraryKit";
import Constants from "../common/constants/Constants";
import { CommentData, friendMoment} from "../model/BasicDataSource";
import { promptAction } from "@kit.ArkUI";
import { FriendMomentAdd } from "../model/FriendMomentAdd";
import { FriendMoment } from "../model/FriendMoment";
import { ShareViewModel } from "../service/ShareViewModel";
import auth from '@hw-agconnect/auth'
import { StoreViewModel } from "../service/StoreVielModel";

@Component
struct PublishPage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @State selectedImages: ResourceStr = $r('app.media.add');
  @State textInPublish: string = "";
  @StorageProp ('personUid') personUid: string = ''
  @StorageProp ('personPhoto') personPhoto: string = ''
  @StorageProp ('personName') personName: string = ''
  @State location:string=''
  @State shareViewModel:ShareViewModel=ShareViewModel.getInstance();
  @State storeViewModel:StoreViewModel=StoreViewModel.getInstance();
  time:string=''
  // @State selectedImagesArr:ResourceStr[]=[]

  getCurrentDate(): string {
    const date: Date = new Date();
    return `${date.getFullYear()}-${date.getMonth()}-${date.getDay()} ${date.getHours()}:${date.getMinutes()}:${date.getSeconds()}`;
  }

  async publish(img:string): Promise<void> {
    const content: FriendMoment = new FriendMoment();
    //添加图片的时间
    content.setUserId(this.personUid)
    content.setText(this.textInPublish)
    content.setImage(img)
    content.setGood(0)
    content.setLocation(this.location)
    content.setUserPhoto(this.personPhoto)
    content.setUserName(this.personName)
    this.shareViewModel.shareAdd(content,this.personPhoto,this.personName)
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
          Button('发表').onClick(async ()=>{
            const img=await this.storeViewModel.getUrl(this.personUid,this.time)
            this.publish(img)
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
          .onClick(()=>{
            this.time=new Date().toString()
            this.storeViewModel.upload(this.personUid,this.time).then((val)=>{
              this.selectedImages=val.photoUris[0]
            })
          })
      }.padding({left:Constants.PADDING_PAGE,right:Constants.PADDING_PAGE,top:Constants.PADDING_PAGE})
      TextInput({placeholder:'分享您的位置:'})
        .onChange((val)=>{
          this.location=val
        })
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
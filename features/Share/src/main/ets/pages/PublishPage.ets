import { BuilderNameConstants, RouterModule } from "routermodule";
import Constants from "../common/constants/Constants";
import { promptAction } from "@kit.ArkUI";
import { FriendMoment } from "../model/FriendMoment";
import { ShareViewModel } from "../service/ShareViewModel";

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
  time:string=''
  // @State selectedImagesArr:ResourceStr[]=[]

  getCurrentDate(): string {
    const date: Date = new Date();
    return `${date.getFullYear()}-${date.getMonth()}-${date.getDay()} ${date.getHours()}:${date.getMinutes()}:${date.getSeconds()}`;
  }

  async publish(uid:string,time:string): Promise<void> {
    const content: FriendMoment = new FriendMoment();
    const img=`share/moment/${uid+time.replace(/\s/g, "").slice(0,20)}`
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
            this.publish(this.personUid,this.time)
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
          .onClick(async ()=>{
            this.time=new Date().toString()
            //上传到云存储,this.selectedImages是res.photoUris[0]
            this.selectedImages=await this.shareViewModel.upload(this.personUid,this.time)
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
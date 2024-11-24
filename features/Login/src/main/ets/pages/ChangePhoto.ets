import { photoAccessHelper } from "@kit.MediaLibraryKit";
import { BusinessError } from "@kit.BasicServicesKit";
import auth from "@hw-agconnect/auth";
import { hilog } from "@kit.PerformanceAnalysisKit";
import { image } from "@kit.ImageKit";
import fileio from '@ohos.fileio';
import { fileIo as fs } from '@kit.CoreFileKit';
import { BuilderNameConstants, RouterModule } from "routermodule";
import Constants from "../common/constants/Constants";

@CustomDialog
struct CustomDialogChange {
  @StorageLink('personName') personName: string =''
  @StorageLink('personPhoto') personPhoto: string =''
  newName:string=''
  controller: CustomDialogController
  build() {
    Column() {
      Row(){
        Text('修改昵称')
          .fontSize(20)
          .height(50)
        Image($r('app.media.ic_close')).width(30)
          .onClick(()=>{
            this.controller.close()
          })
      }
      TextInput({text:this.personName})
        .onChange((val)=>{
          this.newName=val
        })
      Text('昵称限制1-30个字符')
      Button('保存').onClick(()=>{
        auth.getCurrentUser().then((curuser)=>{
          hilog.info(1,'获取用户成功',JSON.stringify(curuser))
          if(curuser){
            curuser.updateProfile({displayName:this.newName,photoUrl:this.personPhoto}).then((val)=>{
              this.personName=curuser.getDisplayName()
              this.personPhoto=curuser.getPhotoUrl()
              this.controller.close()
            }).catch((e:Error)=>{
              console.log('修改昵称失败'+JSON.stringify(e))
            })
          }
        })
      })
    }
  }
}

@Component
export struct ChangePhoto {
  @StorageLink('personName') personName: string =''
  @StorageLink('personPhoto') personPhoto: string =''
  @Consume('appPathStack') appPathStack: NavPathStack
  dialogController: CustomDialogController= new CustomDialogController({
    builder: CustomDialogChange({
    }),
    alignment: DialogAlignment.Center,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    showInSubWindow: true,
    isModal: true,
    customStyle: false,
    cornerRadius: 10,
  })

  build() {
      NavDestination(){
        Column() {
          Image($r('app.media.ic_back'))
            .onClick(()=>{
              this.appPathStack.pop()
            })
            .width($r('app.float.md_topic_width'))
          Row(){
            //暂定
            Image(this.personPhoto).width(40)
              .onClick(()=> {
                //选择图片
                let PhotoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
                PhotoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
                PhotoSelectOptions.maxSelectNumber = 1;
                let photoPicker = new photoAccessHelper.PhotoViewPicker();
                photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult: photoAccessHelper.PhotoSelectResult) => {
                  console.info('PhotoViewPicker.select成功, PhotoSelectResult uri: ' + JSON.stringify(PhotoSelectResult.photoUris[0]));
                  auth.getCurrentUser().then((curuser)=>{
                    if(curuser&&typeof this.personPhoto==='string'){
                      curuser.updateProfile({displayName:this.personName,photoUrl:PhotoSelectResult.photoUris[0]}).then((val)=>{
                        this.personName=curuser.getDisplayName()
                        this.personPhoto=curuser.getPhotoUrl()
                      }).catch((e:Error)=>{
                        console.log('修改头像失败'+JSON.stringify(e))
                      })
                    }
                  })
                }).catch((err: BusinessError) => {
                  console.error(`PhotoViewPicker.select失败,err: ${err.code}, ${err.message}`);
                });
              })
            Text(this.personName).onClick(()=>{
              //修改用户名
              this.dialogController.open()
            })
          }
        }
        .width('100%')
      }
      .hideTitleBar(true)
      .margin({top:Constants.HEADER_HEIGHT_PAGE})
  }
}
@Builder
export function ChangePhotoBuilder() {
  ChangePhoto()
}

const builderName = BuilderNameConstants.LOGIN_CHANGEPHOTO;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(ChangePhotoBuilder);
  RouterModule.registerBuilder(builderName, builder);
}

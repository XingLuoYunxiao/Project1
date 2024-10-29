import { fileIo, picker } from '@kit.CoreFileKit';
import { BusinessError, request } from '@kit.BasicServicesKit';
import { image } from '@kit.ImageKit';
import { cloudStorage } from '@kit.CloudFoundationKit';
import { hilog } from '@kit.PerformanceAnalysisKit';

const bucket: cloudStorage.StorageBucket = cloudStorage.bucket();

type UploadCompleteCallback = (uploadSuccess: boolean) => void;

@Entry
@Component
struct CloudStorage {
  @State isUploading: boolean = false;
  @State updateProgress: number = 0;
  @State image: Resource | PixelMap = $r('app.media.empty_image');
  @State accessAddress: string = '';
  @State publicAddress: string = '';

  build() {
    Column() {
      Navigation()
        .title($r('app.string.cloudStorage_label'))
        .height('50vp')
        .width('100%')
        .margin({ bottom: 10 })
        .titleMode(NavigationTitleMode.Mini)

      Column() {
        Row() {
          Text($r('app.string.cloudStorage_description')).fontSize($r('app.float.body_font_size'))
        }.margin({ bottom: 15 })

        Row() {
          Button($r('app.string.cloudStorage_uploadButton'), { type: ButtonType.Normal })
            .borderRadius(4)
            .width('100%')
            .opacity(!this.isUploading ? 1 : 0.5)
            .enabled(!this.isUploading)
            .height(40)
            .onClick(() => {
              this.upLoadImage()
            })
        }

        if (this.isUploading) {
          Row() {
            Text($r('app.string.cloudStorage_progressLabel')).fontSize($r('app.float.body_font_size'))
            Text(`: ${this.updateProgress.toString().substring(0, 5)} %`).fontSize($r('app.float.body_font_size'))
          }.margin({ top: 10 })
        }
      }.alignItems(HorizontalAlign.Start).width('90%').margin({ bottom: 20 })

      Column() {
        Row() {
          Image(this.image).objectFit(ImageFit.Contain).height(250).backgroundColor($r('app.color.black'))
        }
      }.width('90%').margin({ bottom: 15 })

      if (this.accessAddress !== '' && this.publicAddress !== '') {
        Column({ space: 10 }) {
          Flex({ justifyContent: FlexAlign.SpaceBetween }) {
            Column() {
              Text($r('app.string.cloudStorage_accessAddressLabel'))
                .fontSize($r('app.float.list_item_font_size'))
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Start)
                .width('100%')
              Text(this.accessAddress)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .textAlign(TextAlign.Start)
                .wordBreak(WordBreak.BREAK_ALL)
                .width('100%')
                .maxLines(1)
                .fontSize($r('app.float.list_item_font_size'))
            }.height(30).layoutWeight(3)
          }

          Flex({ justifyContent: FlexAlign.SpaceBetween }) {
            Column() {
              Text($r('app.string.cloudStorage_publicAccessAddressLabel'))
                .fontSize($r('app.float.list_item_font_size'))
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Start)
                .width('100%')
              Text(this.publicAddress)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .textAlign(TextAlign.Start)
                .wordBreak(WordBreak.BREAK_ALL)
                .width('100%')
                .maxLines(1)
                .fontSize($r('app.float.list_item_font_size'))
            }.height(30).layoutWeight(3)
          }
        }.width('90%').margin({ right: 10 })
      }
    }.height('100%')
  }

  private upLoadImage() {
    this.selectImage().then((selectImageUri: string) => {
      if (!selectImageUri) {
        hilog.info(0x0000, 'CloudStorage', 'cancel select image!');
        return;
      }
      this.initStates();
      // copy select file to cache directory
      let fileName = selectImageUri.split('/').pop() as string;
      let cacheFilePath = `${getContext().cacheDir}/${fileName}`;
      this.copyFile(selectImageUri, cacheFilePath);

      let cloudPath = `test_cloud_storage/image_${new Date().getTime()}.jpg`
      bucket.uploadFile(getContext(this), {
        localPath: cacheFilePath,
        cloudPath: cloudPath,
      }).then(task => {
        // add task event listener
        this.addEventListener(task, this.onUploadCompleted(cloudPath, cacheFilePath));
        // start task
        task.start();
      }).catch((err: BusinessError) => {
        hilog.error(0x0000, 'CloudStorage', 'uploadFile failed, error code: %{public}d, message: %{public}s',
          err.code, err.message);
        this.isUploading = false;
      });
    }).catch((err: Error) => {
      hilog.error(0x0000, 'CloudStorage', 'upLoadImage error %{public}s', JSON.stringify(err));
      this.isUploading = false;
    });
  }

  private selectImage(): Promise<string> {
    return new Promise((resolve: (selectUri: string) => void, reject: (err: Error) => void) => {
      new picker.PhotoViewPicker().select({
        MIMEType: picker.PhotoViewMIMETypes.IMAGE_TYPE,
        maxSelectNumber: 1
      }).then((photoSelectResult: picker.PhotoSelectResult) => {
        resolve(photoSelectResult.photoUris[0]);
      }).catch((err: Error) => {
        reject(err)
      })
    })
  }

  private addEventListener(task: request.agent.Task, completeCallback: UploadCompleteCallback) {
    task.on('progress', (progress) => {
      hilog.info(0x0000, 'CloudStorage', 'on progress %{public}s', JSON.stringify(progress));
      this.updateProgress = progress.processed / progress.sizes[0] * 100;
    });
    task.on('completed', (progress) => {
      hilog.info(0x0000, 'CloudStorage', 'on completed %{public}s', JSON.stringify(progress));
      completeCallback(true);
    });
    task.on('response', (response) => {
      hilog.info(0x0000, 'CloudStorage', 'on response %{public}s', JSON.stringify(response));
    });
    task.on('failed', (progress) => {
      hilog.error(0x0000, 'CloudStorage', 'on failed %{public}s', JSON.stringify(progress));
      completeCallback(false);
    });
  }

  private onUploadCompleted(cloudPath: string, cacheFilePath: string) {
    return (uploadSuccess: boolean) => {
      if (uploadSuccess) {
        // show selected image and get download url when upload success
        this.showSelectedImage(cacheFilePath);
        this.getDownloadUrl(cloudPath);
      }
      // delete cache file when task finished
      hilog.info(0x0000, 'CloudStorage', 'delete cache file %{public}s', cacheFilePath);
      fileIo.unlink(cacheFilePath);
      this.isUploading = false;
    }
  }

  private copyFile(src: string, dest: string) {
    let srcFile = fileIo.openSync(src);
    let dstFile = fileIo.openSync(dest, fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE);
    fileIo.copyFileSync(srcFile.fd, dstFile.fd);
    fileIo.closeSync(srcFile);
    fileIo.closeSync(dstFile);
  }

  private initStates() {
    this.isUploading = true;
    this.updateProgress = 0;
    this.image = $r('app.media.empty_image');
    this.accessAddress = '';
    this.publicAddress = '';
  }

  private showSelectedImage(selectImageURL: string) {
    let imageFile = fileIo.openSync(selectImageURL, fileIo.OpenMode.READ_ONLY);
    image.createImageSource(imageFile.fd).createPixelMap({
      editable: true,
      desiredPixelFormat: 3,
    }).then(image => {
      this.image = image;
    })
  }

  private getDownloadUrl(path: string) {
    bucket.getDownloadURL(path).then(async (downloadURL: string) => {
      hilog.info(0x0000, 'CloudStorage', 'DownloadURL: %{public}s', downloadURL);
      this.accessAddress = downloadURL;
      this.publicAddress = downloadURL;
    }).catch((err: BusinessError) => {
      hilog.error(0x0000, 'CloudStorage', 'getDownloadURL fail, error code: %{public}d, message: %{public}s',
        err.code, err.message);
    });
  }
}
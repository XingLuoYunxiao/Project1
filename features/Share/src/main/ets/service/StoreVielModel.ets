import { cloudStorage } from '@kit.CloudFoundationKit';
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { fileIo as fs } from '@kit.CoreFileKit';
import { BusinessError, request } from '@kit.BasicServicesKit';

let bucket: cloudStorage.StorageBucket = cloudStorage.bucket(); // 将启动异步任务查询云侧默认实例

export class StoreViewModel{

  private static instance: StoreViewModel = new StoreViewModel();

  private constructor() {
    // 私有构造函数防止外部实例化
  }
  public static getInstance(): StoreViewModel {
    return StoreViewModel.instance;
  }
  // 只初始化一次云存储实例
  upload(uid:string,time:string):Promise<photoAccessHelper.PhotoSelectResult> {
    // 使用photoAccessHelper选择指定的文件
    let photoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
    photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE; // 过滤选择媒体文件类型为IMAGE
    photoSelectOptions.maxSelectNumber = 1; // 选择媒体文件的最大数目
    let photoViewPicker = new photoAccessHelper.PhotoViewPicker();
    return new Promise((resolve,reject)=>{
      photoViewPicker.select(photoSelectOptions).then((photoSelectResult: photoAccessHelper.PhotoSelectResult) => {
        let fileUri = photoSelectResult.photoUris[0];
        console.info(`pick file ${fileUri}`);
        let file = uid+time.replace(/\s/g, "").slice(0,20)
        // console.info(`file name ${fileName}`);
        let fileName = `share/moment/${file}.jpg`;
        let cacheFile = `${Date.now()}_${fileName}`;
        console.info(`cacheFile ${cacheFile}`);
        let cacheFilePath = getContext().cacheDir + '/' + cacheFile;

        // 将选中文件copy至cache目录下，文件名为cacheFile
        try {
          let srcFile = fs.openSync(fileUri);
          let dstFile = fs.openSync(cacheFilePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
          fs.copyFileSync(srcFile.fd, dstFile.fd);
          fs.closeSync(srcFile);
          fs.closeSync(dstFile);
        } catch (e) {
          console.info(`copy file failed ${e.message}`);
          return;
        }

        // 上传至云存储默认实例
        bucket.uploadFile(getContext(this), {
          localPath: cacheFile, // 本地文件路径，context.cacheDir目录下的文件
          cloudPath: fileName    // 云侧路径
        }).then((task: request.agent.Task) => {
          task.on('progress', (progress) => {
            console.info(`on progress ${JSON.stringify(progress)}`);
          });
          task.on('completed', (progress) => {
            console.info(`on completed ${JSON.stringify(progress)}`);
          });
          task.on('failed', (progress) => {
            console.error(`on failed ${JSON.stringify(progress)}`);
          });
          task.on('response', (response) => {
            console.info(`on response ${JSON.stringify(response)}`);
          });

          // start task
          task.start((err: BusinessError) => {
            if (err) {
              console.error(`Failed to start the uploadFile task, Code: ${err.code}, message: ${err.message}`);
            } else {
              console.info(`Succeeded in starting a uploadFile task.`);
            }
          });
        }).catch((err: BusinessError) => {
          console.error(`uploadFile failed, Code: ${err.code}, message: ${err.message}`);
        });
        resolve(photoSelectResult)
      });
    })
  }


  //获取云侧文件下载地址
  getUrl(uid:string,time:string):Promise<string> {
    // 获取云存储默认实例中screenshot_xxx.jpg文件的下载地址
    const url=uid+time.replace(/\s/g, "").slice(0,20)
    return new Promise((resolve,reject)=>{
      bucket.getDownloadURL(`share/moment/${url}.jpg`).then((downloadURL: string) => {
        resolve(downloadURL)
        console.info(`getDownloadURL: ${downloadURL}`);
      }).catch((err: BusinessError) => {
        console.error(`getDownloadURL failed, Code: ${err.code}, message: ${err.message}`);
      });
    })
  }
}

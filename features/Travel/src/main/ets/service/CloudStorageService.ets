import { cloudStorage } from "@kit.CloudFoundationKit";
import { BusinessError } from "@kit.BasicServicesKit";
import { request } from "@kit.BasicServicesKit";


export class CloudStorageService{
  private static instance: CloudStorageService = new CloudStorageService();
  private storageBucket: cloudStorage.StorageBucket = cloudStorage.bucket();

  private constructor(){
    if(!this.storageBucket){
      this.storageBucket = cloudStorage.bucket();
    }
  }

  public static getInstance():CloudStorageService{
    if(!CloudStorageService.instance){
      CloudStorageService.instance = new CloudStorageService();
    }
    return CloudStorageService.instance;
  }


  // 获取图片URL
  public getTravelSpotURL(url: string):Promise<string>{
    // cloudPath是云侧文件路径
    return new Promise((resolve, reject) => {
      this.storageBucket.getDownloadURL(`travel/spot/${url}.png`)
        .then((downloadURL: string) => {
          console.info(`downloadURL: ${downloadURL}`);
          resolve(downloadURL);
        })
        .catch((err: BusinessError) => {
          console.error(`getDownloadURL failed! Code: ${err.code}, message: ${err.message}`);
          reject(err);
        });
    })
  }

  //下载云侧文件至本地
  //TODO localPath不正确
  download(path: string) {
    // 获取云存储默认实例中fileName文件，保存至本地
    this.storageBucket.downloadFile(getContext(this), {
      cloudPath: path,        // 云侧文件路径
      localPath: path,   // 保存至本地文件路径
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
          console.error(`Failed to start the downloadFile task, Code: ${err.code}, message: ${err.message}`);
        } else {
          console.info(`Succeeded in starting a downloadFile task.`);
        }
      });
    }).catch((err: BusinessError) => {
      console.error(`Download file failed! Code: ${err.code}, message: ${err.message}`);
    });
  }

}
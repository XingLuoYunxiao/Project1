import { cloudStorage } from '@kit.CloudFoundationKit';
import { BusinessError, request } from '@kit.BasicServicesKit';
import { CloudStorageConstants } from '../common/constants/cloudStorageConstants';

export const storageBucket: cloudStorage.StorageBucket = cloudStorage.bucket();

export class CloudStorageService {
  //下载云侧文件至本地
  public download(cloudPath: string) {
    // 获取云存储默认实例中fileName文件，保存至本地
    storageBucket.downloadFile(getContext(this), {
      localPath: cloudPath, // 本地文件路径, 下载成功后，文件将会保存在context.cacheDir目录
      cloudPath: cloudPath  // 云侧文件路径
    }).then((task: request.agent.Task) => {
      task.on('progress', (progress) => {
        console.info(`on progress ${JSON.stringify(progress)} `);
      });
      task.on('completed', (progress) => {
        console.info(`on completed ${JSON.stringify(progress)} `);
      });
      task.on('failed', (progress) => {
        console.error(`on failed ${JSON.stringify(progress)} `);
      });
      task.on('response', (response) => {
        console.info(`on response ${JSON.stringify(response)} `);
      });
      task.start((err: BusinessError) => {
        if (err) {
          console.error(`Failed to start the downloadFile task, Code: ${err.code}, message: ${err.message}`);
        } else {
          console.info(`Succeeded in starting a downloadFile task. result: ${task.tid}`);
        }
      });
    }).catch((err: BusinessError) => {
      console.error(`downloadFile failed, Code: ${err.code}, message: ${err.message}`);
    });
  }
}
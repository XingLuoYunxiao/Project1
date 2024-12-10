import { cloudStorage } from "@kit.CloudFoundationKit";
import { common } from "@kit.AbilityKit";
import { BusinessError, request } from "@kit.BasicServicesKit";
import { fileIo as fs, } from '@kit.CoreFileKit';

let storageBucket: cloudStorage.StorageBucket = cloudStorage.bucket();

let context = getContext(this) as common.UIAbilityContext;

let cacheDir: string = context.cacheDir

@Component
export struct testPage {
  build() {
  }
}

export async function downloadImageListTest(Paths: string[]) {
  for (const item of Paths) {
    if (fs.accessSync(cacheDir + '/' + item)) {
      console.log(item + '已经存在')
    } else {

      downloadImage(item)
      console.log('downloadImage2正在下载' + item)
    }

  }
}


//下载云侧文件至本地
export async function downloadImage(path: string) {
  // 获取云存储默认实例中fileName文件，保存至本地
  storageBucket.downloadFile(getContext(context), {
    localPath: path, // 本地文件路径, 下载成功后，文件将会保存在context.cacheDir目录
    cloudPath: path // 云侧文件路径
  }).then((task: request.agent.Task) => {
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
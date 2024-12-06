import { cloudStorage } from '@kit.CloudFoundationKit';
import { BusinessError, request } from '@kit.BasicServicesKit';
import { CloudStorageConstants } from '../constants/cloudStorageConstants';
import { FileUtil } from 'utils/src/main/ets/puraUtils/FileUtil';
import { fileIo as fs, fileUri } from '@kit.CoreFileKit';
import { common } from '@kit.AbilityKit';
import { LogUtil } from 'utils/src/main/ets/puraUtils/LogUtil';

const TAG: string = "getImage "

let storageBucket: cloudStorage.StorageBucket = cloudStorage.bucket();

let context = getContext(this) as common.UIAbilityContext;

let cacheDirPath: string = context.cacheDir

@Component
export struct testPage {
  build() {
  }
}

export async function cacheImage() {
  LogUtil.debug('进入cacheImage()函数')
  let ImgPaths: string[] = FileUtil.listFileSync(cacheDirPath + '/' + CloudStorageConstants.dirPath)
  for (const item of CloudStorageConstants.constantsMap) {
    if (!ImgPaths.includes(item[1])) {
      download(CloudStorageConstants.dirPath + '/' + item[1])
      console.log(TAG, '正在下载' + item[1])
    } else {
      console.log(TAG, item[1] + '已经存在')
    }
  }
}

export async function downloadImage(map: Map<string, string>) {
  LogUtil.debug('进入downloadImage()函数')
  for (const item of map) {
    download(CloudStorageConstants.dirPath + '/' + item[1])
    console.log(TAG, '正在下载' + item[1])
  }
}

export async function downloadImage2(nums: string[]) {
  LogUtil.debug('进入downloadImage2()函数')
  for (const item of nums) {
    download(CloudStorageConstants.dirPath + '/' + item)
    console.log(TAG, '正在下载' + item)
  }
}


//下载云侧文件至本地
export async function download(path: string) {
  // 获取云存储默认实例中fileName文件，保存至本地
  storageBucket.downloadFile(getContext(context), {
    localPath: path, // 本地文件路径, 下载成功后，文件将会保存在context.cacheDir目录
    cloudPath: path // 云侧文件路径
  }).then((task: request.agent.Task) => {
    // task.on('progress', (progress) => {
    //   console.info(`on progress ${JSON.stringify(progress)} `);
    // });
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

export function builderImageMap() {
  //  + '/' + CloudStorageConstants.dirPath
  let ImgPaths: string[] = FileUtil.listFileSync(cacheDirPath + "/culture")
  LogUtil.print(ImgPaths)
  let ImgMap: Map<string, string> = new Map<string, string>()
  for (let index = 0; index < ImgPaths.length; index++) {
    const element = ImgPaths[index];
    ImgMap.set(element, fileUri.getUriFromPath(cacheDirPath + "/culture" + '/' + element))

  }
  console.log(TAG, 'ImgPathsMap:', JSON.stringify(ImgMap))
  console.log(TAG, 'ImgPathsMap:', JSON.stringify(Array.from(ImgMap)))
  AppStorage.setOrCreate("ImgPathsMap", ImgMap)
}


export function getPath(str: string | undefined): string {
  return fileUri.getUriFromPath(cacheDirPath + "/culture" + '/' + str)
}

// export async function httpRequest(url: string) {
//   { // 如沙箱里不存在地址，重新请求网络图片资源
//     http.createHttp()
//       .request(url, // 此处请填写一个具体的网络图片地址。
//         (error: BusinessError, data: http.HttpResponse) => {
//           if (error) {
//             // 下载失败时不执行后续逻辑
//             return;
//           }
//           // 处理网络请求返回的数据
//           if (http.ResponseCode.OK === data.responseCode) {
//             const imageData: ArrayBuffer = data.result as ArrayBuffer;
//             // 保存图片到应用沙箱
//             readWriteFileWithStream(url, imageData);
//           }
//         }
//       )
//   }
// }
//
// // 写入到沙箱
// async function readWriteFileWithStream(path: string, imageData: ArrayBuffer): Promise<void> {
//   let outputStream = fs.createStreamSync(path, 'w+');
//   await outputStream.write(imageData);
//   outputStream.closeSync();
// }
//
// export async function getURL(path: string): Promise<string | undefined> {
//   try {
//     const downloadURL = await storageBucket.getDownloadURL(path);
//     console.info(`downloadURL: ${downloadURL}`);
//     return downloadURL;
//   } catch (err) {
//     console.error(`getDownloadURL failed! Code: ${err.code}, message: ${err.message}`);
//     // 或者根据需求选择是否抛出错误
//     return undefined
//   }
// }







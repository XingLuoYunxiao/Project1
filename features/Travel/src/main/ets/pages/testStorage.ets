import { cloudStorage } from '@kit.CloudFoundationKit';
import { BusinessError, request } from '@kit.BasicServicesKit';

let storageBucket: cloudStorage.StorageBucket = cloudStorage.bucket();

@Builder
export function testStoragePageBuilder(name: string, param: Object) {
  testPage2()
}

@Component
export struct testPage2 {
  @State url: string = ''

  build() {
    NavDestination() {
      Column() {
        Text('从云端获取图片')
          .fontSize(24)
          .margin(30)
          .onClick(() => {
            this.getURL()
          })

        if (this.url !== '') {
          Image(this.url)
            .width(800)
        }

      }
    }
    .hideTitleBar(true)

  }

  getURL() {
    // cloudPath是云侧文件路径
    storageBucket.getDownloadURL('travel/spot/huaqingchi.png')
      .then((downloadURL: string) => {
        console.info(`downloadURL: ${downloadURL}`);
        this.url = downloadURL
      })
      .catch((err: BusinessError) => {
        console.error(`getDownloadURL failed! Code: ${err.code}, message: ${err.message}`);
      });
  }

  //下载云侧文件至本地
  download(path: string) {
    // 获取云存储默认实例中fileName文件，保存至本地
    storageBucket.downloadFile(getContext(this), {
      localPath: path, // 本地文件路径, 下载成功后，文件将会保存在context.cacheDir目录
      cloudPath: path // 云侧文件路径
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

// @Builder
// export function testPageBuilder() {
//   testPage()
// }
//
// const builderName = BuilderNameConstants.CULTURE_TEST
// if (!RouterModule.getBuilder(builderName)) {
//   const builder: WrappedBuilder<[object]> = wrapBuilder(testPageBuilder)
//   RouterModule.registerBuilder(builderName, builder)
// }
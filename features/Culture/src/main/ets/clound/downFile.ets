// import { cloudStorage } from '@kit.CloudFoundationKit';
// import { BusinessError, request } from '@kit.BasicServicesKit';
//
//
//
//
//   let bucket: cloudStorage.StorageBucket = cloudStorage.bucket();
//
//   // ArkUI上下文
//    bucket.downloadFile(getContext(this), {
//   cloudPath: "culture/富春山居图.jpg", // 云侧文件路径
//   localPath: cacheFile, // 保存至本地文件路径
// }, (err: BusinessError, task: request.agent.Task) => {
//   if (err) {
//     console.error(`Download file failed! Code: ${err.code}, message: ${err.message}`);
//     return;
//   }
//   task.on('progress', (progress) => {
//     console.info(`on progress ${JSON.stringify(progress)}`);
//   });
//   task.on('completed', (progress) => {
//     console.info(`on completed ${JSON.stringify(progress)}`);
//   });
//   task.on('failed', (progress) => {
//     console.error(`on failed ${JSON.stringify(progress)}`);
//   });
//   task.on('response', (response) => {
//     console.info(`on response ${JSON.stringify(response)}`);
//   });
//
//
//   // start task
//   task.start((err: BusinessError) => {
//     if (err) {
//       console.error(`Failed to start the downloadFile task, Code: ${err.code}, message: ${err.message}`);
//     } else {
//       console.info(`Succeeded in starting a downloadFile task.`);
//     }
//   });
// });
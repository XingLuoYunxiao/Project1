import { Database } from '@hw-agconnect/cloud';
import { cloudFunction } from '@kit.CloudFoundationKit';
import { FriendMoment } from './FriendMoment';
import { Comment } from './Comment';
import { cloudStorage } from '@kit.CloudFoundationKit';
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { fileIo as fs } from '@kit.CoreFileKit';
import { BusinessError, request } from '@kit.BasicServicesKit';
import { SpotParams } from 'travel/src/main/ets/model/SpotFuncParams';

let bucket: cloudStorage.StorageBucket = cloudStorage.bucket(); // 将启动异步任务查询云侧默认实例

// 模拟评论数据
export class Sharedata{
  private static instance: Sharedata = new Sharedata();
  private database: Database | null = null;

  private constructor() {
    // 私有构造函数防止外部实例化
  }
  public static getInstance(): Sharedata {
    return Sharedata.instance;
  }

  // async commentData(momentid:number):Promise<Comment[]> {
  //   return new Promise((resolve,reject)=>{
  //     cloudFunction.call({
  //       name: 'get-share-data',
  //       data:{
  //         type:'commentquery',
  //         data:{
  //           momentid:momentid
  //         }
  //       }
  //     }).then((value: cloudFunction.FunctionResult) => {
  //       resolve(JSON.parse(JSON.stringify(value.result)).data as Comment[])
  //       console.info(`成功666 ${JSON.stringify(value.result)}`);
  //     }).catch((err: BusinessError) => {
  //       console.error(`Failed to call the function, Code: ${err.code}, message: ${err.message}`);
  //     })
  //   })
  // }

  //添加
  async addshareData(data:FriendMoment){
    cloudFunction.call({
      name: 'get-share-data',
      data: {
        moment:data,
        type:'addshare'
      }
    }).then((value: cloudFunction.FunctionResult) => {
      console.info(`成功添加 ${JSON.stringify(value.result)}`);
    }).catch((err: BusinessError) => {
      console.error(`添加失败, Code: ${err.code}, message: ${err.message}`);
    })
  }

  async addcommentData(commentdata:Comment){
    cloudFunction.call({
      name: 'get-share-data',
      data: {
        comment:commentdata,
        type:'addcomment'
      }
    }).then((value: cloudFunction.FunctionResult) => {
      console.info(`成功添加 ${JSON.stringify(value.result)}`);
    }).catch((err: BusinessError) => {
      console.error(`添加失败, Code: ${err.code}, message: ${err.message}`);
    })
  }

  //修改
  // async updateshareData(data:Comment){
  //   cloudFunction.call({
  //     name: 'get-share-data',
  //     data: {
  //       update:data,
  //       type:'update'
  //     }
  //   }).then((value: cloudFunction.FunctionResult) => {
  //     console.info(`成功修改 ${JSON.stringify(value.result)}`);
  //   }).catch((err: BusinessError) => {
  //     console.error(`修改失败, Code: ${err.code}, message: ${err.message}`);
  //   })
  // }

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
        let fileName = `share/moment/${file}.png`;
        let cacheFile = `${Date.now()}.png`;
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
          cloudPath: fileName,    // 云侧路径
          metadata:{contentType:'image/png'}
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
  getUrl(imgurl:string):Promise<string> {
    // 获取云存储默认实例中screenshot_xxx.jpg文件的下载地址
    return new Promise((resolve,reject)=>{
      // bucket.getDownloadURL(`${imgurl}.png`)
      bucket.getDownloadURL(`travel/spot/baiyunshan.png`)
        .then((downloadURL: string) => {
        resolve(downloadURL)
        console.info(`getDownloadURL: ${downloadURL}`);
      }).catch((err: BusinessError) => {
        console.error(`getDownloadURL failed, Code: ${err.code}, message: ${err.message}`);
      });
    })
  }
}

//查询
@Concurrent
export async function shareData(){
  try {
    const value=await cloudFunction.call({
      name: 'get-share-data',
      data:{
        type:'sharequery'
      }
    })
    return JSON.parse(JSON.stringify(value.result)).data as FriendMoment[]
  } catch (e) {
    console.error('查询朋友圈失败')
  }
  return []
}

//并发查询
@Concurrent
export async function queryCollection(condition:string){
  try{
    let params:SpotParams = {
      type: 'query',
      filter: [
        {name:`${condition}`}
      ]
    }
    const res = await cloudFunction.call({ name: 'get-spot-data', data: params})
    let data = res.result
    return JSON.parse(JSON.stringify(data)).data
  }catch (e){
    console.error('[SpotModel]', 'SpotModel getSpotDataByCondition failed', e);
  }
  return []
}

//评论查询
@Concurrent
export async function queryComment(momentid:string){
  try{
    const comments=await cloudFunction.call({
      name: 'get-share-data',
      data:{
        type:'commentquery',
        momentid:momentid
      }
    })
    return JSON.parse(JSON.stringify(comments.result)).data as Comment[]
  }catch (e){
    console.error('查询朋友圈失败')
  }
  return []
}



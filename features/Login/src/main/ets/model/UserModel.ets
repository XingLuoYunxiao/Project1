import cloud, { Database, SignInResult, VerifyCodeAction, VerifyCodeResult } from "@hw-agconnect/cloud"
import { myOrder } from "./myOrder";
import { mySpot } from "./mySpot";
import { Poem } from "./Poem";
import { Collection } from "./Collection";
import { BrowsingHistory } from "./BrowsingHistory";
import { cloudCommon, cloudFunction } from '@kit.CloudFoundationKit';
import { BusinessError, request } from '@kit.BasicServicesKit';
import auth from "@hw-agconnect/auth";
import { cloudStorage } from '@kit.CloudFoundationKit';
import { fileIo as fs } from '@kit.CoreFileKit';
import { Params } from "travel/src/main/ets/model/FuncParams";
import { User } from "./User";
import { photoAccessHelper } from "@kit.MediaLibraryKit";
import { common } from "@kit.AbilityKit";
import { buffer } from "@kit.ArkTS";
import { fileUri } from '@kit.CoreFileKit';


let bucket: cloudStorage.StorageBucket = cloudStorage.bucket();

export class UserModel{
  private static instance: UserModel = new UserModel();
  private database: Database | null = null;

  private constructor() {
    // 私有构造函数防止外部实例化
  }
  public static getInstance(): UserModel {
    return UserModel.instance;
  }

  async goLogin(code:string,phoneNumber:string): Promise<SignInResult>{
       const user= await auth.signIn({
          credentialInfo: {
            kind: 'phone',
            phoneNumber: phoneNumber,
            countryCode: '86',
            verifyCode: code
          }
        })
    return user;
  }

  getCode(phoneNumber:string){
    return new Promise<VerifyCodeResult>((resolve, reject) => {
    auth.requestVerifyCode({
      //手机验证码还是邮箱验证码
      verifyCodeType: {
        kind: 'phone',
        phoneNumber: phoneNumber,
        countryCode: '86'
      },
      //登录时发送验证码还是重置密码时
      action: VerifyCodeAction.REGISTER_LOGIN,
      lang: 'zh_CN',
      //默认就是60秒
      sendInterval: 60
    })
    })
  }

  //添加用户信息
  async addUser(user:User){
    cloudFunction.call({
      name:'get-hiscol-data',
      data:{
        table:'userAdd',
        user:user
      }
    }).then((value: cloudFunction.FunctionResult) => {
      console.info(`成功添加 ${JSON.stringify(value.result)}`);
    }).catch((err: BusinessError) => {
      console.error(`添加失败, Code: ${err.code}, message: ${err.message}`);
    })
  }

  //查询用户信息
  async getuserData(userid:string): Promise<User[]>{
    return new Promise((resolve,reject)=>{
      cloudFunction.call({
        name: 'get-hiscol-data',
        data: {
          personUid:userid,
          table:'userQuery'
        }
      }).then((value: cloudFunction.FunctionResult) => {
        resolve(JSON.parse(JSON.stringify(value.result)).data as User[])
        console.info(`成功666 ${JSON.stringify(value.result)}`);
      }).catch((err: BusinessError) => {
        console.error(`Failed to call the function, Code: ${err.code}, message: ${err.message}`);
      })
    })
  }

  //修改用户信息
  async updateUser(info:string,uid:string){
    cloudFunction.call({
      name: 'get-hiscol-data',
      data:{
        table:'updateUser',
        info:info,
        uid:uid,
      }
    }).then((value: cloudFunction.FunctionResult) => {
      console.info(`成功更新 ${JSON.stringify(value.result)}`);
    }).catch((err: BusinessError) => {
      console.error(`更新失败, Code: ${err.code}, message: ${err.message}`);
    })
  }

  async outlogin(){
      await auth.signOut()
  }

  async getorderData(personUid: string): Promise<myOrder[]>{
    return new Promise((resolve,reject)=>{
      cloudFunction.call({
        name: 'get-hiscol-data',
        data: {
          personUid:personUid,
          fiel:'user_id',
          sort:'order_id',
          table:'myOrder'
        }
      }).then((value: cloudFunction.FunctionResult) => {
        resolve(JSON.parse(JSON.stringify(value.result)).data as myOrder[])
        console.info(`成功666 ${JSON.stringify(value.result)}`);
      }).catch((err: BusinessError) => {
        console.error(`Failed to call the function, Code: ${err.code}, message: ${err.message}`);
      })
    })
  }

  async getspotData(spotid:number): Promise<mySpot[]>{
    return new Promise((resolve,reject)=>{
      cloudFunction.call({
        name: 'get-hiscol-data',
        data: {
          personUid:spotid,
          fiel:'id',
          sort:'id',
          table:'mySpot'
        }
      }).then((value: cloudFunction.FunctionResult) => {
        resolve(JSON.parse(JSON.stringify(value.result)).data as mySpot[])
        console.info(`成功666 ${JSON.stringify(value.result)}`);
      }).catch((err: BusinessError) => {
        console.error(`Failed to call the function, Code: ${err.code}, message: ${err.message}`);
      })
    })
  }

  uploaddefault(uid:string,defaulturi:string){
    let context = getContext(this) as common.UIAbilityContext;
    const filePath = context.filesDir + "/1.png";
    const fin=fileUri.getUriFromPath(filePath);
    console.info('download complete'+fin+filePath);
    let url = defaulturi;
    try {
      request.downloadFile(context, { url: url, filePath: filePath}).then((downloadTask: request.DownloadTask) => {
        downloadTask.on('complete', () => {
          console.info('download complete');
          let file = fs.openSync(filePath, fs.OpenMode.READ_WRITE);
          let arrayBuffer = new ArrayBuffer(1024);
          let readLen = fs.readSync(file.fd, arrayBuffer);
          let buf = buffer.from(arrayBuffer, 0, readLen);
          console.info(`content of File: ${buf.toString()}`);
          fs.closeSync(file);
        })
        downloadTask.getTaskInfo().then((info)=>{
          const final=info.fileName
          console.log('终于'+final)
        })
      }).catch((err: BusinessError) => {
        console.error(`downLoadFileTask failed, code is ${err.code}, message is ${err.message}`);
      });
    } catch (error) {
      console.error(`downLoadFileTask failed, code is ${error.code}, message is ${error.message}`);
    }

    // console.log('默认3'+defaulturi+uid)
    //file://media/Photo/16/IMG_1734618404_013/IMG_013.jpg
        let fileri =fin;
        console.info(`pick file1 ${fileri}`);
        let file = uid
        let cacheFile = `${Date.now()}.png`;
        let cacheFilePath = getContext().cacheDir + '/' + cacheFile;
        let fileName = `share/comment/${file}.png`;
        // 将选中文件copy至cache目录下，文件名为cacheFile
        try {
          let srcFile = fs.openSync(fileri);
          let dstFile = fs.openSync(cacheFilePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
          fs.copyFileSync(srcFile.fd, dstFile.fd);
          fs.closeSync(srcFile);
          fs.closeSync(dstFile);
        } catch (e) {
          console.info(`copy file 失败 ${e.message}`);
          return;
        }

        // 上传至云存储默认实例
        bucket.uploadFile(getContext(this), {
          localPath: cacheFile, // 本地文件路径，context.cacheDir目录下的文件
          cloudPath: fileName,    // 云侧路径
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
  }

  upload(uid:string,info:string) {
        let fileUri = info;
        let file = uid;
        let cacheFile = `${Date.now()}.png`;
        let cacheFilePath = getContext().cacheDir + '/' + cacheFile;
        let fileName = `share/comment/${file}.png`;
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
  }

  getUrl(img:string):Promise<string> {
    return new Promise((resolve,reject)=>{
      bucket.getDownloadURL(`travel/spot/${img}.png`).then((downloadURL: string) => {
        resolve(downloadURL)
        console.info(`getDownloadURL: ${downloadURL}`);
      }).catch((err: BusinessError) => {
        resolve('')
        console.error(`getDownloadURL failed, Code: ${err.code}, message: ${err.message}`);
      });
    })
  }

  getuserUrl(img:string):Promise<string> {
    return new Promise((resolve,reject)=>{
      bucket.getDownloadURL(`share/comment/${img}.png`).then((downloadURL: string) => {
        resolve(downloadURL)
        console.info(`getDownloadURL: ${downloadURL}`);
      }).catch((err: BusinessError) => {
        resolve('')
        console.error(`getDownloadURL failed, Code: ${err.code}, message: ${err.message}`);
      });
    })
  }

  deletecloud(cloudPath:string){
    bucket.deleteFile(cloudPath).then(() => {
      console.info('delete file success.');
    }).catch((err: BusinessError) => {
      console.error(`delete file failed! Code: ${err.code}, message: ${err.message}`);
    });
  }

  async getpoemData(poemid:number): Promise<Poem[]>{
    return new Promise((resolve,reject)=>{
      cloudFunction.call({
        name: 'get-hiscol-data',
        data: {
          personUid:poemid,
          fiel:'id',
          sort:'id',
          table:'Poem'
        }
      }).then((value: cloudFunction.FunctionResult) => {
        resolve(JSON.parse(JSON.stringify(value.result)).data as Poem[])
        console.info(`成功666 ${JSON.stringify(value.result)}`);
      }).catch((err: BusinessError) => {
        console.error(`Failed to call the function, Code: ${err.code}, message: ${err.message}`);
      })
    })
  }

 async getcollectData(personUid: string,pageNum:number): Promise<Collection[]>{
      return new Promise((resolve,reject)=>{
        cloudFunction.call({
          name: 'get-hiscol-data',
          data: {
            personUid:personUid,
            fiel:'userId',
            sort:'id',
            table:'Collection',
            pageNum:pageNum
          }
        }).then((value: cloudFunction.FunctionResult) => {
          resolve(JSON.parse(JSON.stringify(value.result)).data as Collection[])
          console.info(`成功666 ${JSON.stringify(value.result)}`);
        }).catch((err: BusinessError) => {
          console.error(`Failed to call the function, Code: ${err.code}, message: ${err.message}`);
        })
      })
  }

  //收藏删除
  async deletecollectData(spotid:number,personUid:string){
    cloudFunction.call({
      name: 'get-hiscol-data',
      data: {
        personUid:personUid,
        //条件
        fiel:spotid,
        sort:'Collection',
        table:'delete'
      }
    }).then((value: cloudFunction.FunctionResult) => {
      console.info(`收藏成功删除 ${JSON.stringify(value.result)}`);
    }).catch((err: BusinessError) => {
      console.error(`收藏删除失败, Code: ${err.code}, message: ${err.message}`);
    })
  }

  //历史删除
  async deletehistoryData(id:number,personUid:string){
    cloudFunction.call({
      name: 'get-hiscol-data',
      data: {
        personUid:personUid,
        //条件
        fiel:id,
        sort:'BrowsingHistory',
        table:'hisdelete'
      }
    }).then((value: cloudFunction.FunctionResult) => {
      console.info(`历史成功删除 ${JSON.stringify(value.result)}`);
    }).catch((err: BusinessError) => {
      console.error(`历史删除失败, Code: ${err.code}, message: ${err.message}`);
    })
  }

  //添加收藏
  async addcollectData(spotid:number,personUid:string,type:string){
    cloudFunction.call({
      name: 'get-hiscol-data',
      data: {
        personUid:personUid,
        fiel:spotid,
        sort:type,
        table:'collectadd'
      }
    }).then((value: cloudFunction.FunctionResult) => {
      console.info(`成功添加 ${JSON.stringify(value.result)}`);
    }).catch((err: BusinessError) => {
      console.error(`添加失败, Code: ${err.code}, message: ${err.message}`);
    })
  }


  async gethistoryData(personUid: string,date:Date,pageNum:number): Promise<BrowsingHistory[]>{
    return new Promise((resolve,reject)=>{
      cloudFunction.call({
        name: 'get-hiscol-data',
        data: {
          date:date,
          personUid:personUid,
          fiel:'userId',
          sort:'viewTime',
          table:'BrowsingHistory',
          pageNum:pageNum
        }
      }).then((value: cloudFunction.FunctionResult) => {
        resolve(JSON.parse(JSON.stringify(value.result)).data as BrowsingHistory[])
        console.info(`成功666 ${JSON.stringify(value.result)}`);
      }).catch((err: BusinessError) => {
        console.error(`Failed to call the function, Code: ${err.code}, message: ${err.message}`);
      })
    })
  }

}


//并发查询
@Concurrent
export async function queryCollection(condition:string){
  try{
    let params:Params = {
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
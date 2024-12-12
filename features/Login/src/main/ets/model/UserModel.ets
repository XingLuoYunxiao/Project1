import cloud, { Database, SignInResult, VerifyCodeAction, VerifyCodeResult } from "@hw-agconnect/cloud"
import { myOrder } from "./myOrder";
import { mySpot } from "./mySpot";
import { Poem } from "./Poem";
import { Collection } from "./Collection";
import { CollectionAdd } from "./CollectionAdd";
import { BrowsingHistory } from "./BrowsingHistory";
import { cloudCommon, cloudFunction } from '@kit.CloudFoundationKit';
import { BusinessError, request } from '@kit.BasicServicesKit';
import auth from "@hw-agconnect/auth";
import { cloudStorage } from '@kit.CloudFoundationKit';

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

  getUrl(img:string):Promise<string> {
    return new Promise((resolve,reject)=>{
      // 获取云存储默认实例中screenshot_xxx.jpg文件的下载地址
      bucket.getDownloadURL(`travel/spot/${img}.png`).then((downloadURL: string) => {
        resolve(downloadURL)
        console.info(`getDownloadURL: ${downloadURL}`);
      }).catch((err: BusinessError) => {
        resolve('')
        console.error(`getDownloadURL failed, Code: ${err.code}, message: ${err.message}`);
      });
    })
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

 async getcollectData(personUid: string): Promise<Collection[]>{
      return new Promise((resolve,reject)=>{
        cloudFunction.call({
          name: 'get-hiscol-data',
          data: {
            personUid:personUid,
            fiel:'userId',
            sort:'id',
            table:'Collection'
          }
        }).then((value: cloudFunction.FunctionResult) => {
          resolve(JSON.parse(JSON.stringify(value.result)).data as Collection[])
          console.info(`成功666 ${JSON.stringify(value.result)}`);
        }).catch((err: BusinessError) => {
          console.error(`Failed to call the function, Code: ${err.code}, message: ${err.message}`);
        })
      })
  }

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
      console.info(`成功删除 ${JSON.stringify(value.result)}`);
    }).catch((err: BusinessError) => {
      console.error(`删除失败, Code: ${err.code}, message: ${err.message}`);
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


  async gethistoryData(personUid: string): Promise<BrowsingHistory[]>{
    return new Promise((resolve,reject)=>{
      cloudFunction.call({
        name: 'get-hiscol-data',
        data: {
          personUid:personUid,
          fiel:'userId',
          sort:'viewTime',
          table:'BrowsingHistory'
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
import cloud, { Database, SignInResult, VerifyCodeAction, VerifyCodeResult } from "@hw-agconnect/cloud"
import { myOrder } from "./myOrder";
import schema from '../../resources/rawfile/schema.json'
import { mySpot } from "./mySpot";
import { Poem } from "./Poem";
import { Collection } from "./Collection";
import { CollectionAdd } from "./CollectionAdd";
import { BrowsingHistory } from "./BrowsingHistory";
import { cloudCommon } from '@kit.CloudFoundationKit';
import { request } from '@kit.BasicServicesKit';
import auth from "@hw-agconnect/auth";

let authProvider =  auth.getAuthProvider();
authProvider.getAccessToken(false)

cloudCommon.init({
  region: cloudCommon.CloudRegion.CHINA,
  authProvider: authProvider,
  functionOptions:{timeout:10*1000},
  storageOptions:{mode:request.agent.Mode.BACKGROUND, network:request.agent.Network.ANY},
  databaseOptions:{schema:"schema", traceId:"traceId"}
})

export class UserModel{
  private static instance: UserModel = new UserModel();
  private database: Database | null = null;
  private poemPoint :number=0;
  private classicPoint :number=0;
  private artPoint :number=0;

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

  async getorderData( personUid: string): Promise<myOrder[]>{
    this.database = cloud.database({
      zoneName: "Travel",
      objectTypeInfo: schema
    })

    const itemlist =await this.database.collection(myOrder)//选择表
      .query()
      .equalTo('user_id',personUid)
      .orderByDesc('order_id')
      .get()

    return itemlist
  }

  async getspotData(spotid:number): Promise<mySpot[]>{
    this.database = cloud.database({
      zoneName: "Travel",
      objectTypeInfo: schema
    })

    const itemlist =await this.database.collection(mySpot)//选择表
      .query()
      .equalTo('id', spotid)
      .get()

    return itemlist
  }

  async getpoemData(poemid:number): Promise<Poem[]>{
    this.database = cloud.database({
      zoneName: "Travel",
      objectTypeInfo: schema
    })

    const itemlist =await this.database.collection(Poem)//选择表
      .query()
      .equalTo('numId', poemid)
      .get()

    return itemlist
  }

 async getcollectData(personUid: string): Promise<Collection[]>{
    this.database = cloud.database({
      zoneName: "Travel",
      objectTypeInfo: schema
    })

    const itemlist =await this.database.collection(Collection)//选择表
      .query()
      .equalTo('userId',personUid)
      .get()

    return itemlist
  }

  async deletecollectData(cur:CollectionAdd){
   this.database = cloud.database({
     zoneName: "Travel",
     objectTypeInfo: schema
   })
    const del=await this.getspotData(cur.spotId)
   await this.database.collection(Collection)//选择表
     .delete(del[0]).then((val)=>{
       console.log('删除1',val)
     }).catch((e:Error)=>{
       console.log('删除',e.name,e.message)
     })
   //  databaseZone.delete(del[0])
   //    .then((val)=>{
   //          console.log('删除1',val)
   //        }).catch((e:Error)=>{
   //          console.log('删除',e.name,e.message)
   //        })
  }

  async gethistoryData(personUid: string): Promise<BrowsingHistory[]>{
    this.database = cloud.database({
      zoneName: "Travel",
      objectTypeInfo: schema
    })

    const itemlist =await this.database.collection(BrowsingHistory)//选择表
      .query()
      .equalTo('userId',personUid)
      .orderByDesc('viewTime')
      .get()

    return itemlist
  }


}
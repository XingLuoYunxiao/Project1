import { Database } from '@hw-agconnect/cloud';
import { cloudFunction } from '@kit.CloudFoundationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { FriendMoment } from './FriendMoment';
import { Comment } from './Comment';


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
  //查询
  async shareData():Promise<FriendMoment[]> {
    return new Promise((resolve,reject)=>{
      cloudFunction.call({
        name: 'get-share-data',
        data:{
          type:'sharequery'
        }
      }).then((value: cloudFunction.FunctionResult) => {
        resolve(JSON.parse(JSON.stringify(value.result)).data as FriendMoment[])
        console.info(`成功666 ${JSON.stringify(value.result)}`);
      }).catch((err: BusinessError) => {
        console.error(`Failed to call the function, Code: ${err.code}, message: ${err.message}`);
      })
    })
  }

  async commentData(momentid:number):Promise<Comment[]> {
    return new Promise((resolve,reject)=>{
      cloudFunction.call({
        name: 'get-share-data',
        data:{
          type:'commentquery',
          data:{
            momentid:momentid
          }
        }
      }).then((value: cloudFunction.FunctionResult) => {
        resolve(JSON.parse(JSON.stringify(value.result)).data as Comment[])
        console.info(`成功666 ${JSON.stringify(value.result)}`);
      }).catch((err: BusinessError) => {
        console.error(`Failed to call the function, Code: ${err.code}, message: ${err.message}`);
      })
    })
  }

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
}


import { queryCollection, UserModel } from "../model/UserModel";
import { hilog } from "@kit.PerformanceAnalysisKit";
import { Collection } from "../model/Collection";
import { CollectionAdd } from "../model/CollectionAdd";
import { BrowsingHistory } from "../model/BrowsingHistory";
import { ListDataSource } from "./ListDataSource";
import { HistoryAdd } from "../model/HistoryAdd";
import { myOrderAdd } from "../model/myOrderAdd";
import { myOrder} from "../model/myOrder";
import lpreferencesUtil from "../common/utils/PreferenceUtil";
import { taskpool as taskPool } from '@kit.ArkTS';
import { Spot } from "travel";


@Observed
export class MineViewModel{
  personName:string=''
  personPhoto:string=''
  phoneNumber:string=''
  personUid:string=''
  userModel: UserModel = UserModel.getInstance()
  collectspotListData: ListDataSource<CollectionAdd> = new ListDataSource();
  collectpoemListData: ListDataSource<CollectionAdd> = new ListDataSource();
  historyspotListData:ListDataSource<HistoryAdd> = new ListDataSource();
  historypoemListData:ListDataSource<HistoryAdd> = new ListDataSource();
  orderListData: ListDataSource<myOrderAdd> = new ListDataSource();
  waitListData: ListDataSource<myOrderAdd> = new ListDataSource();
  pageNum: number = 1;
  none:number=0

  private static instance: MineViewModel = new MineViewModel();

  private constructor() {
    // 私有构造函数防止外部实例化
  }
  public static getInstance(): MineViewModel {
    return MineViewModel.instance;
  }

  codeDeal(phoneNumber:string){
    this.userModel.getCode(phoneNumber)
      .then((codeResult) => {
        hilog.info(1, '验证码发送成功', JSON.stringify(codeResult.getValidityPeriod()))
      }).catch((error: Error) => {
      hilog.error(0, '验证码发送失败', JSON.stringify(error))
    })
  }

  async loginDeal(code:string,phoneNumber:string){
    await this.userModel.goLogin(code,phoneNumber)
      .then(user => {
        //登录成功
        this.personUid=user.getUser().getUid()
        this.phoneNumber = user.getUser().getPhone().slice(4)
        //第一次登录.自动根据手机号码设置.即只要注册登录过就拥有用户名
        if (user.getUser().getDisplayName() == undefined) {
          const initname = 'GYYZ_' + this.phoneNumber.slice(0, 3) + '****' + this.phoneNumber.slice(7)
          user.getUser()
            .updateProfile({
              displayName: initname,
              photoUrl: "https://tse3-mm.cn.bing.net/th/id/OIP-C.VMyV_ymHWH14JQ3RPoezwgHaFj?rs=1&pid=ImgDetMain"
            })
            .then(() => {
              console.log('初次修改昵称头像成功')
            })
            .catch((e: Error) => {
              hilog.error(0, '初次修改信息失败', JSON.stringify(e));
            })
        }
        this.personName = user.getUser().getDisplayName()
        this.personPhoto = user.getUser().getPhotoUrl()
        lpreferencesUtil.putPreferenceValue('UserInfoPreference','personUid',this.personUid)
        lpreferencesUtil.putPreferenceValue('UserInfoPreference','personPhoto',this.personPhoto)
        lpreferencesUtil.putPreferenceValue('UserInfoPreference','personName',this.personName)
      }).catch((error: Error) => {
      //登录失败
      console.log('登录失败', JSON.stringify(error))
    })
  }

  reset(){
    this.pageNum=1
    this.none=0
    this.collectspotListData.notifyDataDeleteAll()
    this.collectpoemListData.notifyDataDeleteAll()
  }
  async collectionDeal(personUid:string){
    this.userModel.getcollectData(personUid,this.pageNum)
      .then(async (value: Collection[])=>{
        this.pageNum++
        const spotresult: Array<CollectionAdd> = [];
        const poemresult: Array<CollectionAdd> = [];
        for (let index = 0; index < value.length; index++) {
          //遍历的每一项
          const cur=value[index]
          if(cur.type=="spot"){
            const spots=await this.userModel.getspotData(cur.spotId)
            const img= await this.userModel.getUrl(spots[0].imageUrl)
            spotresult.push(new CollectionAdd(cur.id,cur.spotId,cur.userId,cur.type,spots[0].name,img,false,spots[0].rating,spots[0].ticketPrice,spots[0].openingHours,spots[0].areaName))
          }else{
            const poems=await this.userModel.getpoemData(cur.spotId)
            poemresult.push(new CollectionAdd(cur.id,cur.spotId,cur.userId,cur.type,poems[0].title,poems[0].writer,false))
          }
        }
        if(spotresult.length<10){
          this.none=1
        }
        this.collectspotListData.appendArrayData(spotresult)
        this.collectpoemListData.appendArrayData(poemresult)
      })
  }
//收藏删除
  async collectiondelete(spotid:number,personid:string){
    await this.userModel.deletecollectData(spotid,personid)
  }
//历史删除
  async historydelete(id:number,personid:string){
    await this.userModel.deletehistoryData(id,personid)
  }

  async historyDeal(personUid:string,date:Date){
     this.userModel.gethistoryData(personUid,date)
      .then(async (value:BrowsingHistory[])=>{
        this.historyspotListData.notifyDataDeleteAll()
        this.historypoemListData.notifyDataDeleteAll()
        for (let index = 0; index < value.length; index++) {
          const cur=value[index]
            if(cur.type=='spot'){
              const spots=await this.userModel.getspotData(cur.spotId)
              const img= await this.userModel.getUrl(spots[0].imageUrl)
              const pushdata=new HistoryAdd(cur.id,cur.spotId,cur.viewTime,cur.viewCount,cur.type,cur.userId,cur.poemId,spots[0].name,img,false)
              this.historyspotListData.pushData(pushdata)
              this.historyspotListData.notifyDataReload()
            }else{
              const poem=await this.userModel.getpoemData(cur.spotId)
              this.historypoemListData.pushData(new HistoryAdd(cur.id,cur.spotId,cur.viewTime,cur.viewCount,cur.type,cur.userId,cur.poemId,poem[0].title,poem[0].writer,false))
            }
        }
      })
  }


  async orderDeal(personUid:string){
    await this.userModel.getorderData(personUid)
      .then((val:myOrder[])=>{
        this.orderListData.notifyDataDeleteAll()
        this.waitListData.notifyDataDeleteAll()
        val.map(async (value)=>{
          const spots=await this.userModel.getspotData(value.spot_id)
          const img= await this.userModel.getUrl(spots[0].imageUrl)
          if (value.order_type==0) {
            this.waitListData.pushData(new myOrderAdd(value.order_id,value.spot_id,value.order_time,value.order_status,value.total_amount,value.quantity,value.order_type,value.user_id,spots[0].name,img,spots[0].ticketPrice))
          }
          this.orderListData.pushData(new myOrderAdd(value.order_id,value.spot_id,value.order_time,value.order_status,value.total_amount,value.quantity,value.order_type,value.user_id,spots[0].name,img,spots[0].ticketPrice))
        })
      })
  }


  //使用taskPool执行查询任务（收藏查询）
  async taskPoolExecuteQuery(condition:string): Promise<Array<Spot>> {
    try {
      //创建任务
      let task: taskPool.Task = new taskPool.Task(queryCollection, condition); // query函数调用 需使用装饰器@Concurrent
      let result: Array<Spot> = await taskPool.execute(task) as Array<Spot>;
      return result;
    } catch (err) {
      console.error('taskPoolQuery', 'query error:' + `${err}`);
      return [];
    }
  }

  //我的瀑布流图片获取
  async waterList(img:string):Promise<string>{
    return await this.userModel.getUrl(img)
  }
}




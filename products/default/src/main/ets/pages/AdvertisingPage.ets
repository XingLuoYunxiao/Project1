import router from '@ohos.router'
import { Spot } from 'travel'
import { SpotNetFunc } from 'travel/src/main/ets/service/SpotNetFunc'
import { LocationUtil } from 'utils'
import { cloudFunction } from '@kit.CloudFoundationKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { Params } from '../common/Params'

const domain = 0x1111
/*
* 广告页面
* */
@Entry
@Component
struct AdvertisingPage {
  @State countDownSeconds: number = 4
  private timeId: number = 0
  /**
   * 跳转到 APP 首页面
   */

  async aboutToAppear(){
    let cityName = (await LocationUtil.getInstance().getCityName()).substring(0, 2)
    this.functionPreload(cityName).then( (data:Spot[]) => {
      SpotNetFunc.getInstance().spots = data
    })
  }
  //预加载
  async functionPreload(cityName:string): Promise<Spot[]> {
    return new Promise((resolve, reject) => {
      try{
        let params: Params = {
          type: 'query',
          filter: [
            {cityName: cityName},
            {category: '全部分类'}
          ],
        }
        let res =  cloudFunction.call({
          name: 'get-spot-data',
          data: params,
          //timeout: 3 * 1000, // 获取缓存数据的超时时间
          //loadMode: cloudFunction.LoadMode.PRELOAD   // 获取缓存数据必须设置为PRELOAD
        })
        res.then((data: cloudFunction.FunctionResult) => { // 接口调用成功处理缓存的应用数据
          hilog.info(0x0000, 'testTag', 'get preload cache successfully');
          let spots = data.result
          resolve(JSON.parse(JSON.stringify(spots)).data as Spot[])
        }).catch((err: Error) => {
          hilog.error(0x0000, 'testTag', 'fail to get preload cache: %{public}s', err.message);
          resolve(this.functionNormal(cityName)); // 使用普通方式获取应用数据
        });
      }catch (error){
        hilog.error(domain, 'SpotModel getSpotDataByCondition failed', error);
        reject(error)
      }
    })
  }

  functionNormal(cityName:string): Promise<Spot[]>{
    return new Promise((resolve, reject) => {
      try{
        let params: Params = {
          type: 'query',
          filter: [
            {cityName: cityName},
            {category: '全部分类'}
          ],
        }
        let res =  cloudFunction.call({
          name: 'get-spot-data',
          data: params,
          timeout: 1 * 5000, // 获取缓存数据的超时时间
          loadMode: cloudFunction.LoadMode.NORMAL   // 默认为NORMAL, 接口会调用云函数从云服务器获取应用数据
        })
        res.then((data: cloudFunction.FunctionResult) => { // 接口调用成功处理缓存的应用数据
          hilog.info(0x0000, 'testTag', 'get preload cache successfully');
          let spots = data.result
          resolve(JSON.parse(JSON.stringify(spots)).data as Spot[])
        }).catch((err: Error) => {
          hilog.error(0x0000, 'testTag', 'fail to get preload cache: %{public}s', err.message);
        });
      }catch (error){
        hilog.error(domain, 'SpotModel getSpotDataByCondition failed', error);
        reject(error)
      }
    })
  }

  jumpToAppHomePage() {
    router.replaceUrl({
      url: 'pages/Index'
    })
  }

  judgeToCount(){
    this.countDownSeconds -= 1
    if( this.countDownSeconds === 0){
      this.jumpToAppHomePage()
    }
  }

  //页面显示
  onPageShow() {
    //setInterval()重复调用一个函数，在每次调用之间具有固定的时间延迟。
    this.timeId = setInterval( () => {
      this.judgeToCount()
    }, 1000)

  }

  //页面隐藏
  onPageHide() {
    //清除所有历史页面并仅保留堆栈顶部的当前页面
    //取消通过 setInterval()设置的重复定时任务
    clearInterval(this.timeId)
  }

  build() {
    //层叠布局
    Stack({ alignContent: Alignment.Top }) {
      Image($r("app.media.advertise_image"))
        .objectFit(ImageFit.Fill)
      Row(){
        Text(`跳过 ${this.countDownSeconds}`)
          .padding({left:18})
          .width(100)
          .borderRadius(10)
          .border({style:BorderStyle.Solid})
          .borderWidth(1)
          .fontSize(20)
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .padding({right:10, top:20})
      .margin({top:10})
    }
    .onClick( () => {
      router.replaceUrl({url:'pages/Index'})
      clearInterval(this.timeId)
    })
  }
}
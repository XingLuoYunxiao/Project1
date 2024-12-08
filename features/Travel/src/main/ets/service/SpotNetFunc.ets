import { Location, Spot } from "../model/Spot";
import { BusinessError } from "@kit.BasicServicesKit";
import { LazyDataSource, LoadingStatus, LocationUtil, PreferenceUtil } from "utils";
import { City } from "./CategoryData";
import Logger from "utils/src/main/ets/utils/Logger";
import { SpotModel } from "../model/SpotModel";
import { classificationList } from "./ClassficationData";

const TAG = '[SpotModel]';
const domain = 0x0011;
const MAX_HISTORY_COUNT = 10;

@Observed
export class SpotNetFunc{
  private spotModel: SpotModel;
  private static instance: SpotNetFunc = new SpotNetFunc();
  private locationUtil: LocationUtil = LocationUtil.getInstance();
  private preferenceUtil: PreferenceUtil = PreferenceUtil.getInstance()
  spots: Spot[] = [];
  //景点和当前位置的距离map
  spotDistanceMap: Map<string, string> = new Map();
  //定义最近距离的最大值
  private maxDistance: string = '50公里';
  searchHistory: string[] = [];
  searchResult: Spot[] = [];
  nearbySpots: Spot[] = [];
  allSpotsDataSource: LazyDataSource<Spot> = new LazyDataSource();
  //加载状态
  allLoadingStatus: LoadingStatus = LoadingStatus.OFF;
  searchLoadingStatus: LoadingStatus = LoadingStatus.OFF;
  nearbyLoadingStatus: LoadingStatus = LoadingStatus.OFF;

  //分页
  pageNum: number = 1;

  //当前位置经纬度
  private currentUserLocation: Location = { latitude: 0, longitude: 0}
  isInitSpots: boolean = false;

  private constructor() {
    this.spotModel = new SpotModel();
    if( this.locationUtil.currentLocation !== undefined){
      this.currentUserLocation = this.locationUtil.currentLocation;
    }else{
      this.locationUtil.getCurrentLocation().then(() => {
        if (this.locationUtil.currentLocation !== undefined){
          this.currentUserLocation = this.locationUtil.currentLocation
        }
      }
      )
    }
  }

  //获取实例
  public static getInstance(): SpotNetFunc {
    if (!SpotNetFunc.instance) {
      SpotNetFunc.instance = new SpotNetFunc();
    }
    return SpotNetFunc.instance;
  }


  //获取hot景点数据，swiper
  public getHotSpots(): Promise<Spot[]> {
    return new Promise(async (resolve, reject) => {
      try{
        let data = await this.spotModel.getHotSpotData()
        resolve(data);
      }catch (e){
        reject('getHotSpots failed' + e);
      }
    })
  }

  //获取景点数据
  loadSpotsData(): Promise<void> {
    this.allLoadingStatus = LoadingStatus.LOADING
    return new Promise(async (resolve, reject) => {
      await this.spotModel.getSpotData(this.pageNum).then( (data: Array<Spot>) => {
        this.pageNum += 1
        const result: Array<Spot> = [];
        data.forEach(spot => {
          result.push(spot);
          this.spots.push(spot)
        })
        this.allSpotsDataSource.appendArrayData(result)
        this.allLoadingStatus = LoadingStatus.SUCCESS
        this.isInitSpots = true
        Logger.info(TAG, 'Get spot data success.')
        resolve();
      })
      .catch((e:Error) => {
        this.allLoadingStatus = LoadingStatus.FAILED
        Logger.error( TAG, `SpotModel getSpotData failed ${e}` );
        reject();
      })
    })
  }

  //获取景点距离
  public getAllDistance(): void {
    if( !this.isInitSpots){
      this.loadSpotsData()
    }
    this.spots.map(spot => {
    if(spot !== undefined && spot.latitude !== undefined && spot.longitude !== undefined && spot.id != undefined){
        let distance = this.calculateDistance(this.currentUserLocation, {latitude: spot.latitude, longitude: spot.longitude});
        this.spotDistanceMap.set(spot.id.toString(), distance.toFixed(2));
      }
    })
  }

  //获取距离之内的景点
  async loadNearbyAttractions(): Promise<void> {
    this.nearbyLoadingStatus = LoadingStatus.LOADING;

    // 确保定位信息已获取
    if (this.currentUserLocation.latitude === 0 && this.currentUserLocation.longitude === 0) {
      await this.locationUtil.getCurrentLocation();  // 等待定位完成
    }

    // 获取成功后再进行景点加载
    if (this.currentUserLocation.latitude !== 0 && this.currentUserLocation.longitude !== 0) {
      try {
        const maxDistance = Number(this.maxDistance.slice(0, -2));
        this.nearbySpots = this.spots.filter(spot =>
          this.calculateDistance(this.currentUserLocation, {latitude: spot.latitude!, longitude: spot.longitude!}) <= maxDistance
        );
        this.nearbySpots.sort((a, b) => {
          const distanceA = this.calculateDistance(this.currentUserLocation, {latitude: a.latitude!, longitude:a.longitude!});
          const distanceB = this.calculateDistance(this.currentUserLocation,{latitude: b.latitude!, longitude: b.longitude!});
          return (distanceA - distanceB);
        });
        this.nearbyLoadingStatus = LoadingStatus.SUCCESS;
        Logger.info(TAG, 'Get nearby attractions success.');
      } catch (e) {
        this.nearbyLoadingStatus = LoadingStatus.FAILED;
        Logger.error(TAG, 'SpotModel getAllDistance failed', e);
      }
    } else {
      this.nearbyLoadingStatus = LoadingStatus.FAILED;
      Logger.error(TAG, '定位失败，无法获取附近景点');
    }
  }


  //搜索景点
  //TODO 搜索需要直接从数据库完成
  search(value: string): void {
    // 判断是否已经存在
    this.searchLoadingStatus = LoadingStatus.LOADING
    if (!this.searchHistory.includes(value)) {
      // 将新元素添加到数组开头
      this.searchHistory.unshift(value);
    } else {
      this.searchHistory.map((historyItem, index) => {
        // 将匹配到的元素移动到数组开头
        if (historyItem === value) {
          this.searchHistory.unshift(this.searchHistory.splice(index, 1)[0]);
        }
      })
    }
    if (this.searchHistory.length > MAX_HISTORY_COUNT) {
      this.searchHistory.pop();
    }
    this.preferenceUtil.putPreferenceValue<string[]>('searchHistory', this.searchHistory);
    this.searchResult = this.spots.filter(spot => spot.name!.toLowerCase().includes(value.toLowerCase()))
    this.searchLoadingStatus = LoadingStatus.SUCCESS

  }

  //TODO 分类选择有问题
  public updateAttractionsList( currentCity: City, currentCategory: string[]) : LazyDataSource<Spot> {
    if( !this.isInitSpots){
      this.loadSpotsData()
    }

    let currentAttractions: Spot[] = [];

    if(currentCity.cityName !== '所有' || (currentCategory[0] !== '全部景点' && currentCategory[0] !== '全部分类' && currentCategory[0] !== classificationList[0].category)){
      this.spotModel.getSpotDataByCondition([currentCity.cityName, currentCategory[0]]).then((data)=>{
        this.spots = data;
        this.allSpotsDataSource.pushArrayData(data)
        currentAttractions = data;
      })
    }else{
      return this.allSpotsDataSource
    }


      if( this.searchLoadingStatus === LoadingStatus.SUCCESS){
      currentAttractions = this.searchResult;
      /*this.allSpotsDataSource.clear();
      this.allSpotsDataSource.pushArrayData(this.searchResult)*/
    }else{
      currentAttractions = this.spots;
    }


    // Filter by city first
    if (currentCity.cityName !== '所有') {
      currentAttractions = this.spots
      currentAttractions = currentAttractions.filter(spot =>
      (spot.cityCode == currentCity.cityCode) || spot.name?.includes(currentCity.cityName)
      );
    }

    // (全部景点)
    if (currentCategory[0] !== '全部景点' && currentCategory[0] !== '全部分类' && currentCategory[0] !== classificationList[0].category) {
      currentAttractions = currentAttractions.filter(spot =>
      spot.category!.includes(currentCategory[0])
      );
    }
    let list1 = currentAttractions

    //(位置距离之内)
    if (currentCategory[1] !== '不限距离' && currentCategory[1] !== '位置距离') {
      // 假设距离格式是 "5km"，需要提取数字部分
      const maxDistance = Number(currentCategory[1].slice(0, -2));

      currentAttractions = currentAttractions.filter((spot) => {
        const distance = this.calculateDistance(this.currentUserLocation, {latitude: spot.latitude!, longitude: spot.longitude!});
        return distance <= maxDistance; // 返回布尔值，距离小于等于指定值的景点会被保留
      });
    }else{
      currentAttractions = list1
    }

    // (综合排序)
    if (currentCategory[2] !== '综合排序') {
      switch (currentCategory[2]) {
        case '评分最高':
          currentAttractions.sort((a, b) => b.rating! - a.rating!);
          break;
        case '价格最低':
          currentAttractions.sort((a, b) => a.ticketPrice! - b.ticketPrice!);
          break;
        case '价格最高':
          currentAttractions.sort((a, b) => b.ticketPrice! - a.ticketPrice!);
          break;
        case '最近距离':
          currentAttractions.sort((a, b) => {
            const distanceA = this.calculateDistance(this.currentUserLocation, {latitude: a.latitude!, longitude:a.longitude!});
            const distanceB = this.calculateDistance(this.currentUserLocation, {latitude: b.latitude!, longitude: b.longitude!});
            return (distanceA - distanceB)
          });
          break;
      }
    }
    this.allSpotsDataSource.pushArrayData(currentAttractions)

    return this.allSpotsDataSource
  }

  private calculateDistance(loc1: Location, loc2: Location): number {
    // 使用Haversine公式计算两点之间的最短距离
    const R = 6371; //
    const dLat = this.toRad(loc2.latitude - loc1.latitude);
    const dLon = this.toRad(loc2.longitude - loc1.longitude);
    const lat1 = this.toRad(loc1.latitude);
    const lat2 = this.toRad(loc2.latitude);

    const a = Math.sin(dLat/2) * Math.sin(dLat/2) +
      Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    return R * c;
  }

  private toRad(value: number): number {
    return value * Math.PI / 180;
  }


  getSearchHistory(): void {
    this.preferenceUtil.getPreferenceValue<string[]>('searchHistory').then(res => {
      this.searchHistory = res ?? [];
      Logger.error(TAG, 'Get search History success.');
    }).catch((err: BusinessError) => Logger.error(TAG, 'Get search History Failed. Cause: ' + err));
  }

  /**
   * clear search history
   */
  clearSearchHistory(): void {
    this.preferenceUtil.deleteValue('searchHistory').then(res => {
      this.searchHistory = [];
      Logger.error(TAG, 'Delete search History success.' + JSON.stringify(res));
    }).catch((err: BusinessError) => Logger.error(TAG, 'Delete search History Failed. Cause: ' + err));
  }


}
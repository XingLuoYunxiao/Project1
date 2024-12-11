import { Collection } from '../model/Collection'
import { CollectionAdd } from '../model/CollectionAdd'
import { mySpot } from '../model/mySpot'
import { Poem } from '../model/Poem'
import { ListDataSource } from '../service/ListDataSource'
import { MineViewModel } from '../service/MineViewModel'
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule";
import Constants from '../common/constants/Constants'
import { SpotNetFunc } from 'travel/src/main/ets/service/SpotNetFunc'
import auth from '@hw-agconnect/auth'

@Component
struct EveryItem {
  @Link delcount:number
  @Link manage?:string
  @ObjectLink spot:CollectionAdd
  build() {
    ListItem(){
      Row(){
        Checkbox()
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.delcount++
            }else this.delcount--
            this.spot.isChoose=isChecked
          }).visibility(this.manage=='退出管理'?Visibility.Visible:Visibility.None)
        // CollectHistoryItem({item:this.spot})
        Row() {
          Image($r(this.spot.spot_img)).width(80).height(80)
          Column({space:Constants.MIDDLE_SPACE}){
            Text(this.spot.spotname).fontSize(16).fontWeight(500)
            Row({space:Constants.MIDDLE_SPACE}){
              Text(`⭐ ${this.spot.rating}`).fontColor(Color.Orange)
              Text(`￥${this.spot.ticketPrice}/人`)
            }
            Text(this.spot.areaName).fontSize(12).opacity(0.8)
          }
          .width(140)
          .margin({left:$r('app.float.md_padding_margin')})
          .alignItems(HorizontalAlign.Start)
          Column(){
            Text('开放时间').fontSize(12).opacity(0.8).fontColor(Color.Orange)
            Text(this.spot.openningHours)
              .fontSize(12).opacity(0.8)
          }.alignItems(HorizontalAlign.Start)
          .padding({left:$r('app.float.xl_padding_margin')})
        }.borderRadius(10)
        .width('100%')
        .backgroundColor(Color.White)
        .padding(12)
      }
    }
  }
}

@Component
export struct CollectionPage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @State manage:string='管理'
  @State collectitem:Collection[]=[]
  @State spots: mySpot[] = []
  @State poems: Poem[] = []
  @State isChecked:boolean=false;
  @State spotres:CollectionAdd[]=[]
  @State poemres:CollectionAdd[]=[]
  @State isSearch:boolean=false
  @StorageLink ('personUid') personUid: string = ''
  @State mineViewModel:MineViewModel=MineViewModel.getInstance();
  @Provide collectspotListData: ListDataSource<CollectionAdd> = this.mineViewModel.collectspotListData
  @Provide collectpoemListData: ListDataSource<CollectionAdd> =this.mineViewModel.collectpoemListData
  @Provide searchListData: ListDataSource<CollectionAdd> = new ListDataSource();
  @State SpotNetWork:SpotNetFunc = SpotNetFunc.getInstance()
  @State deletecount:number=0

  async aboutToAppear() {
    this.mineViewModel.collectionDeal(this.personUid)
  }


  build() {
    NavDestination(){
      Stack(){
        Column() {
          Row(){
            Image($r('app.media.ic_back')).width($r('app.float.md_topic_width')).onClick(()=>{
              this.appPathStack.pop()
            })
            Text('收藏').fontSize(20)
            Text(this.manage).onClick(() => {
              if(this.manage=='管理'){
                this.manage = '退出管理'
              }else{
                this.manage='管理'
              }
            })
          }
          .width('100%')
          .height(Constants.TOP_HEIGHT_PAGE)
          .justifyContent(FlexAlign.SpaceBetween)
          Tabs(){
            TabContent(){
              Column(){
                Search({placeholder:'请输入关键字'})
                  .onSubmit((val)=>{
                    this.isSearch=true;
                    this.searchListData.notifyDataDeleteAll()
                    for (let index = 0; index < this.collectspotListData.totalCount(); index++) {
                      const res=this.collectspotListData.getData(index)
                      if(res.spotname.includes(val)){
                        this.searchListData.pushData(res)
                      }
                    }
                    this.searchListData.notifyDataReload()
                  }).width('100%')
                Scroll(){
                  if(this.isSearch==true){
                    this.listData(this.searchListData)
                  }else {
                    this.listData(this.collectspotListData)
                  }
                }.height('100%')
              }
              if(this.manage=='退出管理'){
                this.bottomDelete()
              }
            }.tabBar('遗迹景点')
            TabContent(){
              Column(){
                Scroll(){
                  Column(){
                    LazyForEach(this.collectpoemListData,(poem:CollectionAdd)=>{
                      ListItem(){
                        Row({space:Constants.MIDDLE_SPACE}){
                          Text(`《${poem.spotname}》`).fontSize(16)
                          Text(poem.spot_img).fontSize(16)
                        }
                        .justifyContent(FlexAlign.Start)
                        .width('100%')
                        .height(80)
                        .padding({left:$r('app.float.sm_padding_margin')})
                        .margin($r('app.float.sm_padding_margin'))
                        .borderRadius(8)
                        .backgroundColor($r('app.color.dialog_background_blue'))
                      }.onClick(()=>{

                      })
                    },(poem:CollectionAdd)=>JSON.stringify(poem))
                  }
                }.scrollBar(BarState.Off)
              }.height('100%')
            }.tabBar('诗词歌赋')
          }.barHeight(Constants.BAR_HEIGHT_PAGE)
        }
        .padding({left:Constants.PADDING_PAGE,right:Constants.PADDING_PAGE,top:Constants.PADDING_PAGE})
        .backgroundColor($r('app.color.page_background_grey'))
        .width('100%')
        this.bottomDelete()
      }.alignContent(Alignment.Bottom)
    }
    .margin({top:Constants.HEADER_HEIGHT_PAGE})
    .hideTitleBar(true)
  }

  @Builder
  bottomDelete(){
    Row(){
      Checkbox()
      Text('全选')
      Blank()
      Button('清空全部')
      Button(`删除${this.deletecount}`).onClick(()=>{
        for (let index = this.collectspotListData.totalCount()-1; index >= 0; index--) {
          const cur=this.collectspotListData.getData(index)
          if(cur.isChoose==true){
            this.mineViewModel.collectiondelete(cur.spotId,this.personUid);
            this.mineViewModel.collectspotListData.deleteData(index);
            this.collectspotListData= this.mineViewModel.collectspotListData
          }
        }
        this.manage='管理'
      })
    }
    .backgroundColor(Color.White)
    .width('100%')
    .visibility(this.manage=='退出管理'?Visibility.Visible:Visibility.None)
  }

  @Builder
  listData(data:ListDataSource<CollectionAdd>){
    Column(){
      List({space:Constants.SMALL_SPACE}){
        LazyForEach(data,(spot:CollectionAdd)=>{
          EveryItem({manage:$manage,spot:spot,delcount:$deletecount})
            .onClick(()=>{
              this.SpotNetWork.search(spot.spotname)
              buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_ATTRACTIONDETAILPAGE,new Object({item:this.SpotNetWork.searchResult[0]}))
            })
        },(spot:CollectionAdd,index:number)=>JSON.stringify(spot)+Math.random()+index)
      }.scrollBar(BarState.Off)
    }.height('100%')
  }
}


@Builder
export function CollectionPageBuilder() {
  CollectionPage()
}

const builderName = BuilderNameConstants.LOGIN_COLLECTIONPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(CollectionPageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}

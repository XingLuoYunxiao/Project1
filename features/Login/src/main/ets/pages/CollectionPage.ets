import { Collection } from '../model/Collection'
import { CollectionAdd } from '../model/CollectionAdd'
import { mySpot } from '../model/mySpot'
import { Poem } from '../model/Poem'
import { CollectHistoryItem } from '../view/CollectHistoryItem'
import { ListDataSource } from '../service/ListDataSource'
import { MineViewModel } from '../service/MineViewModel'
import auth from '@hw-agconnect/auth'
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule";
import Constants from '../common/constants/Constants'
import { SpotNetFunc } from 'travel/src/main/ets/service/SpotNetFunc'

@Component
struct EveryItem {
  @Link manage?:string
  @ObjectLink spot:CollectionAdd
  build() {
    ListItem(){
      Row(){
        if(this.manage=='完成'){
          Checkbox()
            .onChange((isChecked: boolean) => {
              this.spot.isChoose=isChecked
            })
        }
        CollectHistoryItem({item:this.spot})
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

  @Builder
  bottomDelete(){
    Row(){
      Checkbox()
      Text('全选')
      Blank()
      Button('清空全部')
      Button('删除').onClick(()=>{
        for (let index = this.collectspotListData.totalCount()-1; index >= 0; index--) {
          const cur=this.collectspotListData.getData(index)
          if(cur.isChoose==true){
            this.mineViewModel.collectiondelete(cur);
            this.mineViewModel.collectspotListData.deleteData(index);
            this.collectspotListData= this.mineViewModel.collectspotListData
          }
        }
      })
    }
    .backgroundColor(Color.White)
    .width('100%')
    .visibility(this.manage=='完成'?Visibility.Visible:Visibility.None)
  }

@Builder
listData(data:ListDataSource<CollectionAdd>){
Column(){
  List({space:Constants.SMALL_SPACE}){
    LazyForEach(data,(spot:CollectionAdd)=>{
      EveryItem({manage:$manage,spot:spot})
        .onClick(()=>{
          this.SpotNetWork.search(spot.spotname)
          buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_ATTRACTIONDETAILPAGE,new Object({item:this.SpotNetWork.searchResult[0]}))
        })
    },(spot:CollectionAdd,index:number)=>JSON.stringify(spot)+Math.random()+index)
  }.scrollBar(BarState.Off)
}.height('100%')
}

  async aboutToAppear() {
    auth.getCurrentUser().then(user=>{
      if(user){
        this.personUid=user.getUid()
        this.mineViewModel.collectionDeal(this.personUid)
      }
    })
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
                this.manage = '完成'
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
              if(this.manage=='完成'){
                this.bottomDelete()
              }
            }.tabBar('遗迹景点')
            TabContent(){
              Column(){
                Scroll(){
                  Column(){
                    LazyForEach(this.collectpoemListData,(poem:CollectionAdd)=>{
                      ListItem(){
                        Row(){
                          Text(poem.spotname)
                          Text(poem.spot_img)
                        }
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

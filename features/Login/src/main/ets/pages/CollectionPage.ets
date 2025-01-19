import { Collection } from '../model/Collection'
import { CollectionAdd } from '../model/CollectionAdd'
import { mySpot } from '../model/mySpot'
import { Poem } from '../model/Poem'
import { ListDataSource } from '../service/ListDataSource'
import { MineViewModel } from '../service/MineViewModel'
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule";
import Constants from '../common/constants/Constants'
import { SpotNetFunc } from 'travel/src/main/ets/service/SpotNetFunc'
import { promptAction } from '@kit.ArkUI'

@Component
struct EveryItem {
  @Link delcount:number
  @Link manage?:string
  @ObjectLink spot:CollectionAdd

  build() {
    ListItem(){
      Row(){
        Checkbox({ name:this.spot.spotname, group: 'checkboxGroup' })
          .select(this.spot.isChoose)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.delcount++
            }else {
              this.delcount--
            }
            this.spot.isChoose=isChecked
          })
          .mark({
            strokeColor:Color.White,
            size: 50,
            strokeWidth: 5
          })
          .visibility(this.manage=='退出管理'?Visibility.Visible:Visibility.None)
        Row() {
          Image(this.spot.spot_img).width(80).height(80)
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
  @StorageProp ('personUid') personUid: string = ''
  @State mineViewModel:MineViewModel=MineViewModel.getInstance();
  @Provide collectspotListData: ListDataSource<CollectionAdd> = this.mineViewModel.collectspotListData
  @Provide collectpoemListData: ListDataSource<CollectionAdd> =this.mineViewModel.collectpoemListData
  @Provide searchListData: ListDataSource<CollectionAdd> = new ListDataSource();
  @State SpotNetWork:SpotNetFunc = SpotNetFunc.getInstance()
  @State deletecount:number=0
  @State canLoad: boolean = false;//控制防止在到底加载新数据时重复触发加载操作
  @State isLoading: boolean = false;//是否正在加载
  @State non:number=this.mineViewModel.none
  @State selectall:boolean=false

  async aboutToAppear() {
    this.mineViewModel.reset()
    this.mineViewModel.collectionDeal(this.personUid)
  }

  @Builder
  footer() {
    Row() {
      LoadingProgress().height(32).width(48)
      // Text("加载中").fontColor(Color.Black)
    }.width("100%")
    .height(30)
    .justifyContent(FlexAlign.Center)
    // 当不处于加载中状态时隐藏组件
    .visibility((this.isLoading||this.collectspotListData.totalCount()==0)&&this.isSearch==false? Visibility.Visible : Visibility.Hidden)
  }

  @Builder
  none(){
    Text('ʅ（´◔౪◔）ʃ 到底了哦').width('100%').height(30)
      .textAlign(TextAlign.Center)
      .visibility(this.non==1&&this.collectspotListData.totalCount()!=0?Visibility.Visible:Visibility.Hidden)
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
                  List(){
                    if(this.isSearch==true){
                      this.listData(this.searchListData)
                    }else {
                      this.listData(this.collectspotListData)
                    }
                  }
                .margin({bottom:40})
                .layoutWeight(1)
                .scrollBar(BarState.Off)
                .height('100%')
              }
              if(this.manage=='退出管理'){
                this.bottomDelete()
              }
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
      CheckboxGroup({group: 'checkboxGroup'})
        .checkboxShape(CheckBoxShape.CIRCLE)
        .selectedColor(Color.Blue)
        //CheckboxGroup的选中状态或群组内的Checkbox的选中状态发生变化时，触发回调
        .onChange((itemName: CheckboxGroupResult) => {
          console.info("checkbox group content" + JSON.stringify(itemName))
          if(itemName.status==SelectStatus.All){
            this.deletecount=this.collectspotListData.totalCount()
            for (let index = this.collectspotListData.totalCount()-1; index >= 0; index--) {
              const cur=this.collectspotListData.getData(index)
              cur.isChoose=true
            }
          }
          if(itemName.status==SelectStatus.None){
            // this.deletecount=0
            for (let index = this.collectspotListData.totalCount()-1; index >= 0; index--) {
              const cur=this.collectspotListData.getData(index)
              cur.isChoose=false
            }
          }
        })
        .mark({
          strokeColor:Color.White,
          size: 40,
          strokeWidth: 2
        })
        .unselectedColor(Color.Gray)
      Text('全选')
      Blank()
      Button(`删除 (${this.deletecount})`).onClick(()=>{
        for (let index = this.collectspotListData.totalCount()-1; index >= 0; index--) {
          const cur=this.collectspotListData.getData(index)
          if(cur.isChoose==true){
            this.mineViewModel.collectiondelete(cur.spotId,this.personUid);
            this.mineViewModel.collectspotListData.deleteData(index);
            this.deletecount=0
          }
        }
        this.manage='管理'
        promptAction.showToast({message: '删除成功', duration: 2000})
      })
    }
    .padding({left:20,right:20,top:15,bottom:15})
    .backgroundColor(Color.White)
    .width('100%')
    .visibility(this.manage=='退出管理'?Visibility.Visible:Visibility.None)
  }

  @Builder
  listData(data:ListDataSource<CollectionAdd>){
      List({space:Constants.SMALL_SPACE}){
        LazyForEach(data,(spot:CollectionAdd)=>{
          EveryItem({manage:$manage,spot:spot,delcount:$deletecount})
            .onClick(()=>{
              this.mineViewModel.taskPoolExecuteQuery(spot.spotname).then((res) => {
                if(res.length !== 0){
                  buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_ATTRACTIONDETAILPAGE,new Object({item:res[0]}))
                }
              })
            })
        },(spot:CollectionAdd,index:number)=>JSON.stringify(spot)+Math.random()+index)
        ListItem(){
          this.none()
        }
        ListItem(){
          this.footer()
        }
      }
      .cachedCount(50)
      .onReachEnd(()=>{
        if(this.collectspotListData.totalCount()){
          this.isLoading=true
          this.non=this.mineViewModel.none
          this.mineViewModel.collectionDeal(this.personUid).then(()=>{
            if(this.non==1){
              this.isLoading=false
            }
          })
        }
      })
      .edgeEffect(EdgeEffect.None)
      .height('100%')
      .scrollBar(BarState.Off)
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

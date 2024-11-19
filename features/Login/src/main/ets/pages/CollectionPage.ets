import { Collection } from '../model/Collection'
import { CollectionAdd } from '../model/CollectionAdd'
import { mySpot } from '../model/mySpot'
import { Poem } from '../model/Poem'
import { CollectHistoryItem } from '../view/CollectHistoryItem'
import { ListDataSource } from '../service/ListDataSource'
import { MineViewModel } from '../service/MineViewModel'
import auth from '@hw-agconnect/auth'
import  { Database } from '@hw-agconnect/cloud'
import { OrderItem } from '../view/OrderItem'

@Builder
export function CollectionPageBuilder() {
  CollectionPage()
}

@Component
export struct EveryItem {
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
    }.width('100%')
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
      Column() {
        Row(){
          Image($r('app.media.swiper2')).width(30).onClick(()=>{
            this.appPathStack.pop()
          })
          Text('收藏')
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
            }).width('50%')
          Text(this.manage).onClick(() => {
            if(this.manage=='管理'){
              this.manage = '完成'
            }else{
              this.manage='管理'
            }
          })
        }.width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        Tabs(){
          TabContent(){
            Column(){
                List(){
                  if(this.isSearch==true){
                    LazyForEach(this.searchListData, (or: CollectionAdd) => {
                      ListItem() {
                        CollectHistoryItem({item:or})
                      }
                    },(or: CollectionAdd,index:number) => JSON.stringify(or)+Math.random()+index)
                  }else{
                    LazyForEach(this.collectspotListData,(spot:CollectionAdd)=>{
                      EveryItem({manage:$manage,spot:spot})
                    },(spot:CollectionAdd,index:number)=>JSON.stringify(spot)+Math.random()+index)
                  }
                }
            }.height('100%')
            if(this.manage=='完成'){
              this.bottomDelete()
            }
          }.tabBar('遗迹景点')
          TabContent(){
            Column(){
              List(){
                LazyForEach(this.collectpoemListData,(poem:CollectionAdd)=>{
                  ListItem(){
                    Row(){
                      Text(poem.spotname)
                      Text(poem.spot_img)
                    }
                  }
                },(poem:CollectionAdd)=>JSON.stringify(poem))

              }
            }.height('100%')
          }.tabBar('诗词歌赋')
        }
      }
      .backgroundColor($r('app.color.page_background_grey'))
      .width('100%')
    }
    .hideTitleBar(true)
  }

}

import { CategoryItem, City, mainCategories } from '../service/CategoryData';
import Constants from '../constants/Constants';
import { AttractionCard } from '../view/AttractionTicket/AttractionCard';
import { CategoryDialog } from '../view/AttractionTicket/CategoryDialog';
import { CityPickerDialog } from '../view/AttractionTicket/CityPickerDialog';
import { Spot } from '../model/Spot';
import { SpotNetFunc } from '../service/SpotNetFunc';
import { LoadingStatus } from 'utils/src/main/ets/common/CommonUtil';
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from 'routermodule';
import { LazyDataSource } from 'utils';
import { classificationList } from '../service/ClassficationData';
import { promptAction } from '@kit.ArkUI';




//TODO 小bug，点太快进入该页面会获取不到数据
@Component
export default struct AttractionTicketPage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @State spotNetWork: SpotNetFunc = SpotNetFunc.getInstance()
  @Watch('updateAttractionsList')
  @State currentCity: City = { cityId: '0', cityName: '所有' };
  //四个选择
  @Watch('updateAttractionsList')
  @State currentCategory :string[] = ['全部景点', '位置距离', '综合排序', '筛选'];
  @StorageLink('personUid') personUid: string = '';
  //当前当前距离
  @State currentSubCategory: CategoryItem | null = null;
  @State currentAttractions: LazyDataSource<Spot> = this.spotNetWork.allSpotsDataSource;
  @State value: object = new Object()



  async aboutToAppear(): Promise<void> {
    //let category = this.appPathStack.getParamByName('AttractionTicketPage')[0] as string
    let category = JSON.parse(JSON.stringify(this.value)).text as string
    if( category !== "")
      this.currentCategory[0] = category
    this.spotNetWork.allSpotsDataSource.clear();
    this.currentAttractions =  await this.spotNetWork.updateAttractionsList(this.currentCity, this.currentCategory)
  }

  aboutToDisappear(): void {
    this.spotNetWork.reset()
    this.currentCategory = ['全部景点', '位置距离', '综合排序', '筛选']
  }



  cityPickerController: CustomDialogController = new CustomDialogController({
    builder: CityPickerDialog({
      confirm: (city: City) => {
        this.currentCity = city;
      },
      update: () => {this.updateAttractionsList()},
      cancel: () => {
      }
    }),
    width: 600
  });

  //分类选择器
  categoryController: CustomDialogController = new CustomDialogController({
    builder: CategoryDialog({
      index: 0,
      categories: [
        { id: -1, name: '无' },
        { id: -1, name: '无' },
      ],
      onSelect: (category: CategoryItem) => {
        this.handleCategorySelect(category, 0);
      }
    })
  });

  //展示一级分类
  handleCategorySelect(category: CategoryItem, index:number) {
      this.currentSubCategory = category;
      this.currentCategory[index] = category.name;
      this.updateAttractionsList();
  }

  //展示一级分类下面的二级分类
  showSubCategories(categories: CategoryItem[], index:number) {
    this.categoryController = new CustomDialogController({
      builder: CategoryDialog({
        index: index,
        categories: categories,
        onSelect: (category: CategoryItem) => {
          this.handleCategorySelect(category, index);
        }
      }),
      height: 800,
      width: 600
    });
    this.categoryController.open();
  }

  @Builder
  Header() {
    Row() {
      Image($r('app.media.ic_back'))
        .width(30)
        .height(30)
        .margin({left:5, right:5})
        .onClick( () =>{
          this.appPathStack.pop()
        })
      Row() {
        Text(this.currentCity.cityName)
          .fontSize(Constants.FONT_TITLE)
          .margin({ left: Constants.MARGIN_SM })
          .onClick(() => {
            this.cityPickerController.open();
          })
        Image($r('app.media.ic_arrow_down'))
          .width(16)
          .height(16)
          .margin({ left: 4 })
      }

      Search({  placeholder: '请输入搜索城市' })
        .width('70%')
        .height(36)
        .margin({ left: Constants.MARGIN_LG })
        .onChange( ()=> {
          this.updateAttractionsList()
        })
        .onClick( () => {
          buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_SEARCHPAGE,)
          //this.appPathStack.replacePathByName('SearchPage', true)
        })

      Text('搜索')
        .padding(5)
        .fontColor(Constants.COLOR_PRIMARY)
        .fontSize(Constants.FONT_CONTENT)
        .onClick( () => {
          buildRouterModel(RouterNameConstants.ENTRY_HAP,  BuilderNameConstants.TRAVEL_SEARCHPAGE)
          //this.appPathStack.replacePathByName('SearchPage', true)
        })
    }
    .width(Constants.FULL_WIDTH)
    .height(Constants.HEADER_HEIGHT)
    .padding(Constants.MARGIN_LG)
    .backgroundColor(Color.White)
  }



  async updateAttractionsList() {
    this.spotNetWork.allLoadingStatus = LoadingStatus.LOADING
    //遍历所有景点，将所有符合条件的景点插入到currentAttractions中,不符合则删除
    if(!judgeLoadData(this.currentCity, this.currentCategory)){
      this.currentAttractions.clear()
      this.currentAttractions = await this.spotNetWork.updateAttractionsList(this.currentCity, this.currentCategory)
    }else{
      if( this.spotNetWork.isRefresh === true){
        this.spotNetWork.pageNum = 1
        this.spotNetWork.isRefresh = false
      }
      await this.spotNetWork.loadSpotsData()
      this.currentAttractions = this.spotNetWork.allSpotsDataSource
    }
  }

  @Builder itemFoot(){
    Column(){
      Text('-------到底了--------')
        .fontSize(10)
        .backgroundColor(Color.White)
        .width('100%')
        .textAlign(TextAlign.Center)
        .height(30)
        .margin({top:5})
    }
  }



  build() {
    NavDestination() {
      Column() {
        this.Header()

        Row(){
          ForEach(mainCategories, (category: CategoryItem, index) => {
            ListItem(){
              Row() {
                Text(this.currentCategory[index])
                  .fontSize(Constants.FONT_CONTENT)
                  .fontSize(20)
                  .padding(5)
                Image($r('app.media.ic_arrow_down'))
                  .width(16)
                  .height(16)
                  .margin({ left: 4 })
              }
            }
            .onClick(() => {
              if (category.subCategories) {
                this.showSubCategories(category.subCategories, index);
              }
            })
          })
        }
        .justifyContent(FlexAlign.SpaceAround)
        .width(Constants.FULL_WIDTH)
        .height(Constants.CATEGORY_HEIGHT)

        WaterFlow({footer: this.itemFoot()}){
          LazyForEach(this.currentAttractions, (item: Spot, index: number) => {
            FlowItem() {
              AttractionCard({ item: item })
                .reuseId("attraction")
            }
            .onClick(() => {
              if( item.id && this.personUid != ''){
                this.spotNetWork.addBrowse(item.id, this.personUid);
              }else{
                promptAction.showToast({message: '请先登录'})
              }
              buildRouterModel(RouterNameConstants.ENTRY_HAP,  BuilderNameConstants.TRAVEL_ATTRACTIONDETAILPAGE, new Object({item:item}))
              //this.appPathStack.pushPathByName('AttractionDetailPage', item)
            })
            //触底加载数据
            /*.onAppear(async () => {
              if( this.spotNetWork.searchLoadingStatus !== LoadingStatus.LOADING && index + 5 == this.spotNetWork.allSpotsDataSource.totalCount()){
                await this.updateAttractionsList()
              }
            })*/
          }, (item: Spot) => item.name)
        }
        .onReachEnd(async () => {
            await this.updateAttractionsList()

        })
        .scrollBar(BarState.On)

/*
        List() {
          LazyForEach(this.currentAttractions, (item: Spot, index: number) => {
            ListItem() {
                AttractionCard({ item: item })
                  .reuseId("attraction")
            }
            .onClick(() => {
              buildRouterModel(RouterNameConstants.ENTRY_HAP,  BuilderNameConstants.TRAVEL_ATTRACTIONDETAILPAGE, new Object({item:item}))
            })
            //触底加载数据
            .onAppear(() => {
              if( this.spotNetWork.searchLoadingStatus !== LoadingStatus.LOADING && index + 5 == this.spotNetWork.allSpotsDataSource.totalCount()){
                this.spotNetWork.loadSpotsData().then( () => {
                  this.currentAttractions = this.spotNetWork.updateAttractionsList(this.currentCity, this.currentCategory)
                })
              }
            })
          })
        }
*/

        .width(Constants.FULL_WIDTH)
        .layoutWeight(1)
        .backgroundColor(Constants.COLOR_BG)
      }
      .width(Constants.FULL_WIDTH)
      .height(Constants.FULL_HEIGHT)
    }
    .hideTitleBar(true)
    .margin({ top: Constants.HEADER_HEIGHT_PAGE })

  }

}
export function
judgeLoadData(currentCity:City, currentCategory:String[]){
  if(currentCity.cityName !== '所有' || (currentCategory[0] !== '全部景点' && currentCategory[0] !== '全部分类'
    && currentCategory[0] !== classificationList[0].category) || (currentCategory[1] != '位置距离' &&
    currentCategory[1] != '不限距离') || currentCategory[2] !== '综合排序'){
    return false;
  }
  return true;
}

@Builder
export function AttractionTicketPageBuilder(value:object) {
  AttractionTicketPage({value: value})
}


const builderName = BuilderNameConstants.TRAVEL_ATTRACTIONTICKETPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(AttractionTicketPageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}

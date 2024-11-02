import { CategoryItem, City, mainCategories } from '../service/CategoryData';
import Constants from '../constants/Constants';
import { AttractionCard } from '../view/AttractionTicket/AttractionCard';
import { CategoryDialog } from '../view/AttractionTicket/CategoryDialog';
import { CityPickerDialog } from '../view/AttractionTicket/CityPickerDialog';
import { Spot } from '../model/Spot';
import { DataUtil } from '../util/DataUtil';

@Component
export default struct AttractionTicketPage {
  @State currentCity: City = { cityId: '1', cityName: '上海' };
  @State searchText: string = '';
  //四个选择
  @State currentCategory :string[] = ['全部景点', '位置距离', '综合排序', '筛选'];


  @State currentSubCategory: CategoryItem | null = null;
  @State attractions: Spot[] = [];

  async aboutToAppear(): Promise<void> {
    this.attractions = await DataUtil.readJsonFromRawFile<Spot>('SpotData.json')
  }

  cityPickerController: CustomDialogController = new CustomDialogController({
    builder: CityPickerDialog({
      confirm: (city: City) => {
        this.currentCity = city;
      },
      cancel: () => {
      }
    })
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

  handleCategorySelect(category: CategoryItem, index:number) {
      this.currentSubCategory = category;
      this.currentCategory[index] = category.name;
      this.updateAttractionsList();
  }

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

      Search({ value: this.searchText, placeholder: '北京环球影城' })
        .width('80%')
        .height(36)
        .margin({ left: Constants.MARGIN_LG })
        .onChange((value: string) => {
          this.searchText = value;
        })

      Text('搜索')
        .padding(5)
        .fontColor(Constants.COLOR_PRIMARY)
        .fontSize(Constants.FONT_CONTENT)
    }
    .width(Constants.FULL_WIDTH)
    .height(Constants.HEADER_HEIGHT)
    .padding(Constants.MARGIN_LG)
    .backgroundColor(Color.White)
  }


  updateAttractionsList() {
    // 根据当前分类和子分类更新景点列表
    // 实际应用中这里可能需要调用API
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

        List(){

        }
        .listDirection(Axis.Horizontal)
        .width(Constants.FULL_WIDTH)
        .height(Constants.CATEGORY_HEIGHT)

        List() {
          ForEach(this.attractions, (item: Spot) => {
            ListItem() {
              AttractionCard({ item: item })
            }
          })
        }

        .width(Constants.FULL_WIDTH)
        .layoutWeight(1)
        .backgroundColor(Constants.COLOR_BG)
      }
      .width(Constants.FULL_WIDTH)
      .height(Constants.FULL_HEIGHT)
    }
  }
}

@Builder
export function AttractionTicketPageBuilder() {
  AttractionTicketPage()
}
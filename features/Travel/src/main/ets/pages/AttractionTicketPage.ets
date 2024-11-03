import { CategoryItem, City, mainCategories } from '../service/CategoryData';
import Constants from '../constants/Constants';
import { AttractionCard } from '../view/AttractionTicket/AttractionCard';
import { CategoryDialog } from '../view/AttractionTicket/CategoryDialog';
import { CityPickerDialog } from '../view/AttractionTicket/CityPickerDialog';
import { Location, Spot } from '../model/Spot';
import { DataUtil } from '../util/DataUtil';
import { ServerPushOperationType } from '@hw-agconnect/cloud/src/main/ets/database/sync/utils/MessageType';

@Component
export default struct AttractionTicketPage {
  @State currentCity: City = { cityId: '0', cityName: '所有' };
  @State searchText: string = '';
  //四个选择
  @State currentCategory :string[] = ['全部景点', '位置距离', '综合排序', '筛选'];
  //当前当前距离


  @State currentSubCategory: CategoryItem | null = null;
  @State attractions: Spot[] = [];
  @State currentAttractions: Spot[] = [];

  async aboutToAppear(): Promise<void> {
    this.attractions = await DataUtil.readJsonFromRawFile<Spot>('SpotData.json')
    this.currentAttractions = this.attractions;
  }

  cityPickerController: CustomDialogController = new CustomDialogController({
    builder: CityPickerDialog({
      confirm: (city: City) => {
        this.currentCity = city;
      },
      update: () => {this.updateAttractionsList()},
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

  /*updateAttractionsList() {
    //遍历所有景点，将所有符合条件的景点插入到currentAttractions中,不符合则删除
    this.attractions.every((item: Spot) => {
      if (item.category.indexOf(this.currentCategory[0]) || (this.currentCity.cityName === '所有' || item.cityName === this.currentCity.cityName)) {
        this.currentAttractions.push(item);
      } else{

      }
    })
  }*/


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



        List() {
          ForEach(this.currentAttractions, (item: Spot) => {
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

  updateAttractionsList() {
    // Reset current attractions
    this.currentAttractions = [...this.attractions];

    // Filter by city first
    if (this.currentCity.cityName !== '所有') {
      this.currentAttractions = this.currentAttractions.filter(spot =>
      spot.cityName === this.currentCity.cityName
      );
    }

    // (全部景点)
    if (this.currentCategory[0] !== '全部景点') {
      this.currentAttractions = this.currentAttractions.filter(spot =>
      spot.category.includes(this.currentCategory[0])
      );
    }

    //(位置距离之内)
    if (this.currentCategory[1] !== '不限距离' && this.currentCategory[1] !== '位置距离') {
      const userLocation = this.getCurrentUserLocation();
      // 假设距离格式是 "5km"，需要提取数字部分
      const maxDistance = Number(this.currentCategory[1].slice(0, -2));

      this.currentAttractions = this.currentAttractions.filter((spot) => {
        const distance = this.calculateDistance(userLocation, spot.location);
        return distance <= maxDistance; // 返回布尔值，距离小于等于指定值的景点会被保留
      });
    }

    //(位置距离排序)
    if (this.currentCategory[1] !== '不限距离' && this.currentCategory[1] !== '位置距离') {
      const userLocation = this.getCurrentUserLocation(); // You'll need to implement this
      this.currentAttractions.sort((a, b) => {
        const distanceA = this.calculateDistance(userLocation, a.location);
        const distanceB = this.calculateDistance(userLocation, b.location);
        //return (distanceA - distanceB) < Number(this.currentCategory[1].substring(0, -3))
        return (distanceA - distanceB)
      });
    }

    // (综合排序)
    if (this.currentCategory[2] !== '综合排序') {
      switch (this.currentCategory[2]) {
        case '评分最高':
          this.currentAttractions.sort((a, b) => b.rating - a.rating);
          break;
        case '价格最低':
          this.currentAttractions.sort((a, b) => a.ticketPrice - b.ticketPrice);
          break;
        case '价格最高':
          this.currentAttractions.sort((a, b) => b.ticketPrice - a.ticketPrice);
          break;
      }
    }

    // (筛选)


    /*// 搜索之后的景点列表
    if (this.searchText.trim()) {
      const searchLower = this.searchText.toLowerCase().trim();
      this.currentAttractions = this.currentAttractions.filter(spot =>
      spot.name.toLowerCase().includes(searchLower) ||
      spot.summary.toLowerCase().includes(searchLower) ||
      spot.address?.toLowerCase().includes(searchLower)
      );
    }*/
  }

  // 计算景点和用户之间的距离
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


  private getCurrentUserLocation(): Location {
    return {
      latitude: 34.27,
      longitude: 108.83
    };
  }
}

@Builder
export function AttractionTicketPageBuilder() {
  AttractionTicketPage()
}
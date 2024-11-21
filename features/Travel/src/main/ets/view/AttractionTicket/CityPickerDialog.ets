import { LocationUtil } from "utils";
import { cities, City, CityTab, cityTabs } from "../../service/CategoryData";


@CustomDialog
export struct CityPickerDialog {
  controller: CustomDialogController;
  confirm: (city: City) => void = () => {};
  update: () => void = () => {};
  cancel: () => void = () => {};
  @State locationUtil: LocationUtil = LocationUtil.getInstance()


  build() {
    Column() {
      Text('选择城市')
        .fontSize(24)
        .margin({ top: 20, bottom: 20 })

      Tabs() {
        ForEach(cityTabs, (item: CityTab) => {
          TabContent() {
            Column(){
              if (item.title === cityTabs[0].title) {
                Column() {
                  Text('定位/位置')
                    .fontSize(22)
                    .margin({ top: 10, bottom: 10 })
                  if (this.locationUtil.currentCityName !== undefined) {
                    Text(this.locationUtil.currentCityName)
                      .fontSize(20)
                      .margin({ top: 10, bottom: 10 })
                      .width('25%')
                      .height(60)
                      .border({ width: 0.5, color: Color.Green })
                      .borderRadius(8)
                      .textAlign(TextAlign.Center)
                      .onClick(() => {
                        this.confirm(cities.find(city => this.locationUtil.currentCityName?.includes(city.cityName))!);
                        this.update();
                        this.controller.close();
                      })
                  } else {
                    Row() {
                      Image($r('app.media.refresh_icon'))
                        .fillColor(Color.Green)
                        .width(24)
                        .width(24)
                        .padding({ right: 4 })
                      Text('获取定位')
                        .fontColor(Color.Green)
                        .fontSize(20)
                        .textAlign(TextAlign.Center)
                    }
                    .width('25%')
                    .height(60)
                    .border({ width: 0.5, color: Color.Green })
                    .borderRadius(8)
                    .onClick(() => {
                      this.locationUtil.getCurrentLocation()
                    })
                    .justifyContent(FlexAlign.Center)

                  }

                }
                .alignItems(HorizontalAlign.Start)
                .justifyContent(FlexAlign.Start)
                .width('100%')
              }
              Grid() {
                ForEach(item.cityList, (city: City) => {
                  GridItem() {
                    Text(city.cityName)
                      .fontSize(20)
                      .textAlign(TextAlign.Center)
                      .onClick(() => {
                        this.confirm(city);
                        this.update();
                        this.controller.close();
                      })
                  }
                  .border({ width: 0.5, color: Color.Gray })
                  .borderRadius(8)
                  .width('100%')
                  .height(60)
                })
              }
              .columnsTemplate('1fr 1fr 1fr 1fr')
              .rowsTemplate('repeat(auto-fit, 60)')
              .rowsGap(8)
              .columnsGap(8)
            }
          }
          .tabBar(item.title)
        })
      }
      .barMode(BarMode.Fixed)
      .barWidth(100)
      .vertical(true)


      Button('取消')
        .onClick(() => {
          this.cancel();
          this.controller.close();
        })
        .margin({ top: 20, bottom: 20 })
        .backgroundColor(Color.Orange)

    }
    .width('100%')
    .borderRadius(12)
  }
}
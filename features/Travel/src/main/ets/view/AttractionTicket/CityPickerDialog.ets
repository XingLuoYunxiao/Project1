import { City } from "../../service/CategoryData";


@CustomDialog
export struct CityPickerDialog {
  controller: CustomDialogController;
  confirm: (city: City) => void = () => {};
  update: () => void = () => {};
  cancel: () => void = () => {};

  private cities: City[] = [
    { cityName: '所有', cityId: '0' },
    { cityName: '北京', cityId: '2' },
    { cityName: '上海', cityId: '1' },
    { cityName: '广州', cityId: '3' },
    { cityName: '深圳', cityId: '4' }
  ];

  build() {
    Column() {
      Text('选择城市')
        .fontSize(20)
        .margin({ top: 20, bottom: 20 })

      List() {
        ForEach(this.cities, (city: City) => {
          ListItem() {
            Text(city.cityName)
              .fontSize(16)
              .padding(16)
              .width('100%')
              .onClick(() => {
                this.confirm(city);
                this.update();
                this.controller.close();
              })
          }
          .width('100%')
        })
      }
      .width('100%')

      Button('取消')
        .onClick(() => {
          this.cancel();
          this.controller.close();
        })
        .margin({ top: 20, bottom: 20 })
        .backgroundColor(Color.Orange)

    }
    .width('80%')
    .borderRadius(12)
  }
}
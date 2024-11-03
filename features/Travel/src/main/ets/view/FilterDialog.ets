@CustomDialog
export struct FilterDialog {
  controller: CustomDialogController;
  confirm: (filters: string[]) => void = () => {};
  cancel: () => void = () => {};

  @State selectedFilters: string[] = [];
  private filters: string[] = ['免费WiFi', '停车场', '餐厅', '适合儿童', '无障碍设施'];

  build() {
    Column() {
      Text('筛选条件')
        .fontSize(20)
        .margin({ top: 20, bottom: 20 })

      List() {
        ForEach(this.filters, (filter: string) => {
          ListItem() {
            Row() {
              Text(filter)
                .fontSize(16)
              Toggle({ type: ToggleType.Checkbox })
                .onChange((isOn: boolean) => {
                  if (isOn) {
                    this.selectedFilters.push(filter);
                  } else {
                    let index = this.selectedFilters.indexOf(filter);
                    if (index > -1) {
                      this.selectedFilters.splice(index, 1);
                    }
                  }
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .padding(16)
          }
        })
      }

      Row() {
        Button('重置')
          .onClick(() => {
            this.selectedFilters = [];
          })
        Button('确定')
          .onClick(() => {
            this.confirm(this.selectedFilters);
            this.controller.close();
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top: 20, bottom: 20 })
    }
    .width('80%')
    .backgroundColor(Color.White)
    .borderRadius(12)
  }
}
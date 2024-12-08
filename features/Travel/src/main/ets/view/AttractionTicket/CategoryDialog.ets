import { CategoryItem } from "../../service/CategoryData";
import Constants from "../../constants/Constants";

@CustomDialog
export struct CategoryDialog {
  controller: CustomDialogController;

  @Prop index:number
  @Prop categories: CategoryItem[];
  onSelect: (category: CategoryItem) => void = () => {};

  build() {
    Column() {
      Tabs(){
          ForEach(this.categories, (category: CategoryItem) => {
            TabContent(){
              Column(){
                ForEach(category.subCategories, (subCategory: CategoryItem) => {
                  ListItem(){
                    Text(subCategory.name)
                      .fontSize(Constants.FONT_CONTENT)
                      .fontWeight(FontWeight.Bold)

                  }
                  .height(60)
                  .padding(10)
                  .onClick(() => {
                    this.onSelect(subCategory);
                    this.controller.close();
                  })
                })
              }
              .layoutWeight(1)
              .margin({left: Constants.MARGIN_LG})

            }
            .tabBar(category.name)
          })
      }
      .barWidth(120)
      .vertical(true)

      Button('取消')
        .width(Constants.OUTER_WIDTH)
        .margin({ top: Constants.MARGIN_LG })
        .onClick(() => {
          this.controller.close();
        })
        .backgroundColor(Color.Orange)
    }
    .width(Constants.OUTER_WIDTH)
    .padding(Constants.MARGIN_LG)
    .backgroundColor(Color.White)
    .borderRadius(Constants.BORDER_RADIUS)
  }
}
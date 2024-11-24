import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from "routermodule";
import { classification, classificationList, colorList } from "../service/ClassficationData";


@Component
export struct Classification {
  @Consume('travelPathStack') travelPathStack: NavPathStack;
  @Consume('appPathStack') appPathStack: NavPathStack;


  build() {
    //景点分类
    Row() {
      ForEach(classificationList, (item:classification, index) => {
        ListItem(){
          this.myClassBuilder(item, index)
        }
        .onClick( () => {
          //this.appPathStack.pushPathByName(item.page === undefined ? 'AttractionTicketPage' : item.page, item.category);
          if( item.page === undefined)
            buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_ATTRACTIONTICKETPAGE, new Object({text: item.category}));
          else
            buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.TRAVEL_FAMOUSPLACEPAGE, new Object({category: item.category}));
        })
      })
    }
    .borderRadius(12)
    .justifyContent(FlexAlign.SpaceAround)
    .width('100%')
    .height(100)
    .backgroundColor(Color.White)
  }

  @Builder myClassBuilder(item: classification, index:number){
    Column(){
      Image(item.image)
        .width(30)
        .height(30)
      Text(item.category)
        .fontSize(16)
        .fontColor(Color.White)
        .margin({top:10})
        .width('100%')
        .maxLines(1)
        .textAlign(TextAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width(80)
    .borderRadius(20)
    .height(70)
    .backgroundColor(colorList[index].color)
  }
}
import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from "routermodule";
import { BreakpointConstants } from "utils";
import { classification, classificationList, classificationListPhone, colorList } from "../service/ClassficationData";


@Component
export struct Classification {
  @Consume('travelPathStack') travelPathStack: NavPathStack;
  @Consume('appPathStack') appPathStack: NavPathStack;
  @StorageLink('currentWidthBreakpoint') currentWidthBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;


  build() {
    //景点分类
    Row() {
      ForEach(this.currentWidthBreakpoint === BreakpointConstants.BREAKPOINT_SM ? classificationListPhone : classificationList, (item:classification, index) => {
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
        .maxFontSize(20)
        .minFontSize(12)
        .heightAdaptivePolicy(TextHeightAdaptivePolicy.MAX_LINES_FIRST)
        .fontColor(Color.White)
        .margin({top:10})
        .width('100%')
        .maxLines(1)
        .textAlign(TextAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width('15%')
    .borderRadius(20)
    .height(70)
    .backgroundColor(colorList[index].color)
    .shadow({
      color: '#cccccc',
      radius: 5,
      offsetX: 0,
      offsetY: 2,
    });
  }
}
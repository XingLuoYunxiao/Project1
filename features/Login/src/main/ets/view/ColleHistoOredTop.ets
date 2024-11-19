import { XsCalendar } from '@xsqd/component'
import { myOrder } from '../model/myOrder'

@Component
export struct CollectHistoryView {
  @Consume('appPathStack') appPathStack: NavPathStack
  @State manage:string='管理'
  @State Attractions:myOrder[] = []
  @Prop title:string
  @Prop tabbarfirst:string
  @Prop tabbarsecond:string

  getData(data:myOrder){
    this.Attractions.push(data);
  }

  build() {
    Column() {
      Row(){
        Image($r('app.media.swiper2')).width(30).onClick(()=>{
          this.appPathStack.pop()
        })
        Text(this.title)
        Image($r('app.media.search')).width(30)
        Text(this.manage).onClick(()=>{
          this.manage='退出管理'

        })
      }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      if(this.title==='浏览记录'){
        Row(){
          XsCalendar({
            Color: {
              backgroundColor: "#eeeeee",
              selectedDayBgColor: "red",
              noMonthDayColor: "#ff5b0000"
            },
            CalendarStyle: {
              textScaling: 0.8
            },
            CalendarType: {
              isDown: true,
              isTitle:true,
              isTopWeek:true
            },
            onCalendarClick: ()=>{

            }
          })
        }
      }
      Tabs(){
        TabContent(){
          Column(){
            List(){
              ForEach(this.Attractions,(item:myOrder)=>{
                ListItem(){

                }
              })
            }
          }.height('100%')
        }.tabBar(this.tabbarfirst)
        TabContent(){
          Column(){

          }
        }.tabBar(this.tabbarsecond)
      }
    }
    .width('100%')
  }

}
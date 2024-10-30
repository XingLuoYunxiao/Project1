import { XsCalendar } from '@xsqd/calendar'
import { CollectHistoryMore } from '../model/CollectHistoryModel'

@Component
export struct CollectHistoryView {
  @Consume ('loginPathStack') loginPathStack: NavPathStack
  @State manage:string='管理'
  @State Attractions: CollectHistoryMore[] = [
  // new Collection(0, "秦始皇兵马俑博物馆", $r("app.media.ic_arrow"), "秦始皇兵马俑博物馆位于陕西省西安市，是中国最著名的考古遗址之一，展示了秦始皇的陵墓及其壮观的兵马俑军队。"),
  // new Collection(1, "大雁塔", $r("app.media.ic_arrow"), "大雁塔是唐代著名的佛塔，位于陕西省西安市，是玄奘法师为保存从印度带回的佛经而建。"),
  // new Collection(2, "西安城墙", $r("app.media.ic_arrow"), "西安城墙是中国现存规模最大、保存最完整的古代城垣，是明代初年在唐长安城的基础上扩建而成的。"),
  // new Collection(3, "钟楼", $r("app.media.ic_arrow"), "钟楼位于西安市中心，是明代建筑的典范，历史上用于晨钟暮鼓，现在是西安的标志性建筑之一。"),
  // new Collection(4, "大唐不夜城",  $r("app.media.ic_arrow"), "大唐不夜城位于陕西省西安市，是一个集文化、旅游、商业于一体的综合性旅游景区，以唐代皇家园林为主题，展现了盛唐时期的繁荣景象。"),
  ]
  @Prop title:string
  @Prop tabbarfirst:string
  @Prop tabbarsecond:string

  getData(data:CollectHistoryMore){
    this.Attractions.push(data);
  }

  build() {
    Column() {
      Row(){
        Image($r('app.media.ic_back')).width(30).onClick(()=>{
          this.loginPathStack.pop()
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
              ForEach(this.Attractions,(item:CollectHistoryMore)=>{
                ListItem(){
                  Row(){
                    Image(item.image).width(50)
                    Text(item.title)
                  }.width('100%')
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
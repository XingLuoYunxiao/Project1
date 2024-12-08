import { CalendarData, CalendarStyle, CalendarType, ColorType, Day, MyTime } from '../model/CalendarModel'
@Component
export struct MyCalendar {
    @State private month: number = 1; // 当前月份
    @State private year: number = 2024; // 当前年份
    @State private week: number = 1; // 当前展示的本月第几周
    @State private days: Day[][] = []; // 日期数据
    @State private today: number = new Date().getDate();
    @State private todayMoth: number = new Date().getMonth()+1;
    @State private todayYear: number = new Date().getFullYear();
    @State @Watch("setWeek") private date: number = 0; // 当前选中日期

    private weeks: string[] = ["日", "一", "二", "三", "四", "五", "六"];
    private months: string[] = ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"];

     // 0：月历，显示一月的日期；
     // 1：周历，显示一周的日期；
    @State calendarState: number = 1;

    Color: ColorType = {};

     //日历样式配置
    CalendarStyle: CalendarStyle = {}

    CalendarType: CalendarType = {}

     // 需要显示小点提示的日期，
    @Prop @Watch("setWeek") contains: Map<string, string> = new Map()

     //选择日历后的回调, 返回的函数为更新当前页面的回调函数
    onCalendarClick: (item:CalendarData)=>void = ()=>{};

    aboutToAppear(): void {
      // 当前年月日
      this.month = new Date().getMonth()+1;
      this.year = new Date().getFullYear();
      this.date = new Date().getDate();
      //获取本月所有日期
      this.getWeeks();
      this.setWeekDaysIs();
      this.setWeek();

      this.onCalendarClick({
        date: this.date,
        month: this.month,
        year: this.year
      })
    }

    //设置选中项的状态
  private setWeekDaysIs(){
      for (let i = 0; i < this.days.length; i++) {
        for (let j = 0; j < this.days[i].length; j++) {
          // 是选中的天，则设为true 反之为false
          if (this.days[i][j].dayNum === this.date){
            this.days[i][j].is = true
          }else {
            this.days[i][j].is = false
          }
          this.days[i][j].containIs = this.contains.get(this.year+"_"+this.month+"_"+this.days[i][j].dayNum) != undefined;

          // 上月
          if (i === 0 && this.days[i][j].dayNum > 7){
            this.days[i][j].is = false;
            // 设置这一天有没有事件
            let year = this.month === 1? this.year - 1:this.year;
            let month = this.month === 1? 12 : this.month - 1
            this.days[i][j].containIs = this.contains.get(year+"_"+month+"_"+this.days[i][j].dayNum) != undefined;
          }

          // 下月
          if (i > 2 && this.days[i][j].dayNum < 7){
            this.days[i][j].is = false;
            // 设置这一天有没有事件
            let year = this.month === 12? this.year + 1:this.year;
            let month = this.month === 12? 1 : this.month + 1;
            this.days[i][j].containIs = this.contains.get(year+"_"+month+"_"+this.days[i][j].dayNum) != undefined;
          }
        }
      }
      this.days = [...this.days];
    }
    private setWeek(){
      // 设置选中周
      let date = new Date();
      date.setFullYear(this.year);
      date.setMonth(this.month-1);
      date.setDate(this.date);
      this.week = MyTime.getWeekOfMonth(date);
      // 设置选中项的状态
      this.setWeekDaysIs()
    }

  //获取某年某月的所有日期
    private getWeeks(){
      this.days = [...MyTime.byMonthDayForYear(this.year, this.month)];
    }

    //切换月份
    private nextMouth(is: boolean){
      if (is) {
        this.year = (this.month + 1 > 12) ? this.year + 1 : this.year;
        this.month = (this.month + 1 > 12) ? 1 : this.month + 1;
      } else {
        this.year = (this.month - 1 < 1) ? this.year - 1 : this.year;
        this.month = (this.month - 1 < 1) ? 12 : this.month - 1;
      }

      this.getWeeks();
      this.setWeekDaysIs();
      this.setWeek();
    }


    // 图片大小
    @Styles _imageSize(){
      .height(24 * (this.CalendarStyle.textScaling?this.CalendarStyle.textScaling:1))
    }
    // 一天的子组件
    @Builder DayBuilder(day: Day, color: Color | number | string | Resource, week: number){
      Column({space: 2}){
        Column(){
          Text(day.dayNum+"")
            .fontColor(day.is?
              ((this.Color.selectedDayTextColor)? this.Color.selectedDayTextColor:"#fff"): (color))
            .fontSize(16 * (this.CalendarStyle.textScaling?this.CalendarStyle.textScaling:1))
            .fontWeight(FontWeight.Medium)
          Text(day.lunarDay)
            .fontColor(day.is?
              (this.Color.selectedDayTextColor?this.Color.selectedDayTextColor:"#fff"):
              (this.Color.lunarColor?this.Color.lunarColor:"#999999"))
            .fontSize(10 * (this.CalendarStyle.textScaling?this.CalendarStyle.textScaling:1))
        }.width(40)
        .height(40)
        .borderRadius(40)
        .borderWidth((this.year === this.todayYear && this.month === this.todayMoth && day.dayNum == this.today)?1:0)
        .borderColor("#24A844")
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(day.is? (this.Color.selectedDayBgColor?this.Color.selectedDayBgColor:"#24A844"):(this.Color.backgroundColor))
        .onClick(()=>{
          // 点击切换日期
          if (week == 1 && day.dayNum > 7) {
            this.nextMouth(false)
          }
          // 选中了下月的日期
          if (week > 2 && day.dayNum < 7) {
            this.nextMouth(true)
          }
          this.date = day.dayNum;

          this.onCalendarClick({
            date: this.date,
            year: this.year,
            month: this.month
          })
        })

        if (day.containIs){
          Row().width(4)
            .height(4)
            .borderRadius(4)
            .backgroundColor(this.Color.containColor ? this.Color.containColor : "#24A844")
        }
      }.alignItems(HorizontalAlign.Center)
      .width(40)
      .height(44)
    }
    // 显示周几
    @Builder Week(){
      Row(){
        ForEach(this.weeks, (text: string, index: number)=>{
          Text(text)
            .fontSize(10 * (this.CalendarStyle.textScaling?this.CalendarStyle.textScaling:1))
            .fontColor((index === 0 || index === 6)?
              (this.Color.topWeekendColor?this.Color.topWeekendColor:"#999999"):
              (this.Color.topWeekdayColor?this.Color.topWeekdayColor:"#000"))
            .width(40)
            .textAlign(TextAlign.Center)
            .offset({x: -4})
        },(text: string, index: number) => {return text+ index})
      }.width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({left: 6, bottom: 5})
    }


    build() {
      Stack(){
        Column(){
          // 周、月切换
          if ((this.CalendarType.isTitle === undefined ? true : this.CalendarType.isTitle) && this.calendarState === 0) {
            Row(){
              // 上一页
              Image($r('app.media.leftarrow'))
                ._imageSize()
                .onClick(()=>{
                  this.nextMouth(false)
                })

              // 日期
              Row(){
                Text(`${this.year}年 ${this.months[this.month-1]} `)
                  .fontSize(16 * (this.CalendarStyle.textScaling?this.CalendarStyle.textScaling:1))

                Blank()

                if (!(this.month === this.todayMoth && this.year === this.todayYear && this.date === this.today)){
                  Text("今天")
                    .fontSize(16 * (this.CalendarStyle.textScaling?this.CalendarStyle.textScaling:1))
                    .onClick(()=>{
                      this.year = this.todayYear;
                      this.month = this.todayMoth;
                      this.date = this.today;
                      this.getWeeks();
                      this.setWeekDaysIs();
                      this.setWeek();
                    })
                }

              }.layoutWeight(1)
              .padding({left: 15, right: 15})

              // 下一页
              Image($r('app.media.ic_arrow'))
                ._imageSize()
                .onClick(()=>{
                  this.nextMouth(true)
                })
            }
            .padding({left: 10, right: 10, top: 7, bottom: 7})
            .width("100%")
          }

          // 日期显示
          Column(){
            // 显示周几
            if (this.CalendarType.isTopWeek === undefined ? true : this.CalendarType.isTopWeek){
              this.Week()
            }

            ForEach(this.days, (items: Day[], index: number)=>{
              if (!this.calendarState || index == this.week-1)
              Row(){
                ForEach(items, (item: Day)=>{
                  this.DayBuilder(
                    item,
                    ((item.dayNum>7 && index == 0)||(index>3 && item.dayNum<7))?
                      (this.Color.noMonthDayColor ? this.Color.noMonthDayColor : "#999"):
                      (this.Color.monthDayColor ? this.Color.monthDayColor : "#000"),
                    index+1
                  )
                }, (item: Day, index: number)=>{return item.dayNum + "" + item.is + item.containIs + "" + index})
              }.width("100%")
              .justifyContent(FlexAlign.SpaceBetween)

            }, (item: Day[], index: number)=>{return item.reduce((item1, item2)=>{
              return item1 + "" + item2.dayNum + item2.is + item2.containIs
            }, '') + "" + index + ''})

          }.padding({left: 10, right: 10, top: this.calendarState===0?3:10, bottom: 3})

          // 日历的状态切换
          if (this.CalendarType.isDown === undefined ? true : this.CalendarType.isDown) {
            Row(){
              Image(this.calendarState===0?$r('app.media.ic_arrow_up'):$r('app.media.ic_arrow_down'))
                ._imageSize()
                .scale({
                  x: 0.8,
                  y: 0.8
                })
            }.width("100%")
            .justifyContent(FlexAlign.Center)
            .onClick(()=>{
              animateTo({duration:200},()=>{
                this.calendarState = this.calendarState===0?1:0;
              })
            })
          }
        }.width("100%")
        .id("calendar")
        .backgroundColor(this.Color.backgroundColor?this.Color.backgroundColor:"#fff")
      }
    }
}

export { CalendarData };

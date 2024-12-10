import I18n from '@ohos.i18n';

export class MyTime{

   // 给定日期是当月的第几周
  static getWeekOfMonth(date: Date): number {
    // 获取本月的第一天
    const firstDayOfMonth = new Date(date.getFullYear(), date.getMonth(), 1);//2024.11.1

    // 计算该日期与本月第一天之间的天数
    const daysSinceFirstDay = (date.getTime() - firstDayOfMonth.getTime()) / (1000 * 60 * 60 * 24);//25

    // 计算本月的第一天是星期几
    const firstDayOfWeek = firstDayOfMonth.getDay();//5

    // 计算该日期是本月的第几周
    const weekOfMonth = Math.floor((daysSinceFirstDay + firstDayOfWeek) / 7) + 1;
    // const weekOfMonth =(daysSinceFirstDay%7+firstDayOfWeek)%7

    return weekOfMonth;
  }


  // 给定日期是星期几
  static getWeekDay(year: number, month: number, day: number): number {
    const date = new Date(year, month - 1, day);
    return date.getDay();
  }


   //给定年份和月份的最后一天是几号
  static getLastDayOfMonth(year: number, month: number): number {
    return new Date(year, month, 0).getDate();
  }


   //获取前一个月的最后几天
   //firstDayOfWeek 当前月份的第一天是周几
  static getPreviousMonthLastDays(year: number, month: number, firstDayOfWeek: number): number[] {
    const days: number[] = [];
    const lastDayOfPreviousMonth = MyTime.getLastDayOfMonth(year, month - 1);
    for (let i = lastDayOfPreviousMonth - firstDayOfWeek + 1; i <= lastDayOfPreviousMonth; i++) {
      days.push(i);
    }
    return days;
  }


   //用于生成当前月份的所有天数的数组
  static getCurrentMonthDays(year: number, month: number): number[] {
    const days: number[] = [];
    const lastDayOfMonth = MyTime.getLastDayOfMonth(year, month);
    for (let i = 1; i <= lastDayOfMonth; i++) {
      days.push(i);
    }
    return days;
  }


  //返回农历月份的中文表示
  //month 农历月
  static lunarMonthToChinese(month: number): string {
    const chineseMonth = ['正', '二', '三', '四', '五', '六', '七', '八', '九', '十', '十一', '腊'];
    // 检查是否是闰月
    const isLeapMonth = month < 0;
    const lunarMonth = isLeapMonth ? -month : month;
    // 转换月份
    const chineseMonthStr = `${chineseMonth[lunarMonth - 1]}月`;
    // 如果是闰月，加上“闰”字
    return isLeapMonth ? `闰${chineseMonthStr}` : chineseMonthStr;
  }

// 农历日期的中文表示
//day 农历日
  static lunarDayToChinese(day: number): string {
    const chineseDay = ['初一', '初二', '初三', '初四', '初五', '初六', '初七', '初八', '初九', '初十',
      '十一', '十二', '十三', '十四', '十五', '十六', '十七', '十八', '十九', '二十',
      '廿一', '廿二', '廿三', '廿四', '廿五', '廿六', '廿七', '廿八', '廿九', '三十'];
    // 转换日期
    return chineseDay[day - 1];
  }

//获取某年某月的所有日期
  static byMonthDayForYear(year: number, month: number): Day[][] {
    const firstDayOfWeek = MyTime.getWeekDay(year, month, 1);
    const previousMonthDays = MyTime.getPreviousMonthLastDays(year, month, firstDayOfWeek);
    const currentMonthDays = MyTime.getCurrentMonthDays(year, month);

    const calendar: Day[][] = [];
    let week: Day[] = [];

    let i18nCalendar : I18n.Calendar = I18n.getCalendar("zh-Hans", "chinese");

    // 用上个月的天数填充第一周
    for (let i = 0; i < firstDayOfWeek; i++) {
      i18nCalendar.setTime(new Date(year, month-2, previousMonthDays[i]))
      week.push({
        dayNum: previousMonthDays[i],
        is: false,
        lunarDay: MyTime.lunarDayToChinese(i18nCalendar.get("date"))
      });
    }

    // 用当月的天数填充剩余的周数
    for (const day of currentMonthDays) {
      i18nCalendar.setTime(new Date(year, month-1, day))
      week.push({
        dayNum: day,
        is: false,
        lunarDay: i18nCalendar.get("date") == 1? MyTime.lunarMonthToChinese(i18nCalendar.get("month")+1): MyTime.lunarDayToChinese(i18nCalendar.get("date"))
      });
      if (week.length === 7) {
        calendar.push(week);
        week = [];
      }
    }

    // 用下个月的日子填满最后一周
    if (week.length > 0) {
      let x = (7-week.length)
      for (let index = 1; index <= x; index++) {
        i18nCalendar.setTime(new Date(year, month, index))
        week.push({
          dayNum: index,
          is: false,
          lunarDay: index === 0? MyTime.lunarMonthToChinese(i18nCalendar.get("month")+1): MyTime.lunarDayToChinese(i18nCalendar.get("date"))
        })
      }
      calendar.push(week);
    }
    return calendar;
  }
}



 //颜色配置
export interface ColorType{
  backgroundColor? : Color | number | string | Resource; // backgroundColor: 背景颜色
  topWeekendColor? : Color | number | string | Resource; // 周六周日的展示颜色
  topWeekdayColor? : Color | number | string | Resource; // 周一至周五的展示颜色
  monthDayColor? : Color | number | string | Resource; // 本月日期颜色
  noMonthDayColor? : Color | number | string | Resource; // 非本月的日期颜色
  containColor? : Color | number | string | Resource; // 提示的装饰点的颜色
  todayBgColor? : Color | number | string | Resource; // 当前日期的颜色
  todayTextColor? : Color | number | string | Resource; // 当前日期的颜色
  selectedDayTextColor? : Color | number | string | Resource; // 选中日期的文字颜色
  selectedDayBgColor? : Color | number | string | Resource; // 选中日期的背景颜色
  lunarColor? : Color | number | string | Resource; // 农历的文字颜色
}


export interface CalendarStyle{
  textScaling? : number; // 文字缩放比例
}

export interface CalendarType{
  isTopWeek?: boolean; // 是否展示周信息
  isTitle? : boolean; // 是否展示标题栏信息，年月周以及切换图标
  isDown? : boolean; // 是否展示底部的切换图标
}


export interface Day{
  dayNum: number, // 日期
  is: boolean, // 是否选择
  lunarDay: string, // 农历中文日期
  containIs?: boolean // 是否显示点
}

export interface CalendarData{
  year: number,
  month: number,
  date: number,
}
import { mediaquery } from '@kit.ArkUI';

// 定义一个泛型接口，用于描述各断点类型对应的值
declare interface BreakpointTypeOption<T> {
  xs?: T; // 超小屏幕
  sm?: T; // 小屏幕
  md?: T; // 中屏幕
  lg?: T; // 大屏幕
  xl?: T; // 超大屏幕
  xxl?: T; // 特大屏幕
}

// 定义一个泛型类，用于根据断点类型返回相应的值
export class BreakpointType<T> {
  options: BreakpointTypeOption<T>; // 存储各断点类型的值

  constructor(option: BreakpointTypeOption<T>) {
    this.options = option; // 初始化断点类型选项
  }

  // 根据当前断点获取对应的值
  getValue(currentBreakPoint: string) {
    if (currentBreakPoint === 'xs') {
      return this.options.xs;
    } else if (currentBreakPoint === 'sm') {
      return this.options.sm;
    } else if (currentBreakPoint === 'md') {
      return this.options.md;
    } else if (currentBreakPoint === 'lg') {
      return this.options.lg;
    } else if (currentBreakPoint === 'xl') {
      return this.options.xl;
    } else if (currentBreakPoint === 'xxl') {
      return this.options.xxl;
    } else {
      return undefined; // 如果传入的断点未定义，返回undefined
    }
  }
}

// 定义断点的结构体，包括名称、尺寸和媒体查询监听器
interface Breakpoint {
  name: string; // 断点名称
  size: number; // 断点大小（单位：vp）
  mediaQueryListener?: mediaquery.MediaQueryListener; // 媒体查询监听器
}

// 枚举定义常用的断点类型
export enum BreakpointTypeEnum {
  SM = 'sm', // 小屏幕
  MD = 'md', // 中屏幕
  LG = 'lg', // 大屏幕

}

// 断点系统类，用于管理断点逻辑
export class BreakpointSystem {
  private currentBreakpoint: string = "md"; // 当前的断点名称，默认为中屏幕
  private breakpoints: Breakpoint[] = [
    { name: 'sm', size: 320 }, // 小屏幕断点
    { name: 'md', size: 600 }, // 中屏幕断点
    { name: 'lg', size: 840 },// 大屏幕断点
  ];

  // 注册媒体查询监听器，动态监听断点变化
  public register() {
    this.breakpoints.forEach((breakpoint: Breakpoint, index) => {
      let condition: string;
      if (index === this.breakpoints.length - 1) {
        // 最后一个断点条件：断点尺寸小于等于当前宽度
        condition = '(' + breakpoint.size + 'vp<=width' + ')';
      } else {
        // 其他断点条件：断点尺寸范围
        condition = '(' + breakpoint.size + 'vp<=width<' + this.breakpoints[index + 1].size + 'vp)';
      }
      // 创建媒体查询监听器
      breakpoint.mediaQueryListener = mediaquery.matchMediaSync(condition);
      // 监听媒体查询变化事件
      breakpoint.mediaQueryListener.on('change', (mediaQueryResult) => {
        if (mediaQueryResult.matches) {
          this.updateCurrentBreakpoint(breakpoint.name); // 更新当前断点
        }
      });
    });
  }

  // 注销媒体查询监听器，释放资源
  public unregister() {
    this.breakpoints.forEach((breakpoint: Breakpoint) => {
      if (breakpoint.mediaQueryListener) {
        breakpoint.mediaQueryListener.off('change'); // 取消监听媒体查询变化事件
      }
    });
  }

  // 更新当前断点，如果断点发生变化则触发更新
  private updateCurrentBreakpoint(breakpoint: string) {
    if (this.currentBreakpoint !== breakpoint) {
      this.currentBreakpoint = breakpoint; // 更新当前断点
      // 存储当前断点到AppStorage
      AppStorage.setOrCreate<string>('currentBreakpoint', this.currentBreakpoint);
      console.log('on current breakpoint: ' + this.currentBreakpoint); // 打印当前断点日志
    }
  }
}

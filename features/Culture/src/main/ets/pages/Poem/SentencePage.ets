import cloud, { FunctionResult } from '@hw-agconnect/cloud'; // 导入云函数库
import { BasicDataSource } from '../../model/poetryModel/PoetryModel'; // 导入基本数据源
import { componentUtils, Filter, FilterParams, FilterResult, FilterType } from '@kit.ArkUI'; // 导入UI工具和筛选器相关模块
import { dynastyList, poets, TypeList } from '../../common/constants/poemType'; // 导入诗词相关常量数据
import { Poem } from '../../model/Poem'; // 导入诗歌模型类
import { GetPoemDataFormCloud } from '../../common/constants/CloundDb/getPoemDataFormCloudDb'; // 导入云数据库数据获取模块
import { PoemDetailPage } from './PoemDetailPage'; // 导入诗词详情页
import { Sentence } from '../../model/Sentence';
import { addExp } from '../../common/util/addExp';

let addEXPId: number = 0

@Component
export struct SentencePage { // 定义一个组件类PoemPage
  @Consume('culturePathStack') culturePathStack: NavPathStack; // 导入导航路径栈，用于页面导航
  @State pageNumber: number = 1; // 分页页码
  @State poemType: string = '全部'; // 当前筛选的诗歌类型
  @State poets: string = '全部'; // 当前筛选的诗人
  @State dynasty: string = '全部'; // 当前筛选的朝代
  private filterParam: Array<FilterParams> = [{ name: '类型', options: TypeList }, { name: '诗人', options: poets },
    { name: '朝代', options: dynastyList }]; // 筛选器参数

  // 生命周期方法：组件加载时调用，获取初始数据
  async aboutToAppear(): Promise<void> {
    // 从云数据库获取诗歌数据
    let sentence: Sentence [] | undefined = await GetPoemDataFormCloud.fetchSentence(this.pageNumber);
    if (sentence) {
      sentence.forEach(sentence => {
        SentenceData.pushData(sentence); // 添加数据到PoemData
      });
    }
    this.pageNumber++; // 增加页码

    //每10秒浏览页面加5经验
    addEXPId = setTimeout(() => {
      addExp('Idiom', 5)
    }, 10000)
  }

  aboutToDisappear(): void {
    // 退出页面时取消对经验值的添加
    clearTimeout(addEXPId)
  }

  // 构建组件UI结构
  build() {
    Column() {

      // 展示数据的列表组件
      List({ space: 10 }) {
        // 使用LazyForEach动态加载诗歌数据
        LazyForEach(SentenceData, (item: Sentence) => {
          this.SentenceItem(item); // 渲染单个诗歌项
        },
          (item: Sentence) => item.id) // 以numId为唯一标识
      }
      .edgeEffect(EdgeEffect.Spring) // 滑动边缘效果
      .cachedCount(15) // 缓存项数
      .id('poemList') // 列表ID
      .onReachEnd(async () => { // 滑动到底部时触发
        this.pageNumber++; // 页码增加
        let res: Sentence[] | undefined =
          await GetPoemDataFormCloud.fetchSentence(this.pageNumber);
        if (res) {
          console.log('滑倒底部触发更新');
          res.forEach(sentence => {
            SentenceData.pushData(sentence); // 添加数据
          });
          SentenceData.notifyDataReload(); // 通知数据更新
        }
      });

    }

    .width('100%'); // 设置宽度
  }

  // 渲染单个诗歌项
  @Builder
  SentenceItem(sentence: Sentence) {
    Column({ space: 10 }) {

      Row() {
        Text(sentence.text)
          .fontSize($r('app.float.normal_text_size1'));
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Row() {
        Text('——' + sentence.from)
          .fontSize($r('app.float.normal_text_size1'));
      }
      .width('100%')
      .justifyContent(FlexAlign.End)

    }
    .borderRadius(25) // 圆角
    .backgroundColor('#fff5eee6') // 背景颜色
    .padding(20) // 内边距
    .justifyContent(FlexAlign.Center) // 垂直居中
    .width('100%') // 宽度
    .onClick(async () => { // 点击事件
      let name: string | null = extractPoet(sentence.from)
      let title: string | null = extractTitle(sentence.from)
      let poem: Poem[] | undefined = undefined
      console.log(name)
      console.log(title)
      if (name && title) {
        poem = await GetPoemDataFormCloud.fetchDataByWriterAndTitle(name, title)
        console.log(JSON.stringify(poem));
      }
      if (poem) {
        this.culturePathStack.pushPathByName("PoemDetailPage", poem[0]); // 跳转到诗歌详情页
      }

    });
  }
}

// 诗歌数据模型类，继承自BasicDataSource
class SentenceModel extends BasicDataSource<Sentence> {
  data: Array<Sentence> = []; // 诗歌数据数组

  // 获取指定索引的数据
  public getData(index: number): void | Sentence {
    if (index === this.data.length - 1) {
    }
    return this.data[index];
  }
}

const SentenceData: SentenceModel = new SentenceModel(); // 诗歌数据实例

function extractPoet(input: string): string | null {
  const match = input.match(/^(.+?)《.+》$/); // 匹配诗人部分
  return match ? match[1].trim() : null; // 返回诗人，去除多余空格
}

function extractTitle(input: string): string | null {
  const match = input.match(/^.+《(.+?)》$/); // 匹配标题部分
  return match ? match[1].trim() : null; // 返回标题，去除多余空格
}

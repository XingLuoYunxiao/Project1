import { BasicDataSource } from '../../model/poetryModel/PoetryModel'; // 导入基本数据源

import { Poem } from '../../model/Poem'; // 导入诗歌模型类
import { CloudPoemService } from "../../service/CloudPoemService";
import { Sentence } from '../../model/Sentence';
import { addExp } from '../../common/util/addExp';
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from 'routermodule';
import { CommonConstants } from '../../common/constants/commonConstants';
import { BreakpointTypeEnum } from 'utils';

let addEXPId: number = 0

@Component
export struct SentencePage { // 定义一个组件类PoemPage
  @Consume('culturePathStack') culturePathStack: NavPathStack; // 导入导航路径栈，用于页面导航
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointTypeEnum.MD;
  @State pageNumber: number = 1; // 分页页码
  @State poemType: string = '全部'; // 当前筛选的诗歌类型
  @State poets: string = '全部'; // 当前筛选的诗人
  @State dynasty: string = '全部'; // 当前筛选的朝代

  // 生命周期方法：组件加载时调用，获取初始数据
  async aboutToAppear(): Promise<void> {
    console.log("当前的断点" + this.currentBreakpoint)
    // 从云数据库获取诗歌数据
    let sentence: Sentence [] | undefined = await CloudPoemService.fetchSentence(this.pageNumber);
    if (sentence) {
      sentence.forEach(sentence => {
        SentenceData.pushData(sentence); // 添加数据到PoemData
      });
    }
    this.pageNumber++; // 增加页码

    //每10秒浏览页面加5经验
    addEXPId = setTimeout(() => {
      addExp(CommonConstants.expTypeKnowledge, 5)
    }, 10000)
  }

  aboutToDisappear(): void {
    // 退出页面时取消对经验值的添加
    clearTimeout(addEXPId)
  }

  // 构建组件UI结构
  build() {
    NavDestination() {
      Column() {
        if (this.currentBreakpoint === 'sm' || this.currentBreakpoint === 'md') {
          // 展示数据的列表组件
          List({ space: 10 }) {
            // 使用LazyForEach动态加载诗歌数据
            LazyForEach(SentenceData, (item: Sentence) => {
              this.SentenceItem(item, true); // 渲染单个诗歌项
            },
              (item: Sentence) => item.id.toString()) // 以numId为唯一标识
          }
          .edgeEffect(EdgeEffect.Spring)
          .cachedCount(15)
          .id('poemList')
          .onReachEnd(async () => {
            this.pageNumber++; // 页码增加
            let res: Sentence[] | undefined =
              await CloudPoemService.fetchSentence(this.pageNumber);
            if (res) {
              console.log('滑倒底部触发更新');
              res.forEach(sentence => {
                SentenceData.pushData(sentence);
              });
              SentenceData.notifyDataReload();
            }
          });
        } else {

          Grid() {
            LazyForEach(SentenceData, (item: Sentence, index: number) => {
              GridItem() {
                this.SentenceItem(item, true);
              }

            },
              (item: Sentence) => item.id.toString())
          }
          .rowsGap(8)
          .columnsTemplate('1fr 1fr')
          .edgeEffect(EdgeEffect.Spring)
          .cachedCount(15)
          .id('poemList')
          .onReachEnd(async () => {
            this.pageNumber++; // 页码增加
            let res: Sentence[] | undefined =
              await CloudPoemService.fetchSentence(this.pageNumber);
            if (res) {
              console.log('滑倒底部触发更新');
              res.forEach(sentence => {
                SentenceData.pushData(sentence); // 添加数据
              });
              SentenceData.notifyDataReload(); // 通知数据更新
            }
          });

        }

      }

      .width('100%'); // 设置宽度
    }

  }

  // 渲染单个诗歌项
  @Builder
  SentenceItem(sentence: Sentence, a: boolean) {
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
    .borderRadius(25)
    .backgroundColor('#fff5eee6')
    .padding(20) // 内边距
    .justifyContent(FlexAlign.Center)
    .width(a ? '100%' : '50%')
    .onClick(async () => {
      let name: string | null = extractPoet(sentence.from)
      let title: string | null = extractTitle(sentence.from)
      let poem: Poem | undefined = undefined
      console.log(name)
      console.log(title)
      if (name && title) {
        poem = await CloudPoemService.fetchDataByWriterAndTitle(name, title)
        console.log(JSON.stringify(poem));
      }
      if (poem) {
        //this.culturePathStack.pushPathByName("PoemDetailPage", poem[0]);
        buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.CULTURE_POEMDETAIL,
          new Object(poem))
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

@Builder
export function SentencePageBuilder() {
  SentencePage()
}

const builderName = BuilderNameConstants.CULTURE_SENTENCE
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(SentencePageBuilder)
  RouterModule.registerBuilder(builderName, builder)
}
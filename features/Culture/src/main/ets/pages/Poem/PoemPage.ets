import { Filter, FilterParams, FilterResult, FilterType } from '@kit.ArkUI'; // 导入UI工具和筛选器相关模块
import { dynastyList, poets, TypeList } from '../../common/constants/poemType'; // 导入诗词相关常量数据
import { Poem } from '../../model/Poem'; // 导入诗歌模型类
import { addExp } from '../../common/util/addExp';
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from 'routermodule';
import { CloudPoemService } from '../../service/CloudPoemService';
import { CommonConstants } from '../../common/constants/commonConstants';
import { LogUtil } from "utils/src/main/ets/puraUtils/LogUtil"
import { PoemModel } from '../../viewmodel/PoemViewModel';
import { talk } from './talk';

let addEXPId: number = 0

const TAG: string = 'PoemPage'

@Component
export struct PoemPage { // 定义一个组件类PoemPage
  @Consume('culturePathStack') culturePathStack: NavPathStack; // 导入导航路径栈，用于页面导航
  @State poems: Poem[] = []; // 诗歌数据的状态管理
  @State pageNumber: number = 1; // 分页页码
  @State poemType: string = '全部'; // 当前筛选的诗歌类型
  @State poets: string = '全部'; // 当前筛选的诗人
  @State dynasty: string = '全部'; // 当前筛选的朝代
  private filterParam: Array<FilterParams> = [{ name: '类型', options: TypeList }, { name: '诗人', options: poets },
    { name: '朝代', options: dynastyList }]; // 筛选器参数

  // 生命周期方法：组件加载时调用，获取初始数据
  async aboutToAppear(): Promise<void> {
    // 从云数据库获取诗歌数据
    let poems: Poem[] | undefined = await CloudPoemService.fetchAllData(this.pageNumber);
    if (poems) {
      poems.forEach(item => {
        PoemData.pushData(item); // 添加数据到PoemData
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
        // 筛选器组件
        Filter({
          multiFilters: this.filterParam, // 多个筛选条件
          filterType: FilterType.MULTI_LINE_FILTER, // 筛选类型
          onFilterChanged: async (select: Array<FilterResult>) => { // 筛选条件变化时的回调函数
            console.log('rec filter change');
            for (let filter of select) {
              console.log('name:' + filter.name + ',index:' + filter.index + ',value:' + filter.value);
              if (filter.name === '类型') {
                this.poemType = filter.value.toString(); // 更新筛选的诗歌类型
              } else if (filter.name === '诗人') {
                this.poets = filter.value.toString(); // 更新筛选的诗人
              } else if (filter.name = '朝代') {
                this.dynasty = filter.value.toString(); // 更新筛选的朝代
              }
            }
            this.pageNumber = 1; // 重置页码
            PoemData.data = []; // 清空当前数据
            PoemData.notifyDataReload(); // 通知数据重载
            // 根据筛选条件从云数据库获取数据
            let res: Poem[] | undefined =
              await CloudPoemService.fetchPoem(this.poets, this.poemType, this.dynasty, this.pageNumber);
            if (res) {
              res.forEach(poem => {
                PoemData.pushData(poem); // 添加数据到PoemData
              });
              PoemData.notifyDataReload(); // 通知数据更新
            }
          }
        }) {
          Column() {
            // 展示数据的列表组件
            List({ space: 10 }) {
              // 使用LazyForEach动态加载诗歌数据
              LazyForEach(PoemData, (item: Poem) => {
                this.PoemItem(item); // 渲染单个诗歌项
              },
                (item: Poem) => item.id.toString()) // 以numId为唯一标识
            }
            .edgeEffect(EdgeEffect.Spring) // 滑动边缘效果
            .cachedCount(15) // 缓存项数
            .id('poemList') // 列表ID
            .onReachEnd(async () => { // 滑动到底部时触发
              this.pageNumber++; // 页码增加
              let res: Poem[] | undefined =
                await CloudPoemService.fetchPoem(this.poets, this.poemType, this.dynasty, this.pageNumber);
              if (res) {
                console.log('滑倒底部触发更新');
                res.forEach(poem => {
                  PoemData.pushData(poem); // 添加数据
                });
                //PoemData.notifyDataReload(); // 通知数据更新
              }
            })
          }
          .width('100%')
        }

      }
      .width('100%'); // 设置宽度
    }

  }

  // 渲染单个诗歌项
  @Builder
  PoemItem(poem: Poem) {
    Column({ space: 10 }) {

      Text(poem.title)// 诗歌标题
        .fontSize($r('app.float.normal_text_size1'));
      Text(poem.writer)// 诗人
        .fontSize($r('app.float.normal_text_size1'));
      Text(poem.dynasty)// 朝代
        .fontSize($r('app.float.normal_text_size1'));
      Text(poem.content)// 诗歌内容
        .fontSize($r('app.float.normal_text_size1'));
    }
    .borderRadius(25) // 圆角
    .backgroundColor('#fff5eee6') // 背景颜色
    .padding(20) // 内边距
    .justifyContent(FlexAlign.Center) // 垂直居中
    .width('100%') // 宽度
    .onClick(() => { // 点击事件
      buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.CULTURE_POEMDETAIL,
        new Object(poem))
    });
  }
}


const PoemData: PoemModel = new PoemModel(); // 诗歌数据实例

@Builder
export function PoemPageBuilder() {
  PoemPage()
}

const builderName = BuilderNameConstants.CULTURE_POEM
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(PoemPageBuilder)
  RouterModule.registerBuilder(builderName, builder)
}
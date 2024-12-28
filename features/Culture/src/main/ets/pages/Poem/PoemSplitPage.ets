import { poets, TypeList } from '../../common/constants/poemType'; // 导入诗词相关常量数据
import { Poem } from '../../model/Poem'; // 导入诗歌模型类
import { addExp } from '../../common/util/addExp';
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from 'routermodule';
import { CloudPoemService } from '../../service/CloudPoemService';
import { CommonConstants } from '../../common/constants/commonConstants';
import { LogUtil } from "utils/src/main/ets/puraUtils/LogUtil"
import { PoemModel } from '../../viewmodel/PoemViewModel';
import { BreakpointTypeEnum, CacheUtil } from 'utils';
import { CustomDialogType } from '../../Diaog/type';
import { PoetsCustomDialog } from '../../Diaog/poets';

let addEXPId: number = 0

const TAG: string = 'PoemPage'

@Component
export struct PoemSplitPage { // 定义一个组件类PoemPage
  @State PoemDataModel: PoemModel = new PoemModel(); // 诗歌数据实例
  @Consume('culturePathStack') culturePathStack: NavPathStack; // 导入导航路径栈，用于页面导航
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointTypeEnum.MD;
  @State poems: Poem[] = []; // 诗歌数据的状态管理
  @State pageNumber: number = 1; // 分页页码
  @State changeValue: string = ''
  @State @Watch('changeType') curPoemType: string = '全部'; // 当前筛选的诗歌类型
  @State @Watch('changePoet') curPoets: string = '全部'; // 当前筛选的诗人
  @State curDynastyIndex: number | number[] = 0; // 当前筛选的朝代
  @State cacheList: string[] = []
  @State IsTypeExpand: boolean = true
  @State dynastyList: string[] = [
    "全部", "先秦", "两汉", "隋代", "唐代", "宋代", "明代", "清代"
  ];
  @State @Watch('changeDynasty') curDynasty: string = '全部'; // 当前筛选的朝代
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogType({
      type: this.curPoemType
    }),
  })
  PoetDialogController: CustomDialogController = new CustomDialogController({
    builder: PoetsCustomDialog({
      poets: this.curPoets
    }),
  })

  async changeType() {
    this.pageNumber = 1
    this.PoemDataModel.data = []
    this.fetchData()
  }

  async changeDynasty() {
    this.pageNumber = 1

    this.PoemDataModel.data = []
    this.fetchData()
  }

  async changePoet() {
    this.pageNumber = 1
    this.PoemDataModel.data = []
    this.fetchData()
  }

  // 生命周期方法：组件加载时调用，获取初始数据
  async aboutToAppear(): Promise<void> {
    this.fetchData()
    addEXPId = setTimeout(() => {
      addExp(CommonConstants.expTypeKnowledge, 5)
    }, 10000)
  }

  async fetchData() {
    this.pageNumber++; // 页码增加
    let res: Poem[] | undefined =
      await CloudPoemService.fetchPoem(this.curPoets, this.curPoemType, this.curDynasty, this.pageNumber);
    if (res) {
      console.log('触发数据获取');
      res.forEach(poem => {
        this.PoemDataModel.pushData(poem); // 添加数据
      });

      this.PoemDataModel.notifyDataReload(); // 通知数据更新
    }
  }

  // 构建组件UI结构
  build() {
    NavDestination() {
      Search({ value: this.changeValue, placeholder: '搜你想搜的诗词吧' })
        .onClick(() => {
          buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.CULTURE_SearchPage)
        })
      // 切换类型，诗人，朝代

      Row() {
        Text('类型： ' + this.curPoemType)
          .fontSize(20)
          .onClick(() => {
            this.dialogController.open()
          })

        Text('诗人：' + this.curPoets)
          .fontSize(20)
          .onClick(() => {
            this.PoetDialogController.open()
          })

        Text('朝代：' + this.curDynasty)
          .fontSize(20)
          .onClick(() => {
            TextPickerDialog.show({
              // 建议使用 this.getUIContext().showTextPickerDialog()接口
              range: this.dynastyList,
              selected: this.curDynastyIndex,
              textStyle: { color: Color.Black, font: { size: 20, weight: FontWeight.Normal } },
              selectedTextStyle: { color: Color.Blue, font: { size: 30, weight: FontWeight.Bolder } },
              onAccept: (value: TextPickerResult) => {
                // 设置select为按下确定按钮时候的选中项index，这样当弹窗再次弹出时显示选中的是上一次确定的选项
                this.curDynastyIndex = value.index
                this.curDynasty = this.dynastyList[this.curDynastyIndex as number]
                console.log(this.curDynastyIndex + '')
              },
              onCancel: () => {
                console.info("TextPickerDialog:onCancel()")
              }
            })
          })
      }
      .justifyContent(FlexAlign.SpaceAround)
      .width('100%')
      .height(50)


      Column() {

        // 展示数据的列表组件
        List({ space: 10 }) {
          // 使用LazyForEach动态加载诗歌数据
          LazyForEach(this.PoemDataModel, (item: Poem) => {
            this.PoemItem(item); // 渲染单个诗歌项
          }, (item: Poem) => item.id.toString()) // 以numId为唯一标识
        }
        .margin({ top: 45 })
        .edgeEffect(EdgeEffect.Spring) // 滑动边缘效果
        .cachedCount(25) // 缓存项数
        .onReachEnd(() => { // 滑动到底部时触发
          this.fetchData()
          LogUtil.debug('触底刷新成功')
        })

        .onAppear(() => {
          this.fetchData()

          LogUtil.debug('onAppear刷新成功')
        })

        .onScrollIndex((firstIndex: number, lastIndex: number, centerIndex: number) => {
          console.info('first' + firstIndex)
          console.info('last' + lastIndex)
          console.info('center' + centerIndex)
        })

      }
      .width('100%')

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

  aboutToDisappear(): void {
    // 退出页面时取消对经验值的添加
    clearTimeout(addEXPId)
  }
}



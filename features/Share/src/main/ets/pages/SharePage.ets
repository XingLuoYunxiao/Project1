import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "routermodule";
import Constants from "../common/constants/Constants";
import { ListConstants } from "../common/constants/ListConstants";
import { OneMoment } from "../components/OneMoment";
import { CommentData, friendMoment} from "../model/BasicDataSource";
import { FriendMomentAdd } from "../model/FriendMomentAdd";
import { ShareViewModel } from "../service/ShareViewModel";

const typeVideo: string = 'video';
const typeText: string = 'text';
const typeImage: string = 'image';

@Component
export struct SharePage {
  @Consume('appPathStack') appPathStack: NavPathStack
  @Consume('loginPathStack') loginPathStack: NavPathStack
  listScroller: ListScroller = new ListScroller(); // scroller控制器
  @State shareViewModel:ShareViewModel=ShareViewModel.getInstance();
  @Provide commentList: CommentData<FriendMomentAdd> = this.shareViewModel.shareList
  private cachedCountNumber: number = 5; // 懒加载缓存数
  @State dialogType: string = typeText; // 弹窗类型
  @StorageProp ('personPhoto') personPhoto: string = ''
  private scroller: ListScroller = new ListScroller();
  @State refreshing: boolean = false;//此时的刷新状态
  @State refreshOffset: number = 0;
  @State refreshState: RefreshStatus = RefreshStatus.Inactive;
  @State canLoad: boolean = false;//控制防止在到底加载新数据时重复触发加载操作
  @State isLoading: boolean = false;//是否正在加载
  @State non:number=this.shareViewModel.none


  aboutToAppear(): void {
    this.shareViewModel.reset()
    this.shareViewModel.shareDeal()
    // 加载初始数据
  }

  getCurrentDate(): string {
    const date: Date = new Date();
    return `${date.getFullYear()}-${date.getMonth()}-${date.getDay()} ${date.getHours()}:${date.getMinutes()}:${date.getSeconds()}`;
  }

  @Builder
  refreshBuilder() {
    Stack({ alignContent: Alignment.Bottom }) {
      // 可以通过刷新状态控制是否存在Progress组件
      // 默认未下拉状态和刷新结束,当刷新状态处于下拉中或刷新中状态时Progress组件才存在
      if (this.refreshState != RefreshStatus.Inactive && this.refreshState != RefreshStatus.Done) {
        //当前进度值
        Progress({ value: this.refreshOffset, total: 64, type: ProgressType.Ring })
          .width(32).height(32)
          .style({ status: this.refreshing ? ProgressStatus.LOADING : ProgressStatus.PROGRESSING })
          .margin(10)
      }
    }
    .clip(true)
    .height("100%")
    .width("100%")
  }

  @Builder
  footer() {
    Row() {
      LoadingProgress().height(32).width(48)
      // Text("加载中").fontColor(Color.Black)
    }.width("100%")
    .height(30)
    .justifyContent(FlexAlign.Center)
    // 当不处于加载中状态时隐藏组件
    .visibility(this.isLoading==false? Visibility.Visible : Visibility.Hidden)
  }

  @Builder
  none(){
    Text('ʅ（´◔౪◔）ʃ 到底了哦').width('100%').height(30)
      .textAlign(TextAlign.Center)
      .visibility(this.non==1&&this.commentList.totalCount()!=0?Visibility.Visible:Visibility.Hidden)
  }

  build() {
      Navigation(this.loginPathStack){
        Row(){
          Image($r('app.media.share'))
            .width(35)
            .height(35)
            .margin({left:12,right:12})
          Text('古韵天地').fontSize(20).layoutWeight(1).textAlign(TextAlign.Center)
          Image($r('app.media.addmoment'))
            .width(35)
            .height(35)
            .onClick(()=>{
              buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.SHARE_PUBLISHPAGE)
            })
        }
        .width('100%')
        .height(50)
        //组件当前是否处于刷新中状态
        //自定义刷新区域显示内容。
        Refresh({ refreshing: $$this.refreshing, builder: this.refreshBuilder()}){
          List({ space: ListConstants.LIST_SPACE, scroller: this.listScroller }) {
            // TODO：高性能知识点：列表数据较多，不需要全部渲染上屏，采用LazyForEach。
            LazyForEach(this.commentList, (moment: FriendMomentAdd) => {
              ListItem() {
                OneMoment({ moment: moment});
              }
            }, (moment: FriendMomentAdd) => `${moment.id}`)
            ListItem(){
              this.none()
            }
            ListItem(){
              this.footer()
            }
          }
          .edgeEffect(EdgeEffect.None)
          .onReachEnd(()=>{
            if(this.commentList.totalCount()){
              this.isLoading=true
              this.non=this.shareViewModel.none
              this.shareViewModel.shareDeal().then(()=>{
                if(this.non==1){
                  this.isLoading=true
                }
              })
            }
          })
          // TODO：高性能知识点：为保证滑动流畅，采用cachedCount缓存前后节点。
          .scrollBar(BarState.Off)
          .cachedCount(this.cachedCountNumber)
          .width($r('app.string.publish_multimedia_updates_layout_100'))
          .height($r('app.string.publish_multimedia_updates_layout_94'))
          .listDirection(Axis.Vertical)

          .scrollBar(BarState.Off)
        }
        //当前刷新状态变更时，触发回调
        .onStateChange((state: RefreshStatus) => {
          this.refreshState = state;
        })
        //进入刷新状态时触发回调。
        .onRefreshing(() => {
          // 数据刷新
          setTimeout(() => {
            this.refreshing = false;
          }, 2000)
          this.shareViewModel.reset()
          this.shareViewModel.shareDeal()
        })
        .padding({
          top: $r('app.integer.publish_multimedia_updates_toolbar_padding_top'),
          bottom: $r('app.integer.publish_multimedia_updates_toolbar_padding_bottom')
        })
        .width($r('app.string.publish_multimedia_updates_layout_100'))
      }
      .padding({left:Constants.PADDING_PAGE,right:Constants.PADDING_PAGE})
      .hideTitleBar(true)
  }
}

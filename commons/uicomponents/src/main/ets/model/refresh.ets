@Component
export struct IPullRefreshWidget {
  @Prop refreshing: boolean = false;
  @State refreshOffset: number = 0;
  @State refreshState: RefreshStatus = RefreshStatus.Inactive;
  @State canLoad: boolean = false;
  @State isLoading: boolean = false;
  @BuilderParam builder: () => void;
  @Prop length: number = 0;
  @Prop isAllLoading: boolean;
  onLoading: () => void = () => {
  }
  onRefresh: () => void = () => {
  }

  @Builder
  refreshBuilder() {
    Stack({ alignContent: Alignment.Bottom }) {
      // 可以通过刷新状态控制是否存在Progress组件
      // 当刷新状态处于下拉中或刷新中状态时Progress组件才存在
      if (this.refreshState != RefreshStatus.Inactive && this.refreshState != RefreshStatus.Done) {
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
      Text("加载中")
    }.width("100%")
    .height(64)
    .justifyContent(FlexAlign.Center)
    // 当不处于加载中状态时隐藏组件
    .visibility(this.isLoading ? Visibility.Visible : Visibility.Hidden)
  }

  @Builder
  allFooter() {
    Row() {
      Text("已加载全部数据")
    }.width("100%")
    .height(64)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Refresh({ refreshing: $$this.refreshing, builder: this.refreshBuilder() }) {
      List() {
        this.builder()
        ListItem() {
          if (this.isAllLoading) {
            this.allFooter()
          } else {
            this.footer();
          }

        }
      }
      .onScrollIndex((start: number, end: number) => {
        // 当达到列表末尾时，触发新数据加载
        if (this.canLoad && end >= this.length - 1) {
          this.canLoad = false;
          this.isLoading = true;
          // 模拟新数据加载
          setTimeout(() => {
            this.onLoading()
            this.isLoading = false;
          }, 700)
        }
      })
      .onScrollFrameBegin((offset: number, state: ScrollState) => {
        // 只有当向上滑动时触发新数据加载
        if (offset > 5 && !this.isLoading) {
          this.canLoad = true;
        }

        // this.onRefresh()
        return { offsetRemain: offset };
      })
      .scrollBar(BarState.Off)
      // 开启边缘滑动效果
      .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true })
    }
    .width('100%')
    .height('100%')
    .onOffsetChange((offset: number) => {
      this.refreshOffset = offset;
    })
    .onStateChange((state: RefreshStatus) => {
      this.refreshState = state;
    })
    .onRefreshing(() => {
      // 模拟数据刷新
      this.onRefresh()
    })
  }
}
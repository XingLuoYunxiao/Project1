import { BreakpointConstants, BreakpointType, CommonConstants } from 'utils';
import { NearbySpotLoadingSkeleton } from './NearbySpotLoadingSkeleton';

const NEARBY_VISIBLE_LENGTH = 10


@Component
export struct TravelSkeletonView {
  nearbySpots: Array<Number> = new Array(NEARBY_VISIBLE_LENGTH).fill(1).map((v: number, index: number) => index + 1);
  @State columnOpacity: number = 1

  @StorageLink('currentHeightBreakpoint') currentHeightBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('currentWidthBreakpoint') currentWidthBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;

  startAnimation(): void{
    animateTo(CommonConstants.SKELETON_ANIMATION, () => {
      this.columnOpacity = 0.5
    })
  }

  build() {
    Column() {
      Row() {
        Row() {
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .backgroundColor($r('app.color.skeleton_color'))
        .height(20)
        .width('20%')
        .padding(5)

        Blank()

        Row() {
        }
        .width('15%')
        .height(20)
        .backgroundColor($r('app.color.skeleton_color'))
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')

      List() {
        ForEach(this.nearbySpots, (item:number) => {
          ListItem() {
            NearbySpotLoadingSkeleton()
          }
          .margin({ left: 5, right: 5 })
        })
      }
      .nestedScroll({
        scrollForward: NestedScrollMode.PARENT_FIRST,
        scrollBackward: NestedScrollMode.SELF_FIRST
      })
      .lanes(new BreakpointType({ sm: 1, md: 1, lg: 2 }).getValue(this.currentWidthBreakpoint))
      .scrollBar(BarState.Off)
      .width('100%')
      .layoutWeight(1)
      .listDirection(Axis.Vertical)
    }
    .opacity(this.columnOpacity)
    .onAppear(() => {
      this.startAnimation()
    })
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}
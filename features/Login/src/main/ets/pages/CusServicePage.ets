import { BuilderNameConstants, RouterModule } from "routermodule"
import { SpanType } from "../common/constants/chatConstant";
import Constants from "../common/constants/Constants"
import { MessageBase, SpanItem} from '../model/Message'; // 聊天内容数据
import { ListDataSource } from "../service/ListDataSource";
import { display, window ,KeyboardAvoidMode} from "@kit.ArkUI";
import { common } from "@kit.AbilityKit";

const question:string[]=['请问如何退款','如何预约','优惠券在哪领取']

const DESIGN_WIDTH: number = 640; // 设计宽度
const LAYOUT_WEIGHT: number = 1; // layoutWeight参数

// 定义聊天界面布局信息
const HEAD_IMAGE_EDGE_PADDING: number = 5; // 头像到左右两边的padding
const HEAD_IMAGE_MSG_PADDING: number = 10; // 头像到聊天信息paddding
const MSG_TOP_RIGHT_PADDING: number = 10; // 聊天信息上下paddding
const MSG_LEFT_RIGHT_PADDING: number = 15; // 聊天信息左右paddding
const MSG_HEADIMG_SIZE: number = 50; // 用户头像尺寸


const DELAY_TIME: number = 200; // 延时时间
@Component
//客服
export struct CusServicePage {
  @StorageLink('keyboardHeight') keyboardHeight: number = 0;
  @State curtalk:string=''
  private scroller: Scroller = new Scroller();
  @State QuesItemList:string=''
  // 发送的信息条数
  @State msgNums: number = 0;
  // 组件的控制器
  controllerRich: RichEditorController = new RichEditorController();
  private start: number = -1;
  private end: number = -1;
  private focusKey = 'msg_input'; // 输入框焦点
  // 聊天信息参数
  private screenWidth: number = 0; // 屏幕宽度
  private msgFontSize: number = 0; // 字体
  private msgMaxWidth: number = 0; // 聊天信息最大宽度
  @Consume('appPathStack') appPathStack: NavPathStack
  @State isFaceDlgOpen: boolean = false; // 表情对话框打开状态
  private isFaceClick = false; // 表情按钮是否点击
  // 聊天信息数据
  @State textDetailData:ListDataSource<MessageBase> = new ListDataSource();
  wordLibrary: Set<string> = new Set(['退款', '预约', '优惠券']);
  answers:Set<string> = new Set(['好的,已帮您退款', '预约', '优惠券在首页右上角']);
  checkSentence(sentence: string): string {
    const processedSentence = sentence.replace(/[\p{P}\p{S}]/gu, '');
    for (const word of this.wordLibrary) {
      if (processedSentence.includes(word)) {
        for (const answer of this.answers) {
          if(answer.includes(word)){
            return answer;
          }
        }
      }
    }
    return '为了匹配更合适的客服解决您的问题,请选择您要咨询的业务哦~';
  }

  /**
   * 发送聊天消息
   */
  async sendChatMsg(message?:string): Promise<void> {
    //新建消息
    let msgBase = new MessageBase(true, '', this.msgMaxWidth);
    let otherBase= new MessageBase(false, '', this.msgMaxWidth);
    // 拿取发送信息
    if(message==undefined){
      this.controllerRich.getSpans({
        start: this.start,
        end: this.end
      }).forEach(item => {
        //处理文字span信息
        const textMsg: string = (item as RichEditorTextSpanResult).value;
        const othertextMsg=this.checkSentence(textMsg)
        const spanItem: SpanItem = new SpanItem(SpanType.TEXT, textMsg, '');
        const otherspanItem: SpanItem = new SpanItem(SpanType.TEXT, othertextMsg, '');
        msgBase.spanItems.push(spanItem)
        otherBase.spanItems.push(otherspanItem)
        // }
      })
    }else{
      const othertextMsg=this.checkSentence(message)
      const spanItem: SpanItem = new SpanItem(SpanType.TEXT, message, '');
      const otherspanItem: SpanItem = new SpanItem(SpanType.TEXT, othertextMsg, '');
      msgBase.spanItems.push(spanItem)
      otherBase.spanItems.push(otherspanItem)
    }
    // 发送
    if (msgBase.spanItems.length !== 0) {
      this.textDetailData.pushData(msgBase);
      this.msgNums = this.textDetailData.totalCount();
      this.controllerRich.deleteSpans();
      this.controllerRich.setCaretOffset(-1);
    }
    if (otherBase.spanItems.length !== 0) {
      this.textDetailData.pushData(otherBase);
      this.msgNums = this.textDetailData.totalCount();
      this.controllerRich.deleteSpans();
      this.controllerRich.setCaretOffset(-1);
    }
    this.scroller.scrollEdge(Edge.Bottom);
  }

  /**
   * 将聊天信息中的文字、表情分别解析为span、imageSpan
   * @param strMessage 聊天内容, msgBase 聊天消息结构
   */
  dealImageResMsg(msgBase: MessageBase, strMessage: string): void {
    const spanItem: SpanItem = new SpanItem(SpanType.TEXT, strMessage, '');
    msgBase.spanItems.push(spanItem);
  }

  aboutToAppear(){
      const displayData: display.Display = display.getDefaultDisplaySync();
      this.screenWidth = px2vp(displayData.width);

      // 根据设计稿及屏幕宽度计算fontsize及行间距
      this.msgFontSize = this.screenWidth * 100 / DESIGN_WIDTH; // 100,百分比
      // 聊天信息最大宽度
      this.msgMaxWidth =
        (this.screenWidth - HEAD_IMAGE_EDGE_PADDING * 2 - HEAD_IMAGE_MSG_PADDING * 2 - MSG_HEADIMG_SIZE * 2) *
          0.95; // 2、0.95 聊天内容最大长度设为两个聊天对象之间宽度的95%

      //预加载聊天信息
      //获取指定资源ID对应的字符串
      const chatMsg1: string = getContext(this)
        .resourceManager
        .getStringSync($r('app.string.chat_with_expression_msg_1'));
      let msgBase1 = new MessageBase(false,'', this.msgMaxWidth);
      this.dealImageResMsg(msgBase1, chatMsg1);
      this.textDetailData.pushData(msgBase1);
      //
      const chatMsg2: string = getContext(this)
        .resourceManager
        .getStringSync($r('app.string.chat_with_expression_msg_2'));
      let msgBase2 = new MessageBase(false, '', this.msgMaxWidth);
      this.dealImageResMsg(msgBase2, chatMsg2);
      this.textDetailData.pushData(msgBase2);

      let context = getContext(this) as common.UIAbilityContext;
      context.windowStage.getMainWindowSync().getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE);
      window.getLastWindow(getContext(this)).then(currentWindow => {
        // 监视软键盘的弹出和收起
        currentWindow.on('avoidAreaChange', async data => {
          if (data.type !== window.AvoidAreaType.TYPE_KEYBOARD) {
            return;
          }
          const bottomAvoidArea = currentWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
            .bottomRect
            .height;
          currentWindow.on('keyboardHeightChange', (data) => {
            if (data > 0) {
              AppStorage.setOrCreate('keyboardHeight', data - bottomAvoidArea);
            } else {
              AppStorage.setOrCreate('keyboardHeight', 0);
            }
          })
          // TODO 知识点：点击表情按钮之后，等待系统软键盘关闭后再延迟刷新表情键盘，避免屏幕闪烁
          if (data.area.bottomRect.height === 0 && this.isFaceClick === true) {
            // 200毫秒之后执行
            setTimeout(async () => {
              this.isFaceDlgOpen = true;
            }, DELAY_TIME)
          }
        })
      })
    }

  aboutToDisappear(): void {
    this.isFaceDlgOpen = false;
    this.isFaceClick = false;
  }


  build() {
  NavDestination(){
    Column(){
      Row(){
        Image($r('app.media.ic_back')).width($r('app.float.md_topic_width')).onClick(()=>{
          this.appPathStack.pop()
        })
        Image($r('app.media.defaultphoto')).width(45).margin({left:5,right:5})
        Column(){
          Text('古韵游踪客服')
            .fontSize(16)
            .fontWeight(700)
          Text('提供专业服务')
            .fontSize(12)
        }
      }
      .width('100%')
      .backgroundColor($r('app.color.skeleton_color_light'))
      .height(Constants.TOP_HEIGHT_PAGE)
      .justifyContent(FlexAlign.Start)

      List({
        scroller: this.scroller,
        initialIndex: this.msgNums - 1
      }){
        LazyForEach(this.textDetailData, (msg: MessageBase) => {
          ListItem() {
            if (msg.isSelf) {
              MessageItemSelfView({ msg: msg });
            } else {
              MessageItemView({ msg: msg });
            }
          }
        },(mes:MessageBase,index:number)=>JSON.stringify(mes)+Math.random()+index)
      }
      .scrollBar(BarState.Off)
      .onAreaChange(() => {
        // 控制列表滚动条到底部,组件区域变化时触发该回调
        this.scroller.scrollEdge(Edge.Bottom);
      })
      .alignSelf(ItemAlign.End)
      .align(Alignment.End)
      .listDirection(Axis.Vertical)
      .padding($r('app.float.md_padding_margin'))
      .width('100%')
      .height('80%')
      .layoutWeight(LAYOUT_WEIGHT)

      Column(){
        Row(){
          List(){
            ForEach(question,(item:string)=>{
              ListItem(){
                Button(item)
                  .height(30)
                  .backgroundColor(Color.White)
                  .margin({left:5,right:5})
                  .fontColor(Color.Black)
                  .onClick(()=>{
                    this.sendChatMsg(item)
                  })
              }
            })
          }
          .listDirection(Axis.Horizontal)
          .scrollBar(BarState.Off)
        }
        .width('100%')
        .height(40)

        // 底部输入框
        Row() {
          // 输入框
          RichEditor({ controller: this.controllerRich })
            .height(40)
            .layoutWeight(LAYOUT_WEIGHT)
            .borderRadius(8)
            .backgroundColor(Color.White)
            .onClick(async () => {
              this.isFaceDlgOpen = false;
              this.isFaceClick = false;
            })
          Button('发送')
            .fontColor(Color.White)
            .margin({left:10})
            .backgroundColor($r('app.color.link_blue'))
            .onClick(async () => {
              this.sendChatMsg();
            })
        }
        .margin({bottom:40})
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .height(40)
      }.backgroundColor($r('app.color.skeleton_color_light'))

      // TODO 知识点：通过变量控制表情键盘的显示
    }
    .padding({left:Constants.PADDING_PAGE,right:Constants.PADDING_PAGE,top:Constants.PADDING_PAGE})
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.app_background_color'))
  }
  .margin({top:Constants.HEADER_HEIGHT_PAGE})
  .hideTitleBar(true)
  }
}

@Component
@Reusable
export struct MessageItemSelfView {
  @State msg: MessageBase = new MessageBase(true, '', 0);

  aboutToReuse(params: Record<string, MessageBase>) {
    this.msg = params.msg;
  }

  build() {
    Row() {
      // 聊天信息
      Row() {
        Text('') {
          ForEach(this.msg.spanItems, (item: SpanItem) => {
              Span(item.text)
          })
        }.constraintSize({
          minHeight: 26,
          maxWidth: this.msg.maxWidth
        })
        .textAlign(TextAlign.Start)
      }
      //设置约束尺寸，组件布局时，进行尺寸范围限制
      .constraintSize({
        minHeight:26,
        minWidth:26,
        maxWidth: this.msg.maxWidth
      })
      .borderRadius(8)
      .padding({ top:MSG_TOP_RIGHT_PADDING,bottom:MSG_TOP_RIGHT_PADDING,left:MSG_LEFT_RIGHT_PADDING,right:MSG_LEFT_RIGHT_PADDING })
      .backgroundColor($r('app.color.dialog_background_yellow'))

    }
    .width('100%')
    .margin({
      top:20,
    })
    .justifyContent(FlexAlign.End)
  }
}

@Component
@Reusable
  // 对方单条聊天信息
export struct MessageItemView {
  @State msg: MessageBase = new MessageBase(false, '', 0);
  aboutToReuse(params: Record<string, MessageBase>) {
    this.msg = params.msg;
  }

  build() {
      // 聊天信息
      Row() {
        Row() {
          Text('') {
            ForEach(this.msg.spanItems, (item: SpanItem) => {
              Span(item.text)
            })
          }.constraintSize({
            minHeight: 26,
            maxWidth: this.msg.maxWidth
          })
          .textAlign(TextAlign.Start)
        }
        .constraintSize({
          minHeight: 26,
          minWidth: 26,
          maxWidth: this.msg.maxWidth
        })
        .borderRadius(8)
        .backgroundColor($r('app.color.dialog_background_blue'))
        .padding({ top:MSG_TOP_RIGHT_PADDING,bottom:MSG_TOP_RIGHT_PADDING,left:MSG_LEFT_RIGHT_PADDING,right:MSG_LEFT_RIGHT_PADDING })
      }
      .width('100%')
      .margin({
      top: 20,
    })
    .justifyContent(FlexAlign.Start)
  }
}
@Builder
export function CusServicePageBuilder() {
  CusServicePage()
}

const builderName = BuilderNameConstants.LOGIN_CUSSERVICEPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(CusServicePageBuilder);
  RouterModule.registerBuilder(builderName, builder);
}

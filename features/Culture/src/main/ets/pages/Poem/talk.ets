import { hilog } from '@kit.PerformanceAnalysisKit';
import { TextReader, TextReaderIcon, ReadStateCode } from '@kit.SpeechKit';
import { Poem } from '../../model/Poem';
import { ImageUtil } from 'utils/src/main/ets/puraUtils/ImageUtil'

const TAG = 'AI_SPEECH_KIT_DEMO'


@Component
export struct talk {
  @Prop poem: Poem
  @State message: string = '';
  /**
   * 待加载的文章
   */
  @State readInfoList: TextReader.ReadInfo[] = [];
  @State selectedReadInfo: TextReader.ReadInfo = this.readInfoList[0];
  /**
   * 播放状态
   */
  @State readState: ReadStateCode = ReadStateCode.WAITING;
  /**
   * 用于显示当前页的按钮状态
   */
  @State isInit: boolean = false;
  @State isListening: boolean = false;

  async aboutToAppear() {
    /**
     * 加载数据
     */

    console.info('ReadStateCode', JSON.stringify(this.readState))

    let readInfoList: TextReader.ReadInfo[] = [{
      id: '001',
      title: {
        text: this.poem.title as string,
        isClickable: true
      },
      author: {
        text: this.poem.writer,
        isClickable: true
      },

      image: await ImageUtil.getPixelMapFromMedia($r('app.media.painting_mudan')),
      bodyInfo: this.poem.content
    }];


    this.readInfoList = readInfoList;
    this.selectedReadInfo = readInfoList[0];
    this.init();
  }

  /**
   * 初始化
   */
  async init() {
    const readerParam: TextReader.ReaderParam = {
      isVoiceBrandVisible: false,
      keepBackgroundRunning: false,
      businessBrandInfo: {
        panelName: '诗歌朗诵',
        panelIcon: $r('app.media.ic_random')
      }
    }

    try {
      await TextReader.init(getContext(this), readerParam);
      this.isInit = true;
    } catch (err) {
      hilog.error(0x0001, TAG, 'init error: %{public}s', JSON.stringify(err))
    }
  }

  // 设置操作监听
  setActionListener() {
    TextReader.on('setArticle', (id: string) => {
    });
    TextReader.on('clickArticle', (id: string) => {
    });
    TextReader.on('clickAuthor', (id: string) => {
    });
    TextReader.on('clickNotification', (id: string) => {
      hilog.info(0x0001, TAG, `onClickNotification ${id}`)
    });
    TextReader.on('showPanel', () => {
      hilog.info(0x0001, TAG, `onShowPanel`)
    });
    TextReader.on('hidePanel', () => {
      hilog.info(0x0001, TAG, `onHidePanel`)
    });
    TextReader.on('stop', () => {
      hilog.info(0x0001, TAG, `onStop`)
    });
    TextReader.on('release', () => {
      hilog.info(0x0001, TAG, `onRelease`)
    });
    TextReader.on('stateChange', (state: TextReader.ReadState) => {
      hilog.info(0x1, TAG, `ReadState: %{public}s`, JSON.stringify(state));
      this.onStateChanged(state)
    });
    TextReader.on('requestMore', () => this.onStateChanged);
  }

  onStateChanged = (state: TextReader.ReadState) => {
    hilog.info(0x1, TAG, `selectedReadInfo.id: %{public}s`, this.selectedReadInfo?.id);
    if (this.selectedReadInfo?.id === state.id) {
     // hilog.warn(0x1, TAG, `match, changeState to %{public}s`, JSON.stringify(state))
      this.readState = state.state;
    } else {
      this.readState = ReadStateCode.WAITING;
    }
  }

  // 设置事件监听
  setEventListener() {
    TextReader.on('eventNotification', (event: TextReader.NotificationEvent) => {
      // hilog.info(0x0001, TAG, `Notification event: ${JSON.stringify(event)}`)
    })
    TextReader.on('eventPanel', (event: TextReader.PanelEvent) => {
      // hilog.info(0x0001, TAG, `Panel event: ${JSON.stringify(event)}`)
    })
    TextReader.on('eventReadList', (event: Array<TextReader.ListEventState>) => {
      // hilog.info(0x0001, TAG, `ReadList event: ${JSON.stringify(event)}`)
      TextReader.loadMore([], true);
    })
  }

  build() {
    Column() {
      TextReaderIcon({ readState: this.readState })
        .width(32)
        .height(32)
        .onClick(async () => {
          // 已经在播放，拉起播放面板
          if (this.readState === ReadStateCode.PLAYING) {

            return;
          }


          // 若未初始化，先初始化并启动
          try {
            this.setActionListener();
            this.setEventListener();
            await TextReader.start(this.readInfoList, this.selectedReadInfo?.id);
          } catch (err) {
            hilog.error(0x0001, TAG, 'init message: %{public}s', JSON.stringify(err))
          }
        })

      Text(this.readState === ReadStateCode.PLAYING ? '朗诵中' : '朗诵').fontSize(10)
    }
    .width(70)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

import { TextReader } from '@kit.SpeechKit';

// 单例类，用于管理TextReader相关操作
export class TextReaderManager {
  private static instance: TextReaderManager =  new TextReaderManager();

  //用于记录状态
  isPlaying: boolean = false;
  readInfoList: TextReader.ReadInfo[] = [];
  selectedArticleId: string = '';
  isInitialized: boolean = false;

  // TextReader初始化参数
  private readerParams: TextReader.ReaderParam = {
    isVoiceBrandVisible: false,
    businessBrandInfo: {
      panelName: '智能朗读',
      panelIcon: ''
    }
  };

  // 私有构造函数，遵循单例模式
  private constructor() {}

  // 获取单例实例的静态方法
  public static getInstance(): TextReaderManager {
    if (!TextReaderManager.instance) {
      TextReaderManager.instance = new TextReaderManager();
    }
    return TextReaderManager.instance;
  }

  // 初始化TextReader
  async init(): Promise<void> {
    try {
      await TextReader.init(getContext(this), this.readerParams);
      console.info('TextReader 初始化成功');
      this.isInitialized = true;
    } catch (error) {
      console.error(`TextReader 初始化失败，错误码：${error.code}, 错误信息：${error.message}`);
    }
  }

  // 开始朗读
  async start(): Promise<void> {
    if (!this.isInitialized) {
      console.error('TextReader 尚未初始化');
      return;
    }

    try {
      await TextReader.start(this.readInfoList, this.selectedArticleId);
      console.info('TextReader 启动成功');
      this.isPlaying = true;
    } catch (error) {
      console.error(`TextReader 启动失败，错误码：${error.code}, 错误信息：${error.message}`);
    }
  }

  // 暂停朗读
  async pause(): Promise<void> {
    if (!this.isInitialized) {
      console.error('TextReader 尚未初始化');
      return;
    }

    try {
      await TextReader.pause();
      console.info('TextReader 成功暂停朗读');
      this.isPlaying = false;
    } catch (error) {
      console.error(`TextReader 暂停失败，错误码：${error.code}, 错误信息：${error.message}`);
    }
  }

  // 停止朗读
  async stop(): Promise<void> {
    if (!this.isInitialized) {
      console.error('TextReader 尚未初始化');
      return;
    }

    try {
      await TextReader.stop();
      console.info('TextReader 成功停止朗读');
      this.isPlaying = false;
    } catch (error) {
      console.error(`TextReader 停止失败，错误码：${error.code}, 错误信息：${error.message}`);
    }
  }

  // 恢复朗读
  async resume(): Promise<void> {
    if (!this.isInitialized) {
      console.error('TextReader 尚未初始化');
      return;
    }

    try {
      await TextReader.resume();
      console.info('TextReader 成功恢复朗读');
      this.isPlaying = true;
    } catch (error) {
      console.error(`TextReader 恢复朗读失败，错误码：${error.code}, 错误信息：${error.message}`);
    }
  }

  // 释放资源
  async release(): Promise<void> {
    if (!this.isInitialized) {
      console.error('TextReader 尚未初始化');
      return;
    }

    try {
      await TextReader.release();
      console.info('TextReader 资源释放成功');
    } catch (error) {
      console.error(`TextReader 资源释放失败，错误码：${error.code}, 错误信息：${error.message}`);
    }
  }

  // 加载更多文章
  loadMoreArticles(moreReadInfoList: TextReader.ReadInfo[]): void {
    if (!this.isInitialized) {
      console.error('TextReader 尚未初始化');
      return;
    }

    TextReader.loadMore(moreReadInfoList, true);
    console.info('成功加载更多内容');
    this.readInfoList = [...this.readInfoList,...moreReadInfoList];
  }

  // 设置事件监听
  setEventListeners(): void {
    // 监听点击标题事件
    TextReader.on('clickArticle', (id: string) => {
      console.info(`用户点击了文章标题，文章 ID：${id}`);
    });

    // 监听朗读状态变更事件
    TextReader.on('stateChange', (state: TextReader.ReadState) => {
      console.info(`文章 ID：${state.id}, 当前朗读状态：${state.state}`);
    });

    // 监听加载更多事件
    TextReader.on('requestMore', () => {
      console.info('用户请求加载更多内容');
      this.loadMoreArticles([]); // 按需传入合适的更多文章数据，暂时传空数组
    });
  }
}
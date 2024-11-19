/**
 * 成语类，包含成语的基本信息和相关详细数据
 */
export class realIdiom {
  id: number = 0; // 成语的唯一标识符
  word: string = ''; // 成语文字
  abbr: string = ''; // 成语缩写
  data: IdiomData = new IdiomData(); // 相关的详细数据对象，使用 IdiomData 初始化

  constructor() {
    // 默认构造函数，可以根据需要扩展
  }
}

/**
 * 详细成语数据类，包含成语的解释、来源、示例等信息
 */
@Observed
export class IdiomData {
  pinyin: string = ''; // 成语拼音
  explanation: string = ''; // 成语的解释
  sourceText: string = ''; // 成语的出处文本
  sourceBook: string = ''; // 成语出处的书籍
  exampleText: string = ''; // 成语使用的例句
  exampleBook: string = ''; // 例句出处的书籍
  quoteBook: string = ''; // 引用出处的书籍
  quoteText: string = ''; // 引用文本
  similar: string = ''; // 与该成语相似的成语
  opposite: string = ''; // 与该成语相反的成语
  usage: string = ''; // 成语的用法说明
  story: string = ''; // 成语的故事背景
  notice: string = ''; // 使用成语时需要注意的事项
}

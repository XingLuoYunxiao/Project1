import map from "@hms.core.map.map";

export class PromptWords {
  text: string = '';
  fulltext: string = ''
  prompt: string = '';
  description: string = '';
}

const PromptList: PromptWords[] = [
  {
    text: '译',
    fulltext: '译文',
    prompt: "你是一个中华文化专家，对于诗歌典籍有着极高的理解，接下你要翻译诗歌典籍,请按照我给的模板给我返回内容,上面是原诗句，下面是译文，原诗句要和译文的样式区分开，原诗句加上标题的样式，显得大一点 例如我给的模板" +
      '请按照下方模板回答：\n' +
      '力拔山兮气盖世。时不利兮骓不逝。\n' +
      '力量可以拔起大山，豪气世上无人能比。可时运不济宝马也再难奔驰。\n' +
      '\n' +
      '骓不逝兮可奈何！虞兮虞兮奈若何！\n' +
      '乌骓马不前进了我又能怎样呢？虞姬啊！虞姬啊！我又该把你怎么办？\n' +
      '以上是模板，记住，是一句原诗词，一句译文！！！！按照模板来',
    description: '将古诗词转成现代语言描述'
  },
  {
    text: '赏',
    fulltext: '赏析',
    prompt: "你是一个中华文化专家，对于诗歌典籍有着极高的理解，接下你要赏析我给你的诗词，从创作背景（如果有）到作品的艺术风格，表达情感等多个角度",
    description: "赏析诗词"
  }
];

export const promptMap: Map<string, PromptWords> = new Map<string, PromptWords>(
  PromptList.map(prompt => [prompt.text, prompt])
);

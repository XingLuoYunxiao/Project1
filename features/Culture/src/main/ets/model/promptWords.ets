export class PromptWords {
  text: string = ''
  fulltext: string = ''
  prompt: string = ''
  description: string = ''
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
  },
  {
    text: '意',
    fulltext: '意境解析',
    prompt: "你是一个诗词鉴赏专家，请帮助我分析这首诗歌的意境和情感表达，结合诗词的语言和表现手法，解释诗人所要表达的思想和情感。",
    description: '分析诗歌的意境与情感表达'
  },
  {
    text: '写',
    fulltext: '写作风格分析',
    prompt: "你是一个诗词专家，请分析这首诗歌的写作风格，包括但不限于修辞手法、语言风格、节奏韵律等方面的特点，并解释这些特点是如何帮助表达诗人的主题和情感的。",
    description: '分析诗歌的写作风格及其表达'
  }
]

const AIImagePromptList: PromptWords[] = [
  {
    "text": "写意画",
    "fulltext": "写意画",
    "prompt": "运用简练的笔墨表达事物的精神实质，不追求具体的形状，强调画家个人情感和意境的表现。",
    "description": "这是画写意画的提示词"
  },
  {
    "text": "工笔画",
    "fulltext": "工笔画",
    "prompt": "运用精细的笔触和鲜艳色彩，注重细节刻画，追求形似和神似的统一。",
    "description": "这是画工笔画的提示词"
  },
  {
    "text": "水墨画",
    "fulltext": "水墨画",
    "prompt": "运用淡墨和浓墨对比，展现山水层次与意境，强调墨色变化和水分运用。",
    "description": "这是画水墨画的提示词"
  },
  {
    "text": "青绿山水",
    "fulltext": "青绿山水",
    "prompt": "运用石青、石绿颜料绘制，突出装饰性和华丽感，表现壮丽自然景观。",
    "description": "这是画青绿山水的提示词"
  },
  {
    "text": "白描画",
    "fulltext": "白描画",
    "prompt": "运用流畅的墨线勾勒物象轮廓，展现物体的形态和质感。",
    "description": "这是画白描的提示词"
  },
  {
    "text": "没骨画",
    "fulltext": "没骨画",
    "prompt": "运用直接彩色渲染的方法，创造出色彩柔和且画面朦胧美的效果。",
    "description": "这是画没骨画的提示词"
  },

  {
    "text": "文人画",
    "fulltext": "文人画",
    "prompt": "运用融合诗歌、书法和绘画的艺术形式，展现文化内涵和个人修养。",
    "description": "这是画文人画的提示词"
  }
];

export const promptMap: Map<string, PromptWords> = new Map<string, PromptWords>(
  PromptList.map(prompt => [prompt.text, prompt])
)

export const AIPaintingPromptMap: Map<string, PromptWords> = new Map<string, PromptWords>(
  AIImagePromptList.map(prompt => [prompt.text, prompt])
)

import { ArtModel } from './ArtModel';

export class calligraphyItem implements ArtModel {
  name: string = ''; // 字体名称
  type: string = ''; // 类型
  introduction: string = ''; // 简介
  originPeriod: string = ''; // 起源时期
  famousCalligraphers: string[] = []; // 著名书法家
  characteristics: string = ''; // 字体特点
  commonUsage: string = ''; // 常见用途
  Images?: ResourceStr = ''
}

export const calligraphyItemList: calligraphyItem[] = [
  {
    name: '甲骨文',
    type: '书法',
    introduction: '甲骨文是中国已知最早的文字之一，主要用于商代占卜活动，刻写在龟甲和兽骨上，具有象形特点。',
    originPeriod: '商朝',
    famousCalligraphers: [],
    characteristics: '象形字形、线条粗犷、富有原始美感',
    commonUsage: '占卜记录、铭文',
    Images: $r('app.media.calligraphy_jiaguwen')
  },
  {
    name: '金文',
    type: '书法',
    introduction: '金文是中国早期的书体之一，主要用于青铜器铭文，笔画粗犷有力。',
    originPeriod: '商周时期',
    famousCalligraphers: [],
    characteristics: '笔画粗犷、造型独特',
    commonUsage: '青铜器铭文',
    Images: $r('app.media.calligraphy_jinwen')
  },
  {
    name: '篆书',
    type: '书法',
    introduction: '篆书是中国最古老的书体之一，字形严谨对称，线条优美，主要用于古代铭文和印章。',
    originPeriod: '商周时期',
    famousCalligraphers: ['李斯', '程邈'],
    characteristics: '字形对称、线条优美',
    commonUsage: '印章、铭文',
    Images: $r('app.media.calligraphy_zhuanshu')
  },

  {
    name: '隶书',
    type: '书法',
    introduction: '隶书是汉代广泛使用的书体，字形工整平稳，横画多呈波浪形，笔画分明。',
    originPeriod: '汉朝',
    famousCalligraphers: ['蔡邕', '张芝'],
    characteristics: '工整平稳、横画呈波浪形',
    commonUsage: '石碑、书法练习',
    Images: $r('app.media.calligraphy_lvshu')
  },
  {
    name: '草书',
    type: '书法',
    introduction: '草书是一种快速书写、潇洒灵动的书体，线条连贯，字形简化，具有较强的表现力。',
    originPeriod: '汉朝',
    famousCalligraphers: ['张芝', '王羲之', '张旭'],
    characteristics: '连贯迅速、结构简化',
    commonUsage: '诗文书写',
    Images: $r('app.media.calligraphy_chaoshu')
  },
  {
    name: '楷书',
    type: '书法',
    introduction: '楷书是汉代后期发展而成的标准字体，字形方正、笔画清晰，是书法学习的基础。',
    originPeriod: '汉朝末期',
    famousCalligraphers: ['钟繇', '颜真卿', '欧阳询'],
    characteristics: '字形方正、笔画清晰',
    commonUsage: '书法练习、正式文件',
    Images: $r('app.media.calligraphy_kaishu')
  },
  {
    name: '行书',
    type: '书法',
    introduction: '行书介于楷书与草书之间，书写流畅，结体灵活，适合日常书写。',
    originPeriod: '东汉',
    famousCalligraphers: ['王羲之', '颜真卿', '苏轼'],
    characteristics: '流畅自然、结体灵活',
    commonUsage: '书信、日常书写',
    Images: $r('app.media.calligraphy_xingshu')
  }
];

export const calligraphyMap: Map<string, calligraphyItem> = new Map<string, calligraphyItem>(
  calligraphyItemList.map(calligraphy => [calligraphy.name, calligraphy])
);

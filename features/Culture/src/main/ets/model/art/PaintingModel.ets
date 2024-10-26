import { ArtModel } from "./ArtModel";


export class PaintingModel implements ArtModel {
  name: string = ''; // 画种名称
  type: string = ''; // 画种类型
  introduction: string = ''; // 简介
  originPeriod: string = ''; // 起源时期
  famousArtists: string[] = []; // 著名画家
  characteristics: string = ''; // 特征
  commonUsage: string = ''; // 常见用途
  exampleImage: string = ''; // 示例图片的URL
  materialAndTechnique: string = ''; // 创作材料和技法
  subjectMatter: string = ''; // 题材内容
}

const paintingModelList: PaintingModel[] = [
  {
    name: '山水画',
    type: '绘画',
    introduction: '山水画以自然山川、河流为主要题材，强调人与自然的和谐关系。',
    originPeriod: '魏晋南北朝时期',
    famousArtists: ['王维', '范宽', '郭熙'],
    characteristics: '强调自然之美，使用水墨或淡彩，构图空灵、意境深远。',
    commonUsage: '常用于家庭装饰和展览，表现自然风光和文化情怀。',
    exampleImage: 'https://example.com/shanshui.jpg',
    materialAndTechnique: '水墨画、浅绛',
    subjectMatter: '主要表现山川、河流等自然景观。',
  },
  {
    name: '人物画',
    type: '绘画',
    introduction: '人物画是描绘人物形象及生活场景的画种，反映人物情感与社会生活。',
    originPeriod: '汉朝',
    famousArtists: ['顾恺之', '吴道子', '周昉'],
    characteristics: '注重人物的神态和服饰细节，线条流畅。',
    commonUsage: '用于历史记载、宗教场所装饰以及个人收藏。',
    exampleImage: 'https://example.com/renwu.jpg',
    materialAndTechnique: '工笔、写意',
    subjectMatter: '主要表现人物形象、日常生活场景。',
  },
  {
    name: '水墨画',
    type: '绘画',
    introduction: '水墨画是中国传统绘画的一种，以水墨为主要材料，强调墨色变化和意境的表现。',
    originPeriod: '唐代',
    famousArtists: ['张择端', '李公麟', '任伯年'],
    characteristics: '讲究水墨的渗透、浓淡变化，能表达丰富的情感和气氛。',
    commonUsage: '用于艺术欣赏和展览，适合书画爱好者。',
    exampleImage: 'https://example.com/shuimo.jpg',
    materialAndTechnique: '水墨画',
    subjectMatter: '包括山水画、花鸟画等多种题材。',
  },
  {
    name: '花鸟画',
    type: '绘画',
    introduction: '花鸟画主要描绘花卉、草木、飞禽等，表现自然界的美丽和生机。',
    originPeriod: '唐代',
    famousArtists: ['黄筌', '徐熙', '赵昌'],
    characteristics: '工笔细腻或写意奔放，色彩丰富，生动自然。',
    commonUsage: '常用于家庭装饰、艺术欣赏，表现生活的美好。',
    exampleImage: 'https://example.com/huaniao.jpg',
    materialAndTechnique: '重彩、工笔、写意',
    subjectMatter: '主要表现花卉、鸟类等自然生物。',
  },
  {
    name: '仕女画',
    type: '绘画',
    introduction: '仕女画以描绘古代仕女为题材，展示女性的美丽和优雅。',
    originPeriod: '唐代',
    famousArtists: ['周昉', '张萱'],
    characteristics: '人物线条优美、神态柔和，突出女性的柔美和优雅。',
    commonUsage: '用于艺术欣赏和装饰，传递古代文化的美感。',
    exampleImage: 'https://example.com/shinv.jpg',
    materialAndTechnique: '工笔',
    subjectMatter: '主要表现古代女性形象。',
  },
  {
    name: '宗教画',
    type: '绘画',
    introduction: '宗教画以佛教、道教为主题，表现宗教故事和神话人物。',
    originPeriod: '魏晋南北朝时期',
    famousArtists: ['吴道子', '张僧繇'],
    characteristics: '注重人物造型和神态，氛围神秘庄重。',
    commonUsage: '用于宗教场所、庙宇装饰，参与宗教仪式。',
    exampleImage: 'https://example.com/zongjiao.jpg',
    materialAndTechnique: '工笔、白描',
    subjectMatter: '主要表现宗教故事和神话人物。',
  },
  {
    name: '工笔画',
    type: '绘画',
    introduction: '工笔画以细致的线条和精细的描绘著称，通常用于表现人物、花鸟等，重视细节和写实。',
    originPeriod: '唐代',
    famousArtists: ['吴道子', '李公麟'],
    characteristics: '线条细腻、写实，强调细节和色彩的丰富性。',
    commonUsage: '用于装饰艺术、个人欣赏和收藏。',
    exampleImage: 'https://example.com/gongbi.jpg',
    materialAndTechnique: '工笔',
    subjectMatter: '人物画、花鸟画等。',
  },
  {
    name: '写意画',
    type: '绘画',
    introduction: '写意画强调表达意境和情感，常用简洁的笔触表现主题，注重画作的气韵。',
    originPeriod: '宋代',
    famousArtists: ['齐白石', '徐渭'],
    characteristics: '不拘小节，更多地传达画家的情感和思想。',
    commonUsage: '用于艺术欣赏、个性表达，展现个人风格。',
    exampleImage: 'https://example.com/xieyi.jpg',
    materialAndTechnique: '写意',
    subjectMatter: '常见于花鸟画和山水画。',
  },
  {
    name: '海派画',
    type: '绘画',
    introduction: '海派画兴起于清末民初，融合了西方绘画技巧，注重色彩和光影效果。',
    originPeriod: '清末民初',
    famousArtists: ['吴昌硕', '齐白石'],
    characteristics: '色彩鲜艳，表现手法灵活多变，能表现丰富的情感。',
    commonUsage: '适用于现代装饰、艺术欣赏，体现时代特色。',
    exampleImage: 'https://example.com/haipai.jpg',
    materialAndTechnique: '水墨、油画',
    subjectMatter: '常见于风景、花鸟等题材。',
  }

];

export const paintingMap: Map<string, PaintingModel> = new Map<string, PaintingModel>(
  paintingModelList.map(painting => [painting.name, painting])
)





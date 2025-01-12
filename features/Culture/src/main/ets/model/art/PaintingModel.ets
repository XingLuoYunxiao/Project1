import { ArtModel } from "./ArtModel";
import {
  paintingData,
  figureList,
  FlowerBirdsList,
  HaipaiPaintingList,
  InkPaintingList,
  shanshuiList,
  shinvList
} from "./DrawingModel";


export class PaintingModel implements ArtModel {
  name: string = ''; // 画种名称
  type: string = ''; // 画种类型
  introduction: string = ''; // 简介
  originPeriod: string = ''; // 起源时期
  famousArtists: string[] = []; // 著名画家
  characteristics: string = ''; // 特征
  commonUsage: string = ''; // 常见用途
  exampleImage: ResourceStr = ''; // 示例图片的URL

  materialAndTechnique: string = ''; // 创作材料和技法
  subjectMatter: string = ''; // 题材内容

  ImageArr?: paintingData[] = [];

  public static getInformation() {
    return
  }
}

export const paintingModelList: PaintingModel[] = [
  {
    name: '山水画',
    type: '绘画',
    introduction: '中国山水画是中国人情思中最为厚重的沉淀。游山玩水的大陆文化意识，' +
      '以山为德、水为性的内在修为意识，咫尺天涯的视错觉意识，一直成为山水画演绎的中轴主线。' +
      '从山水画中，我们可以集中体味中国画的意境、格调、气韵和色调。' +
      '再没有哪一个画科能像山水画那样给国人以更多的情感。若说与他人谈经辩道，山水画便是民族的底' +
      '蕴、古典的底气、国的图像、人的性情。',
    originPeriod: '魏晋南北朝时期',
    famousArtists: ['王维', '范宽', '郭熙'],
    characteristics: '强调自然之美，使用水墨或淡彩，构图空灵、意境深远。',
    commonUsage: '常用于家庭装饰和展览，表现自然风光和文化情怀。',
    exampleImage: 'https://example.com/shanshui.jpg',
    materialAndTechnique: '水墨画、浅绛',
    subjectMatter: '主要表现山川、河流等自然景观。',
    ImageArr: shanshuiList
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
    ImageArr: figureList
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
    ImageArr: FlowerBirdsList
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
    ImageArr: InkPaintingList
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
    ImageArr: shinvList
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
    ImageArr: HaipaiPaintingList
  }

];


export const paintingMap: Map<string, PaintingModel> = new Map<string, PaintingModel>(
  paintingModelList.map(painting => [painting.name, painting])
)



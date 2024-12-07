import {
  bambooImageList,
  ceramicImageList,
  ChineseShadowPuppetryImageList,
  clayFigurineImageList,
  DragonDanceAndLionDance,
  embroideryImageList,
  paperCuttingImageList
} from "./FolkArtImageData";

export class FolkArt {
  title: string;
  description: string;
  ImageList?: string[];

  constructor(title: string, description: string, ImageList?: string[]) {
    this.title = title;
    this.description = description;
    this.ImageList = ImageList;
  }
}

// 数据集
export const FolkArtList: FolkArt[] = [
  new FolkArt(
    '剪纸',
    '剪纸起源于汉代，发展至唐代已相当成熟，宋元时期达到鼎盛。它是指用剪刀或刻刀在纸上剪刻出图案的艺术形式，通常用于装饰、庆祝节日或者作为礼物赠送。主要种类有窗花，用于窗户装饰；喜字，常出现在婚礼上；生肖，十二生肖图案，多用于新年等节日。',
    paperCuttingImageList
  ),
  new FolkArt(
    '刺绣',
    '刺绣是中国四大传统手工艺之一，有着悠久的历史。刺绣有苏绣、湘绣、蜀绣、粤绣等多种流派，各自风格独特。它以其精美的图案、细腻的针法闻名于世。苏绣出自江苏苏州，以精细雅洁著称；湘绣来自湖南长沙，擅长表现人物肖像；蜀绣产自四川成都，图案豪放生动；粤绣源于广东，色彩浓艳，金碧辉煌。',
    embroideryImageList
  ),
  new FolkArt(
    '陶瓷艺术',
    '中国的陶瓷制作技艺历史悠久，从原始社会的陶器到后来的青瓷、白瓷、彩瓷等，种类繁多，技艺精湛。景德镇被誉为“瓷都”，是世界上著名的瓷器生产地之一。青花瓷以钴料绘画烧制而成，蓝白相间；粉彩瓷釉上彩绘，色彩柔和；汝窑瓷为宋代五大名窑之一，釉色淡雅如玉。',
    ceramicImageList
  ),
  new FolkArt(
    '竹编',
    '竹编是利用竹子编织各种生活用品和工艺品的传统技艺，如篮子、筐、帽等，既实用又美观，广泛流传于南方地区。常见的竹编制品包括篮子，用于装物；筐，大容量装载工具；帽，夏日遮阳；家具，如椅子、桌子等。',
    bambooImageList
  ),
  new FolkArt(
    '泥塑',
    '泥塑是以泥土为主要材料塑造各种人物、动物形象的手工艺品，广泛分布于全国各地，其中以天津的“泥人张”最为著名。天津泥人张以其精湛技艺和丰富表情而知名；陕西凤翔泥塑色彩斑斓，造型古朴。',
    clayFigurineImageList
  ),
  new FolkArt(
    '皮影戏',
    '皮影戏是一种古老的戏剧表演形式，起源于西汉，盛行于唐宋。通过操纵雕刻成人物形象的牛皮或羊皮制成的影偶，在灯光照射下投射到幕布上，配合音乐和说唱讲述故事。陕西皮影造型夸张，色彩对比强烈；河北皮影做工精细，表演细腻；四川皮影风格独特，富有地方特色。',
    ChineseShadowPuppetryImageList
  ),
  new FolkArt(
    '舞狮舞龙',
    '舞狮和舞龙是中国传统节庆活动中不可或缺的一部分，尤其是在春节和其他重要节日中。舞狮主要模仿狮子的各种动作，寓意驱邪避凶、带来好运；而舞龙则象征着吉祥如意、风调雨顺，两者都是为了祈求来年的丰收和幸福。南狮注重跳跃和翻滚，形态灵活；北狮体型较大，动作稳重；长龙适合多人协作表演；短龙便于灵活穿梭。',
    DragonDanceAndLionDance
  ),
  new FolkArt(
    '结语',
    '中国民间艺术是中华民族文化宝库中的瑰宝，它们不仅展示了中国人民的智慧和创造力，也传递了对美好生活的向往和祝福。我们呼吁更多的人参与到民间艺术的保护和传播中，共同传承这一宝贵的文化遗产。',
    undefined// 结语部分没有图像列表
  )
];
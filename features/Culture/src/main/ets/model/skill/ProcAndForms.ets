// 陶瓷艺术类，继承传统技艺接口
import { ArtForm, MakingProcess, TraditionalCraft } from './skillModel';


// 创建制作工艺实例
export const ceramicMakingProcesses: MakingProcess[] = [
  { name: "拉坯", description: "使用旋转的陶轮手工塑造陶瓷器皿的基本形状。" },
  { name: "修坯", description: "对拉坯后的陶瓷器皿进行细节上的修整和打磨。" },
  { name: "上釉", description: "在陶瓷器皿表面涂覆一层玻璃质地的釉料。" },
  { name: "彩绘", description: "在陶瓷器皿上绘制图案，可以是釉下彩或釉上彩。" },
  { name: "雕刻", description: "在陶瓷器皿上雕刻出各种图案或文字。" },
  { name: "烧制", description: "将陶瓷器皿在高温下烧制，使其硬化并固定形状和颜色。" }
];

// 创建艺术形式实例
export const ceramicArtForms: ArtForm[] = [
  { name: "青花瓷", description: "以钴蓝色料在瓷胎上绘制图案，再覆以透明釉烧制而成。" },
  { name: "粉彩瓷", description: "在烧好的素瓷上用粉彩料绘制，再低温烧制，色彩丰富柔和。" },
  { name: "斗彩瓷", description: "先用青花勾出轮廓，再在轮廓内填上其他色彩，形成对比效果。" },
  { name: "釉里红", description: "在瓷胎上绘制氧化铜为着色剂的红色图案，再覆盖釉料烧制。" },
  { name: "五彩瓷", description: "在瓷器上使用多种颜色进行绘制，色彩鲜明。" },
  { name: "玲珑瓷", description: "在瓷器上雕镂出透空的几何图案，内外图案相映成趣。" },
  { name: "颜色釉瓷", description: "以不同金属氧化物为着色剂，制成各种颜色的釉料，覆盖在瓷器上。" }
];

// 丝绸织造的制作工艺
export const silkMakingProcesses: MakingProcess[] = [
  { name: "蚕养殖", description: "通过养蚕收集蚕茧，制成丝线的基本原料。" },
  { name: "煮茧抽丝", description: "将蚕茧煮软后抽出丝纤维，形成初步的丝线。" },
  { name: "纺织", description: "通过织机将丝线编织成绸布。" },
  { name: "染色", description: "使用天然染料或人工染料对丝绸进行染色处理。" },
  { name: "刺绣", description: "在丝绸上进行刺绣加工，形成图案和纹样。" }
];

// 丝绸织造的艺术形式
export const silkArtForms: ArtForm[] = [
  { name: "缂丝", description: "一种高级丝织技法，以平面织机编织出精细花纹。" },
  { name: "云锦", description: "南京传统丝织工艺，以华丽的色彩和复杂的纹样著称。" },
  { name: "绫罗", description: "高级丝绸织物，质地轻薄而柔软，常用于服装。" }
];

// 金属工艺的制作工艺
export const metalMakingProcesses: MakingProcess[] = [
  { name: "铸造", description: "通过熔化金属并倒入模具，冷却成型后形成器物。" },
  { name: "锻造", description: "通过锤打和加热金属块，使其成型。" },
  { name: "镶嵌", description: "在金属表面镶嵌宝石或其他金属形成复杂图案。" },
  { name: "抛光", description: "对金属器物进行打磨，使其表面光滑闪亮。" }
];

// 金属工艺的艺术形式
export const metalArtForms: ArtForm[] = [
  { name: "青铜器", description: "古代青铜制品，常用于礼器和器皿，雕饰精美。" },
  { name: "金银器", description: "金银材质的器物，通常雕饰复杂，富贵典雅。" },
  { name: "鎏金工艺", description: "在金属表面镀上黄金，增加装饰效果。" }
];

import {
  ceramicArtForms,
  ceramicMakingProcesses,
  metalArtForms,
  metalMakingProcesses,
  silkArtForms,
  silkMakingProcesses
} from "./ProcAndForms";

// 定义传统技艺的基本接口
export interface TraditionalCraft {
  name: string; // 技艺名称
  description: string[]; // 技艺描述
  region: string; // 主要产地
  defineAndOrigin:string
  makingProcesses: MakingProcess[]
  artForms: ArtForm[]
}

// 制作工艺类
export interface MakingProcess {
  name: string; // 工艺名称
  description: string; // 工艺描述
}

// 艺术形式类
export interface ArtForm {
  name: string; // 艺术形式名称
  description: string; // 艺术形式描述
  Image?:ResourceStr; //图片
}

// 创建陶瓷艺术实例
export const ceramicArt: TraditionalCraft = {
  name: '陶瓷',
  description: ["在时间的流转中，泥土低声讲述着它的过往，工匠的双手细腻而坚定，塑造出最初的轮廓。熊熊窑火如同激情的诗人，" +
    "歌颂着变化的美妙，瓷胎在烈焰中重生，穿上了釉色的盛装。",
  "从简单到绚烂，每一道裂纹都是岁月的痕迹，每一抹色彩都是情感的流露。陶瓷，不只是容器的存在，它更是工匠智慧、艺术与生活和谐共存的体现。"],
  region: '景德镇',
  defineAndOrigin:"陶瓷，一种由粘土等无机非金属矿物制成的材料，经成型、干燥和高温烧制而成，以其硬度高、耐磨损和耐化学腐蚀等特性著称。" +
    "陶瓷不仅是日常餐具和工艺品的原料，也广泛应用于建筑、电子、化工等行业。其历史可追溯至新石器时代，最早陶器约出现在公元前8000年至2000年，" +
    "以实用器皿为主。中国作为陶瓷的发源地，早在旧石器时代晚期便开始制作陶器，江西仙人洞和湖南玉蟾岩遗址的发现，证明了陶瓷工艺的悠久历史。",
  makingProcesses: ceramicMakingProcesses,
  artForms: ceramicArtForms
}

// 创建丝绸织造实例
export const silkWeaving: TraditionalCraft = {
  name: '丝绸',
  description: ["在岁月的织机上，丝线细语着它的传说，织工的巧手灵巧而执着，编织出最初的纹理。烈烈织梭如同舞动的诗人，" +
    "描绘着交织的图案，丝帛在穿梭中诞生，披上了色彩的华服。",
  "从素白到斑斓，每一丝脉络都是时光的印记，每一片光泽都是情感的映照。丝绸，不只是衣物的温暖，它更是匠心独运、艺术与生活交织的象征。"],
  region: '苏州、杭州等地',
  defineAndOrigin:"丝绸，一种由蚕丝纤维制成的材料，通过抽取、纺织和加工而成，以其柔软、光泽和透气等特性闻名。丝绸不仅是高档服饰和装饰品的原料，" +
    "也用于家居、艺术等领域。其历史可追溯至中国的新石器时代，最早的丝绸制品约出现在公元前2700年左右，主要用于服饰。中国作为丝绸的发源地，" +
    "古文献记载黄帝时代已有养蚕织丝的技艺，而江苏和浙江的考古发现，如良渚文化遗址，证实了丝绸工艺的古老传承。",
  makingProcesses: silkMakingProcesses,
  artForms: silkArtForms
};

// 创建金属工艺实例
export const metalCraft: TraditionalCraft = {
  name: '金属工艺',
  description: ["在历史的熔炉中，金属沉吟着它的故事，铸匠的臂膀强壮而稳健，铸就了最初的形态。熊熊炉火如同激情的画家，描绘着凝固的辉煌，金属在熔炼中蜕变，" +
    "披上了光泽的铠甲。",
  "从熔岩到凝固，每一道纹路都是岁月的见证，每一抹光泽都是坚韧的诉说。金属工艺，不只是器具的坚固，它更是匠人智慧、艺术与力量完美融合的展现。"],
  region: '中原、北方等地',
  defineAndOrigin:"金属工艺，一门古老的技艺，通过对金属的提炼、铸造、锻造和雕刻等手段，将原材料转化为各种器具和艺术品。它以其坚固、" +
    "耐用和璀璨的特质而著称，不仅是工具和武器的诞生之地，也是装饰和象征的载体。金属工艺的历史悠久，可以追溯到史前时代，" +
    "最早的金属制品出现在公元前9000年左右，" +
    "标志着人类文明的一次重大飞跃。世界各地，从古埃及的金字塔到中国的青铜器，金属工艺的痕迹无处不在。",
  makingProcesses: metalMakingProcesses,
  artForms: metalArtForms
};


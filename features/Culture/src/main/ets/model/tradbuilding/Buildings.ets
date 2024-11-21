// 建筑类
export class TraditionalBuilding {
  name: string; // 建筑名称
  region: string; // 地区
  features: string; // 特征描述
  history: string; // 历史背景
  examples: string[]; // 代表性实例
  significance: string; // 文化意义

  constructor(
    name: string,
    region: string,
    features: string,
    history: string,
    examples: string[],
    significance: string
  ) {
    this.name = name;
    this.region = region;
    this.features = features;
    this.history = history;
    this.examples = examples;
    this.significance = significance;
  }
}

// 实例数据
export const buildingList: TraditionalBuilding[] = [
  new TraditionalBuilding(
    "皖派建筑",
    "安徽",
    "青瓦白墙、砖雕门楼，建筑多采用马头墙，具有独特的曲线美。",
    "徽派建筑源于古徽州，展现了徽商的富庶与文化，尤其以民居、祠堂和牌坊著称。2000年被列入世界遗产名录。",
    ["徽州民居", "祠堂", "牌坊"],
    "徽派建筑代表了中国传统文化的精髓，融入了徽州独特的地域文化与商贾精神。"
  ),
  new TraditionalBuilding(
    "苏派建筑",
    "江苏",
    "园林式布局，建筑轻巧，脊角高翘，常见明瓦窗、砖雕门楼，巧妙融合水景与山景。",
    "苏派建筑以苏州园林为代表，强调自然与建筑的和谐，体现了江南的文人气息与生活哲学。",
    ["拙政园", "留园"],
    "苏派建筑承载了江南文化的灵动与优雅，强调人与自然的亲密关系，是中国传统文化的重要组成部分。"
  ),
  new TraditionalBuilding(
    "闽派建筑",
    "福建",
    "以土楼为代表，外墙厚重，具有防御功能，建筑结构复杂，内部分为多个家庭居住区。",
    "土楼是闽南地区独特的聚族而居的建筑形式，源于古代生土夯筑技术，至今已有五百多年历史。",
    ["永定客家土楼", "圆楼"],
    "闽派建筑反映了福建地区的家庭观念与防御智慧，土楼不仅是居住地，更是文化的传承载体。"
  ),
  new TraditionalBuilding(
    "京派建筑",
    "北京",
    "对称布局，四合院宽敞，房屋之间独立，雕饰华丽，体现出北方的传统文化与礼仪。",
    "京派建筑以四合院为核心，承载着北京丰富的历史与文化，体现了古代士大夫的居住理想与社会结构。",
    ["故宫", "四合院"],
    "京派建筑不仅是居住空间，更是历史的见证，深刻影响了北方的文化习俗和生活方式。"
  ),
  new TraditionalBuilding(
    "晋派建筑",
    "山西",
    "以窑洞与乔家大院为代表，建筑稳重大气，砖雕、木雕工艺精湛，反映晋商的经济实力与文化底蕴。",
    "晋派建筑具有深厚的历史文化积淀，尤其是山西地区的窑洞，适应当地气候，成为一种独特的居住形式。",
    ["乔家大院", "窑洞"],
    "晋派建筑体现了晋商文化的坚韧与灵活性，展现了人与自然的和谐共生。"
  ),
  new TraditionalBuilding(
    "川派建筑",
    "四川",
    "特色鲜明的吊脚楼与竹楼，依山而建，屋檐飞翘，设计灵活，适应潮湿气候。",
    "川派建筑融合了多民族文化，特别是少数民族的居住形式，展示了独特的建筑智慧与生活方式。",
    ["傣族竹楼", "侗族鼓楼", "川西吊脚楼"],
    "川派建筑是多民族文化交融的结晶，体现了四川人民对自然环境的尊重与适应。"
  )
];



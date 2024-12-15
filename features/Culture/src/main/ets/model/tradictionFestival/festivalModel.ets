export class Festival {
  name: string = ""; // 节日名称
  date: string = ""; // 节日日期
  origin: string = ""; // 节日起源
  description: string = ""; // 节日描述
  customs: Custom[] = []; // 节日习俗，存储为 Custom 对象数组

  path?: ResourceStr = ""; // 文件路径

  constructor(
    name: string = "",
    date: string = "",
    origin: string = "",
    customs: Custom[] = [],
    description: string = "",
    path?: ResourceStr
  ) {
    this.name = name;
    this.date = date;
    this.origin = origin;
    this.customs = customs;
    this.description = description;
    this.path = path
  }

  // 获取节日信息的简要描述
  getSummary(): string {
    return `${this.name} 是在 ${this.date} 举行的传统节日。起源于 ${this.origin}`;
  }
}

export class Custom {
  name: string = ""; // 习俗名称
  description: string = ""; // 习俗的详细描述
  region: string = ""; // 流行地区，可以用于多地区文化区分


  constructor(
    name: string = "",
    description: string = "",
    region: string = ""
  ) {
    this.name = name;
    this.description = description;
    this.region = region;
  }
}

export const festivalList: Festival[] = [
  new Festival(
    "春节",
    "农历正月初一",
    "起源于古代年终岁首的祭祀活动。春节的前身是上古时期的“岁首”，后来逐渐演变为庆祝丰收和迎接新年的活动。",

    [
      new Custom(
        "贴春联",
        "在门上贴春联，增添喜庆的节日气氛。",
        "全国"
      ),
      new Custom(
        "放鞭炮",
        "燃放鞭炮驱邪避凶，辞旧迎新。",
        "全国"
      ),
      new Custom(
        "吃饺子",
        "象征团圆和吉祥，北方地区尤为流行。",
        "北方"
      )
    ],
    "春节象征团圆和新年伊始，通过贴春联、放鞭炮、吃饺子等习俗庆祝。",
    $r('app.media.background_springfestval'),
  ),

  new Festival(
    "清明节",
    "公历4月4日至6日",
    "源于古代春祭礼仪，起初是为了扫墓祭祖、悼念逝去的亲人。后与寒食节合并，逐渐演变成集祭祀、踏青为一体的节日。",
    [
      new Custom(
        "扫墓",
        "到先人坟前扫墓，表达对逝者的怀念之情。",
        "全国"
      ),
      new Custom(
        "踏青",
        "春暖花开时节，人们外出踏青赏春。",
        "全国"
      )
    ],
    "清明节是祭祀祖先和踏青赏春的日子，象征着思念和春天的到来。",
    $r('app.media.background_qingming'),
  ),

  new Festival(
    "端午节",
    "农历五月初五",
    "据传是为了纪念战国时期的爱国诗人屈原，他在被流放后于五月初五投江自尽。后人为纪念他，形成端午节。",
    [
      new Custom(
        "吃粽子",
        "用竹叶包裹糯米做成粽子，以纪念屈原。",
        "全国"
      ),
      new Custom(
        "赛龙舟",
        "人们以赛龙舟来纪念屈原。",
        "南方"
      )
    ],
    "端午节纪念屈原，人们吃粽子、赛龙舟，以表达对他的崇敬。",
    $r('app.media.background_dragonBoatFestival'),
  ),

  new Festival(
    "七夕节",
    "农历七月初七",
    "起源于汉朝，源于古老的牛郎织女传说。据说这一天织女与牛郎隔河相会，被称为“乞巧节”。",
    [
      new Custom(
        "乞巧",
        "少女向织女乞求灵巧的心灵手巧。",
        "全国"
      ),
      new Custom(
        "拜织女",
        "女子在庭院中祭拜织女，祈求姻缘和心灵手巧。",
        "全国"
      )
    ],
    "七夕节是中国传统的情人节，象征着爱情和美满的婚姻。",
    $r('app.media.background_qixi'),
  ),

  new Festival(
    "中秋节",
    "农历八月十五",
    "起源于古代对月亮的祭祀礼仪，后来与嫦娥奔月的传说结合，成为团圆的象征。",
    [
      new Custom(
        "赏月",
        "在中秋夜人们会观赏圆月。",
        "全国"
      ),
      new Custom(
        "吃月饼",
        "月饼象征团圆，是中秋节的传统食物。",
        "全国"
      )
    ],
    "中秋节象征着团圆，家人共聚、赏月、吃月饼，共享温馨时光。",
    $r('app.media.background_midAutomn'),
  ),

  new Festival(
    "重阳节",
    "农历九月初九",
    "起源于古代“登高避祸”的习俗，传说九月九日是阳气极盛的日子，需登高以避灾祸。",
    [
      new Custom(
        "登高",
        "在重阳节登高望远，以祈求健康。",
        "全国"
      ),
      new Custom(
        "赏菊",
        "菊花在秋季盛开，赏菊成为重阳节的一项习俗。",
        "全国"
      )
    ],
    "重阳节又称“老人节”，人们登高祈福、赏菊，表达对长辈的敬爱。",
    $r('app.media.background_chongyang'),
  )
];


export class Attraction {
  id: number;
  name: string;
  image: Resource;
  description?: string;
  category?: string;

  constructor(id: number, name: string, image: Resource, description?: string) {
    this.id = id;
    this.name = name;
    this.image = image;
    this.description = description;
  }
}

export const famousPlaces: Attraction[] = [
  new Attraction(1, '秦始皇陵', $r('app.media.qinshihuanglin'), '中国历史上第一位皇帝秦始皇的陵墓，以兵马俑闻名于世。'),
  new Attraction(2, '故宫', $r('app.media.gugong'), '位于北京的明清两代皇宫，是中国古代宫廷建筑之精华。'),
  new Attraction(3, '长城', $r("app.media.changcheng"), '中国古代的军事防御工程，东起辽东，西至嘉峪关，绵延数千里。'),
  new Attraction(4, '敦煌莫高窟', $r('app.media.mogao'), '位于甘肃省敦煌市的佛教艺术地，拥有大量的壁画和雕塑。'),
  new Attraction(5, '乐山大佛', $r('app.media.leshandafo'), '位于四川省乐山市的巨大石刻佛像，是世界文化遗产之一。'),
  new Attraction(6, '颐和园', $r('app.media.yiheyuan'), '位于北京，是中国保存最完整的皇家园林，被誉为皇家园林博物馆。'),
  new Attraction(7, '天坛', $r('app.media.tiantan'), '明清两代皇帝祭祀天神和祈求五谷丰登的地方，是中国古代建筑的杰作。'),
];



//接口属性有周边酒店、自动导游、出行人数
interface OhterItem {
  hotel: string;
  guide: string;
  people: number;
}
//OtherItem数组
export const otherItemList: OhterItem[] = [
  { hotel: '周边酒店',guide: '自动导游', people: 131 },
  { hotel: '优质交通', guide: '导游无忧', people: 242 },
  { hotel: '周边酒店', guide: 'AI导游', people: 91 },
  { hotel: '周边酒店', guide: 'AI导游', people: 84 },
  { hotel: '周边酒店', guide: 'AI导游', people: 304 },
  { hotel: '周边酒店', guide: 'AI导游', people: 247 },
  { hotel: '周边酒店', guide: 'AI导游', people: 192 }
];



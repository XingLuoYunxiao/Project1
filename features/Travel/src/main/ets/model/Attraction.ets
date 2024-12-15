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



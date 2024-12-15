export interface classification {
  category: string;
  image: Resource;
  subClasses?: classification[];
  page?: string;
}

export interface color{
  color: Color | string;
}

export const colorList: color[] = [
  {
    color: Color.Green
  },
  {
    color: '#ff578be2'
  },
  {
    color: Color.Orange
  },
  {
    color: Color.Pink
  },
  {
    color: '#ffcabd44'
  }
]

export const classificationList: classification[] = [
  {
    category: '旅游景点',
    image: $r('app.media.class_1')
  },
  {
    category: '必游榜单',
    image: $r('app.media.class_2'),
  },
  {
    category: 'AI导游',
    image: $r('app.media.class_4'),
    page: 'FamousPlacePage'
  },
  {
    category: '动植物园',
    image: $r('app.media.class_3'),
  },
  {
    category: '一日游玩',
    image: $r('app.media.class_5'),
  }
];

export const classificationListPhone: classification[] = [
  {
    category: '旅游景点',
    image: $r('app.media.phone_class1')
  },
  {
    category: '必游榜单',
    image: $r('app.media.phone_class2')
  },
  {
    category: 'AI导游',
    image: $r('app.media.phone_class3'),
    page: 'FamousPlacePage'
  },
  {
    category: '动植物园',
    image: $r('app.media.phone_class4')
  },
  {
    category: '一日游玩',
    image: $r('app.media.phone_class5')
  }
];
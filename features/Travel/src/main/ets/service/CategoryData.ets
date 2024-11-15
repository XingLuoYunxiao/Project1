export interface City {
  cityId: string;
  cityName: string;
  proId?: string; //省份id
  proName?: string;//省份

}

export interface CategoryItem {
  id: number;
  name: string;
  subCategories?: CategoryItem[];
}


export const mainCategories: CategoryItem[] = [
  {
    id: 1,
    name: '全部景点',
    subCategories: [
      {
        id: 10,
        name: '全部分类',
        subCategories: [
          { id: 101, name: '全部分类' }
        ]
      },
      {
        id: 11,
        name: '动植物园',
        subCategories: [
          { id: 111, name: '动物园' },
          { id: 112, name: '水族馆' },
          { id: 113, name: '植物园' },
          { id: 114, name: '野生动物保护区' }
        ]
      },
      {
        id: 12,
        name: '城市观光',
        subCategories: [
          { id: 121, name: '地标观光' },
          { id: 122, name: '影视基地' },
          { id: 123, name: '大学' },
          { id: 124, name: '博物馆' },
          { id: 125, name: '城市公园' }
        ]
      },
      {
        id: 13,
        name: '自然风光',
        subCategories: [
          { id: 131, name: '森林公园' },
          { id: 132, name: '海滨公园' },
          { id: 133, name: '沙漠草滩' },
          { id: 134, name: '历史遗迹' },
          { id: 135, name: '山脉' },
          { id: 136, name: '湖泊' },
          { id: 137, name: '瀑布' },
          { id: 138, name: '温泉' }
        ]
      },
      {
        id: 14,
        name: '休闲娱乐',
        subCategories: [
          { id: 141, name: '游乐场' },
          { id: 142, name: '运动场' },
          { id: 143, name: '休闲广场' },
          { id: 144, name: '夜市' }
        ]
      },
      {
        id: 15,
        name: '主题乐园',
        subCategories: [
          { id: 151, name: '水上乐园' },
          { id: 152, name: '冒险乐园' },
          { id: 153, name: '儿童乐园' },
          { id: 154, name: '恐龙乐园' }
        ]
      },
      {
        id: 16,
        name: '展览馆',
        subCategories: [
          { id: 161, name: '美术馆' },
          { id: 162, name: '科技馆' },
          { id: 163, name: '历史博物馆' },
          { id: 164, name: '军事博物馆' }
        ]
      },
      {
        id: 17,
        name: '宗教场所',
        subCategories: [
          { id: 171, name: '寺庙' },
          { id: 172, name: '教堂' },
          { id: 173, name: '清真寺' },
          { id: 174, name: '道观' },
          { id: 175, name: '佛教圣地' }
        ]
      },
      {
        id: 18,
        name: '户外探险',
        subCategories: [
          { id: 191, name: '登山' },
          { id: 192, name: '滑雪' },
          { id: 193, name: '徒步' },
          { id: 194, name: '露营' },
          { id: 195, name: '攀岩' }
        ]
      },
      {
        id: 19,
        name: '海岛风光',
        subCategories: [
          { id: 201, name: '海滩' },
          { id: 202, name: '珊瑚礁' },
          { id: 203, name: '海岛度假村' },
          { id: 204, name: '水上运动' }
        ]
      }
    ]
  },
  {
    id: 2,
    name: '位置距离',
    subCategories: [
      {
        id: 21,
        name: '距离',
        subCategories: [
          { id: 211, name: '不限距离' },
          { id: 212, name: '5公里' },
          { id: 213, name: '10公里' },
          { id: 214, name: '15公里' },
          { id: 215, name: '20公里' },
          { id: 216, name: '50公里' },
          { id: 227, name: '100公里' }
        ]
      },
      {
        id:22,
        name: '商圈',
      }
    ]
  },
  {
    id: 3,
    name: '综合排序',
    subCategories: [
      {
        id: 31,
        name: '综合排序',
        subCategories: [
          { id: 31, name: '评分最高' },
          { id: 32, name: '价格最低' },
          { id: 33, name: '最近距离' }
        ]
      }
    ]
  },
  {
    id: 4,
    name: '筛选',
    subCategories: [
      {
        id: 41,
        name: '预订时间',
        subCategories:[
          { id: 41, name: '今日可定' },
          { id: 42, name: '明日可定' },
          { id: 43, name: '周末可定' }
        ]
      },
      {
        id: 42,
        name: '等级',
        subCategories:[
          { id: 41, name: '5A级' },
          { id: 42, name: '4A级' },
          { id: 43, name: '星级景区' },
        ]
      }
    ]
  }
];
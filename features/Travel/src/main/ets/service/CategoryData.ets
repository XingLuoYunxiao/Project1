export interface City {
  cityId: string;
  cityName: string;
  cityCode?: string;
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

export interface CityTab {
  title: string;
  cityList: City[];
}



export const cities: City[] = [
// 历史/热门
  { cityId: "0", cityName: "所有", cityCode: "000000", proId: "000", proName: "所有" },
  { cityId: "1", cityName: "北京", cityCode: "110000", proId: "010", proName: "北京" },
  { cityId: "2", cityName: "上海", cityCode: "310000", proId: "021", proName: "上海" },
  { cityId: "9", cityName: "广州", cityCode: "440100", proId: "020", proName: "广东" },
  { cityId: "4", cityName: "深圳", cityCode: "440300", proId: "0755", proName: "广东" },
  { cityId: "5", cityName: "杭州", cityCode: "330100", proId: "0571", proName: "浙江" },
  { cityId: "6", cityName: "南京", cityCode: "320100", proId: "025", proName: "江苏" },
  { cityId: "7", cityName: "成都", cityCode: "510000", proId: "028", proName: "四川" },
  { cityId: "8", cityName: "武汉", cityCode: "420000", proId: "027", proName: "湖北" },
  { cityId: "3", cityName: "西安", cityCode: "610000", proId: "029", proName: "陕西" },

  // 江浙沪
  { cityId: "10", cityName: "南京", cityCode: "320000", proId: "025", proName: "江苏" },
  { cityId: "11", cityName: "苏州", cityCode: "320500", proId: "0512", proName: "江苏" },
  { cityId: "12", cityName: "无锡", cityCode: "320200", proId: "0510", proName: "江苏" },
  { cityId: "13", cityName: "常州", cityCode: "320400", proId: "0519", proName: "江苏" },
  { cityId: "14", cityName: "南通", cityCode: "320600", proId: "0513", proName: "江苏" },
  { cityId: "15", cityName: "扬州", cityCode: "321000", proId: "0514", proName: "江苏" },
  { cityId: "16", cityName: "连云港", cityCode: "320700", proId: "0518", proName: "江苏" },
  { cityId: "17", cityName: "杭州", cityCode: "330000", proId: "0571", proName: "浙江" },
  { cityId: "18", cityName: "舟山", cityCode: "330900", proId: "0580", proName: "浙江" },
  { cityId: "19", cityName: "宁波", cityCode: "330200", proId: "0574", proName: "浙江" },
  { cityId: "20", cityName: "嘉兴", cityCode: "330400", proId: "0573", proName: "浙江" },
  { cityId: "21", cityName: "温州", cityCode: "330300", proId: "0577", proName: "浙江" },

  // 京津冀
  { cityId: "22", cityName: "北京", cityCode: "110000", proId: "010", proName: "北京" },
  { cityId: "23", cityName: "天津", cityCode: "120000", proId: "022", proName: "天津" },
  { cityId: "24", cityName: "石家庄", cityCode: "130100", proId: "0311", proName: "河北" },
  { cityId: "25", cityName: "秦皇岛", cityCode: "130300", proId: "0335", proName: "河北" },
  { cityId: "26", cityName: "保定", cityCode: "130600", proId: "0312", proName: "河北" },
  { cityId: "27", cityName: "承德", cityCode: "130800", proId: "0314", proName: "河北" },
  { cityId: "28", cityName: "邯郸", cityCode: "130400", proId: "0310", proName: "河北" },
  { cityId: "29", cityName: "唐山", cityCode: "130200", proId: "0315", proName: "河北" },
  { cityId: "30", cityName: "张家口", cityCode: "130700", proId: "0313", proName: "河北" },

  // 云贵川
  { cityId: "31", cityName: "昆明", cityCode: "530000", proId: "0871", proName: "云南" },
  { cityId: "32", cityName: "丽江", cityCode: "530700", proId: "0888", proName: "云南" },
  { cityId: "33", cityName: "西双版纳", cityCode: "532800", proId: "0691", proName: "云南" },
  { cityId: "34", cityName: "大理", cityCode: "532900", proId: "0872", proName: "云南" },
  { cityId: "35", cityName: "红河", cityCode: "532500", proId: "0873", proName: "云南" },
  { cityId: "36", cityName: "保山", cityCode: "530500", proId: "0875", proName: "云南" },
  { cityId: "37", cityName: "普洱", cityCode: "530800", proId: "0879", proName: "云南" },
  { cityId: "38", cityName: "贵阳", cityCode: "520000", proId: "0851", proName: "贵州" },
  { cityId: "39", cityName: "安顺", cityCode: "520400", proId: "0853", proName: "贵州" },
  { cityId: "40", cityName: "铜仁", cityCode: "520600", proId: "0856", proName: "贵州" },
  { cityId: "41", cityName: "遵义", cityCode: "520300", proId: "0852", proName: "贵州" },
  { cityId: "42", cityName: "黔东南", cityCode: "522600", proId: "0855", proName: "贵州" },
  { cityId: "43", cityName: "黔南", cityCode: "522700", proId: "0854", proName: "贵州" },
  { cityId: "44", cityName: "成都", cityCode: "510000", proId: "028", proName: "四川" },
  { cityId: "45", cityName: "乐山", cityCode: "511100", proId: "0833", proName: "四川" },
  { cityId: "46", cityName: "甘孜", cityCode: "513300", proId: "0836", proName: "四川" },
  { cityId: "47", cityName: "绵阳", cityCode: "510700", proId: "0816", proName: "四川" },
  { cityId: "48", cityName: "阿坝", cityCode: "513200", proId: "0837", proName: "四川" },
  { cityId: "49", cityName: "自贡", cityCode: "510300", proId: "0813", proName: "四川" },

  // 珠三角
  { cityId: "50", cityName: "广州", cityCode: "440000", proId: "020", proName: "广东" },
  { cityId: "51", cityName: "深圳", cityCode: "440300", proId: "0755", proName: "广东" },
  { cityId: "52", cityName: "珠海", cityCode: "440400", proId: "0756", proName: "广东" },
  { cityId: "53", cityName: "佛山", cityCode: "440600", proId: "0757", proName: "广东" },
  { cityId: "54", cityName: "东莞", cityCode: "441900", proId: "0769", proName: "广东" },
  { cityId: "55", cityName: "清远", cityCode: "441800", proId: "0763", proName: "广东" },

  // 港澳台
  { cityId: "56", cityName: "香港", cityCode: "810000", proId: "1852", proName: "香港" },
  { cityId: "57", cityName: "澳门", cityCode: "820000", proId: "1853", proName: "澳门" },
  { cityId: "58", cityName: "台北", cityCode: "710100", proId: "0", proName: "台湾" }
];

//城市选择tab
export const cityTabs: CityTab[] = [
  {
    title: '热门城市',
    cityList: cities.slice(0, 9)
  },
  {
    title: '江浙沪',
    cityList: cities.slice(9, 17)
  },
  {
    title: '京津冀',
    cityList: cities.slice(17, 26)
  },
  {
    title: '云贵川',
    cityList: cities.slice(26, 35)
  },
  {
    title: '珠三角',
    cityList: cities.slice(35, 45)
  },
  {
    title: '港澳台',
    cityList: cities.slice(45, 58)
  }

]

import { cloudDatabase } from '@kit.CloudFoundationKit';

class Xiehouyu extends cloudDatabase.DatabaseObject {
  id: number;
  riddle: string = "";
  answer: string = "";

  naturalbase_ClassName(): string {
    return 'Xiehouyu';
  }
}

export { Xiehouyu };


// 创建一个新的 Map 实例
let pinMap = new Map<string, number>();

// 定义键值对数组
let keyValuePairs: [string, number][] = [
  ['A', 1], ['B', 72], ['C', 833], ['Z', 1070],
  ['D', 1761], ['E', 3096], ['F', 3272], ['H', 3559],
  ['G', 3791], ['J', 4799], ['K', 5372], ['L', 5597],
  ['M', 6512], ['N', 7675], ['O', 8078], ['P', 8084],
  ['Q', 8412], ['R', 8951], ['S', 9120], ['W', 9981],
  ['T', 10439], ['X', 11569], ['Y', 12362]
];

// 将键值对添加到 Map 中
keyValuePairs.forEach(([key, value]) => {
  pinMap.set(key, value);
});

export { pinMap as XiehouyuPinMap }
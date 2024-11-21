export function deepCopy(obj: any): any {
  if (typeof obj !== 'object' || obj === null) {
    return obj; // 如果是基础类型或者null，直接返回
  }

  let copy: any;
  if (Array.isArray(obj)) {
    copy = obj.map(item => deepCopy(item)); // 深拷贝数组元素
  } else {
    copy = {};
    for (let key in obj) {
      if (obj.hasOwnProperty(key)) {
        if (obj[key] !== undefined) {
          copy[key] = deepCopy(obj[key]); // 只拷贝非undefined的属性
        }
      }
    }
  }
  return copy;
}

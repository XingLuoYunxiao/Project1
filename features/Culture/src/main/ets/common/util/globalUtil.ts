export function setAllUndefinedPropertiesToEmptyString<T extends object>(obj: T): T {
  for (const key in obj) {
    if (obj.hasOwnProperty(key)) {
      const value = obj[key];
      if (value === undefined) {
        obj[key] = '' as unknown as T[typeof key];
      }
    }
  }
  return obj;
}

// 使用示例
interface MyObject {
  name?: string;
  age?: number;
  address?: string;
}

let myObj: MyObject = {
  name: 'Alice',
  age: undefined,
  address: undefined
};

//console.log(myObj); // 输出: { name: 'Alice', age: undefined, address: undefined }

setAllUndefinedPropertiesToEmptyString(myObj);

//console.log(myObj); // 输出: { name: 'Alice', age: '', address: '' }
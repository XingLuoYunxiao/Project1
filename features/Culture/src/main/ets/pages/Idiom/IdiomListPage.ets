// import { Xiehouyu } from "../../model/Xiehouyu";
// import { util } from "@kit.ArkTS";
// import { BasicDataSource } from "../../model/poetryModel/PoetryModel";
// import { Idiom } from "../../model/Idiom/Idiom";
//
//
// function bufferToString(buffer: ArrayBufferLike): string {
//   let textDecoder = util.TextDecoder.create('utf-8', {
//     ignoreBOM: true
//   });
//   let resultPut = textDecoder.decodeToString(new Uint8Array(buffer), {
//     stream: true
//   });
//   return resultPut;
// }
//
// @Component
// export struct IdiomListPage {
//
//   @State data: PoemModel | null = null
//
//   getArticleModelObjFromJSON() {
//     getContext(this).resourceManager.getRawFileContent('article1000.json').then(value => {
//       let jsonObj = JSON.parse(bufferToString(value.buffer)) as Xiehouyu[];
//       let resources: Xiehouyu[] = [];
//       jsonObj.forEach((res: Xiehouyu) => {
//         resources.push(res);
//       });
//       this.data = new PoemModel(resources);
//     })
//   }
//
//   build() {
//     NavDestination() {
//       List() {
//         LazyForEach(this.data, (item: Xiehouyu) => {
//           ListItem() {
//             Idiombuilder({ idiom: item })
//           }
//         })
//       }
//     }
//   }
// }
//
// @Component
// struct Idiombuilder {
//   @Prop idiom: Idiom
//
//   build() {
//     Row() {
//       Text(this.idiom.word)
//       Text(this.idiom.data)
//     }
//   }
// }
//
//
// class PoemModel extends BasicDataSource<Xiehouyu> {
//   data: Array<Xiehouyu> = []; // 诗歌数据数组
//
//   // 获取指定索引的数据
//   public getData(index: number): void | Xiehouyu {
//     if (index === this.data.length - 1) {
//     }
//     return this.data[index];
//   }
// }
//

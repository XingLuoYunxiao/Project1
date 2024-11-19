// import { dataSharePredicates } from '@kit.ArkData';
// import { photoAccessHelper } from '@kit.MediaLibraryKit';
// // class MediaDataHandler implements photoAccessHelper.MediaAssetDataHandler<ArrayBuffer> {
// //   onDataPrepared(data: ArrayBuffer) {
// //     if (data === undefined) {
// //       console.error('Error occurred when preparing data');
// //       return;
// //     }
// //     console.info('on image data prepared');
// //     // 应用自定义对资源数据的处理逻辑
// //     example()
// //   }
// // }
//
// async function example(context: Context,uri:string) {
//   let phAccessHelper = photoAccessHelper.getPhotoAccessHelper(context);
//   let predicates: dataSharePredicates.DataSharePredicates = new dataSharePredicates.DataSharePredicates();
//   // let uri = 'file://media/Photo/1/IMG_1730608868_000/IMG_000.jpg'
//   predicates.equalTo(photoAccessHelper.PhotoKeys.URI, uri.toString());
//   let fetchOptions: photoAccessHelper.FetchOptions = {
//     fetchColumns: [photoAccessHelper.PhotoKeys.TITLE],
//     predicates: predicates
//   };
//
//   try {
//     let fetchResult: photoAccessHelper.FetchResult<photoAccessHelper.PhotoAsset> = await phAccessHelper.getAssets(fetchOptions);
//     let photoAsset: photoAccessHelper.PhotoAsset = await fetchResult.getFirstObject();
//     console.info('getAssets photoAsset.uri : ' + photoAsset.uri);
//     // 获取属性值，以标题为例；对于非默认查询的属性，get前需要在fetchColumns中添加对应列名
//     console.info('title : ' + photoAsset.get(photoAccessHelper.PhotoKeys.TITLE));
//     // 请求图片资源数据
//     let requestOptions: photoAccessHelper.RequestOptions = {
//       deliveryMode: photoAccessHelper.DeliveryMode.HIGH_QUALITY_MODE,
//     }
//     await photoAccessHelper.MediaAssetManager.requestImageData(context, photoAsset, requestOptions, new MediaDataHandler());
//     console.info('requestImageData successfully');
//     fetchResult.close();
//   } catch (err) {
//     console.error('getAssets failed with err: ' + err);
//   }
// }
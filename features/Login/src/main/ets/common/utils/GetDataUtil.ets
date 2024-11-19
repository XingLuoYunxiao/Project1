// import cloud, { Database } from '@hw-agconnect/cloud'
// import schema from '../../../resources/rawfile/schema.json'
// import { myOrder } from '../../model/myOrder'
// import { Collection } from '../../model/Collection'
// import { BrowsingHistory } from '../../model/BrowsingHistory'
// import { mySpot } from '../../model/mySpot'
// import { Poem } from '../../model/Poem'
//
// class GetData{
//   private database: Database | null = null
//
//   async getorderData( personUid: string): Promise<myOrder[]>{
//     this.database = cloud.database({
//       zoneName: "Travel",
//       objectTypeInfo: schema
//     })
//
//     const itemlist =await this.database.collection(myOrder)//选择表
//       .query()
//       .equalTo('user_id',personUid)
//       .orderByDesc('order_id')
//       .get()
//
//     return itemlist
//   }
//
//   async getspotData(spotid:number): Promise<mySpot[]>{
//     this.database = cloud.database({
//       zoneName: "Travel",
//       objectTypeInfo: schema
//     })
//
//     const itemlist =await this.database.collection(mySpot)//选择表
//       .query()
//       .equalTo('id', spotid)
//       .get()
//
//     return itemlist
//   }
//
//   async getpoemData(poemid:number): Promise<Poem[]>{
//     this.database = cloud.database({
//       zoneName: "Travel",
//       objectTypeInfo: schema
//     })
//
//     const itemlist =await this.database.collection(Poem)//选择表
//       .query()
//       .equalTo('numId', poemid)
//       .get()
//
//     return itemlist
//   }
//
//   async getcollectData(personUid: string): Promise<Collection[]>{
//     this.database = cloud.database({
//       zoneName: "Travel",
//       objectTypeInfo: schema
//     })
//
//     const itemlist =await this.database.collection(Collection)//选择表
//       .query()
//       .equalTo('userId',personUid)
//       .get()
//
//     return itemlist
//   }
//
//   async gethistoryData(personUid: string): Promise<BrowsingHistory[]>{
//     this.database = cloud.database({
//       zoneName: "Travel",
//       objectTypeInfo: schema
//     })
//
//     const itemlist =await this.database.collection(BrowsingHistory)//选择表
//       .query()
//       .equalTo('userId',personUid)
//       .get()
//
//     return itemlist
//   }
//
// }
// const itemdata=new GetData()
// export default itemdata as GetData
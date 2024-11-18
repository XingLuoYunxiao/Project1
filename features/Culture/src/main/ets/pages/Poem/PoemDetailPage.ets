import { async } from "@hw-agconnect/cloud/src/main/ets/storage/upload/task"
import { GetDataFormCloudDb } from "../../common/constants/CloundDb/getDataFormCloudDb"
import { Poem } from "../../model/Poem"
import { Writer } from "../../model/Writer"

@Component
export struct PoemDetailPage{
  @Consume('culturePathStack') culturePathStack: NavPathStack; // 导入导航路径栈，用于页面导航
  @Prop poem:Poem
  @State writer:Writer =new Writer()

 async aboutToAppear(): Promise<void> {
      let poets:Writer[]|undefined =await GetDataFormCloudDb.fetchWriterData(this.poem.writer)
   if(poets){
     this.writer =poets[0]
   }


  }
  build() {
    NavDestination(){
      Scroll(){
        Column({space:12}){

          Row(){
            Image($r('app.media.ic_back'))
              .width(40)
              .onClick(()=>{
                this.culturePathStack.pop()
              })
          }
          .justifyContent(FlexAlign.Start)
          .width('100%')
          //
          Row({space:10}){
            if(this.poem && this.poem.writer){
              Text(this.poem.writer)
            }
            if(this.poem && this.poem.dynasty){
              Text(this.poem.dynasty)
            }




          }
          .width('100%')
          .justifyContent(FlexAlign.Start)

          if (this.poem && this.writer){
            Text(this.writer.simpleIntro)
          }


          if(this.poem && this.poem.title){
            Text( this.poem.title)
              .fontWeight(FontWeight.Medium)
              .margin({top:20})
          }


          if(this.poem &&this.poem.content){
            Text(  this.poem.content)
          }



          if(this.poem &&this.poem.remark){
            Text(this.poem.remark)
          }


          Text('翻译')
            .fontSize($r('app.float.title_text_size'))
            .fontWeight(FontWeight.Medium)
            .fontWeight(FontWeight.Medium)
          if(this.poem &&this.poem.translation){
            Text(this.poem.translation)
          }

          Text('赏析')
            .fontSize($r('app.float.title_text_size'))
            .fontWeight(FontWeight.Medium)
          if(this.poem &&this.poem.shangxi){
            Text(this.poem.shangxi)
              .margin({bottom:10})
          }


        }
        .alignItems(HorizontalAlign.Center)
        .width('100%')
        .backgroundColor('#fff5eee6')
        .padding(15)
      }


    }
    .hideTitleBar(true)
    .onHidden(()=>{
      this.culturePathStack.pop()
    })


  }

}

@Builder
export function PoemDetailPageBuilder(name:string,param:object){
  PoemDetailPage({poem:param as Poem})
}
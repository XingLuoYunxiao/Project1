import { i18n } from '@kit.LocalizationKit';
@Builder
export  function PoetryAndClassicPageBuilder(name: string, param: Object){
  PoetryAndClassicPage()
}



@Component
export struct PoetryAndClassicPage{

  list:string[]=['楚辞','诗经','论语','四书五经','诗词','小说']

  @Consume('travelPathStack') travelPathStack:NavPathStack

  build() {
    NavDestination(){
      Stack(){
        Image($r('app.media.poetryBackground'))
        Grid(){
          ForEach(this.list,(item:string)=>{
            GridItem(){
              this.itemBuilder(item)
            }
          })
        }
        .margin({top:60})
        .columnsTemplate('1fr 1fr')
        .columnsGap(10)
        .width('100%')
        .height('100%')
        .rowsGap(20)
      }
    }
    .hideTitleBar(true)
  }
  @Builder
  itemBuilder(item:string){
    Row(){
      Text(item)
        .fontColor(Color.Black)
        .fontSize(24)
    }
    .onClick(()=>{
      let s:string =transChinese(item)
      console.debug('转化后的拼音是：'+s)
      this.travelPathStack.pushPathByName(`${s}`+'Details',new Object({
        param:item
      }))
    })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width(120)
    .height(30)
    .backgroundColor('#aaf5f5b7')
    .borderRadius(30)


  }
}
function transChinese(s:string):string{
  let transliterator1 = i18n.Transliterator.getInstance('Any-Latn');
  let res = transliterator1.transform(s);

  let transliterator2 = i18n.Transliterator.getInstance('Latin-ASCII');
  let res2 = transliterator2.transform(res);


  return removeSpacesAndWhitespace(res2)

}
function removeSpacesAndWhitespace(str: string): string {
  return str.replace(/\s+/g, '');
}

import { MasterpieceI, tsetMasterPieceIArr } from "../model/MasterpieceI";

@Preview
@Component
export struct  CulturalPage{
  @Provide('culturePathStack') culturePathStack: NavPathStack = new NavPathStack();

  MasterpieceIArr: MasterpieceI[] = tsetMasterPieceIArr()

  build() {
    Navigation(this.culturePathStack){
        Column({space:15}){
                  Text('文化天地')
                    .fontSize($r('app.float.large_text_size'))
            ForEach(this.MasterpieceIArr,(item:MasterpieceI)=>{

                Row(){
                  Text(item.id)
                    .fontSize($r('app.float.title_text_size'))
                }
                .onClick(()=>{
                  this.culturePathStack.pushPathByName(item.path,null)
                })
                .backgroundColor($r('app.color.poetry_background'))
                .justifyContent(FlexAlign.Center)
                .height(60)
                .width('90%')
                .borderRadius(20)



            })

        }
        .height('90%')
        .width('100%')
        .alignItems(HorizontalAlign .Center)
        .justifyContent(FlexAlign.SpaceEvenly)
    }

  }
}
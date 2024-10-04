interface classification {
  category: string;
  image: Resource;
}

interface color{
  color: Color | string;
}

export const colorList: color[] = [
  {
    color: Color.Green
  },
  {
    color: '#ff578be2'
  },
  {
    color: Color.Orange
  },
  {
    color: Color.Pink
  },
  {
    color: '#ffcabd44'
  }
]

export const classificationList: classification[] = [
  {
    category: '景点门票',
    image: $r('app.media.class_1')
  },
  {
    category: '必游榜单',
    image: $r('app.media.class_2')
  },
  {
    category: '动植物园',
    image: $r('app.media.class_3')
  },
  {
    category: '著名遗迹',
    image: $r('app.media.class_4')
  },
  {
    category: '一日游玩',
    image: $r('app.media.class_5')
  }
]

@Component
export struct Classification {
  build() {
    //景点分类
    Row() {
      ForEach(classificationList, (item:classification, index) => {
        ListItem(){
          this.myClassBuilder(item, index)
        }
      })
    }
    .width('100%')
    .height(100)
    .backgroundColor(Color.White)
  }

  @Builder myClassBuilder(item: classification, index:number){
    Column({space:5}){
      Column(){
        Image(item.image)
          .width(30)
          .height(30)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width(40)
      .borderRadius(50)
      .height(40)
      .backgroundColor(colorList[index].color)

      Text(item.category)
        .fontSize(14)
        .margin({left:10,top:10})
        .width('100%')
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width(70)
    .height(70)
  }
}
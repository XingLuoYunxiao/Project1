import { Attraction } from "../model/Attraction";


const  myMap: Map<string,string> = new Map();



@Component
export struct AttractionDetailPage {
  @State attraction: Attraction = new Attraction(1, "null", $r("app.media.attraction_1"));
  @Consume('travelPathStack') travelPathStack: NavPathStack;
  @State  myScale: number = 1
  @State voice: boolean = false;



  aboutToAppear(): void {
    myMap.set("故宫", "午门进入 → 太和门广场 → 太和殿（金銮殿）→ 中和殿（皇帝更衣处）→ 保和殿（宴会和科举考场）→ 乾清宫（皇帝寝宫）→ 交泰殿（皇后生日庆典）→ 坤宁宫（皇后寝宫）→ 御花园（皇家园林）→ 珍宝馆（展示皇家珍宝）→ 天穹宝殿 → 宁寿宫（乾隆退位后居住）→ 神武门出");
    myMap.set("秦始皇陵", "陵园入口 → 1号兵马俑坑（规模最大）→ 2号兵马俑坑（战车陈列）→ 3号兵马俑坑（指挥中心）→ 铜车马展厅（展示两辆青铜马车）→ 秦始皇陵封土堆远观 → 丽山园（模拟考古区）");
    myMap.set("长城", "入口 → 箭楼（关口）→ 北一楼（烽火台）→ 北二楼（烽火台，观赏长城全景）→ 北三楼（烽火台，较为陡峭）→ 北四楼（烽火台）→ 北五楼（烽火台，重要军事位置）→ 北六楼（烽火台）→ 北七楼（烽火台）→ 北八楼（最高点，好汉坡）→ 返回途中可选爬南长城");
    myMap.set("敦煌莫高窟", "数字展示中心（观看介绍影片）→ 乘坐景区交通车 → 莫高窟窟区 → 参观主要洞窟（如96窟、130窟、148窟）→ 特窟参观（需额外购票）→ 藏经洞（发现大量文献的地方）→ 莫高窟博物馆（了解莫高窟的历史和艺术）");
    myMap.set("乐山大佛", "山门 → 钟鼓楼 → 凌云寺（佛教圣地）→ 九曲栈道（下至大佛脚部，途中可欣赏壁雕）→ 大佛脚部平台（近距离观赏大佛）→ 重新沿九曲栈道返回 → 苏园（江南园林风格）→ 乌尤寺（观赏乐山全景）");
    myMap.set("颐和园", "东宫门进入 → 苏州街（模仿江南水乡）→ 买卖街（古商业街）→ 长廊（画廊，欣赏壁画）→ 排云殿（慈禧祝寿的地方）→ 佛香阁（俯瞰整个园林）→ 宜芸馆（皇家书屋）→ 德和园（大戏楼）→ 昆明湖（划船或环湖散步）→ 十七孔桥（连接东岸和南湖岛）→ 铜牛（昆明湖畔的铜像）");
    myMap.set("天坛", "南门进入 → 圜丘坛（冬至祭天的地方）→ 回音壁（声学奇迹）→ 祈年殿（祈求丰收的地方）→ 祈年门 → 长廊（连接祈年殿和皇穹宇）→ 丹陛桥（连接祈年殿和皇穹宇的砖石桥）→ 斋宫（皇帝祭天前斋戒的地方）→ 北门出");

    this.attraction = this.travelPathStack.getParamByName('AttractionDetailPage')[0] as Attraction;
  }

  build() {
    NavDestination(){
      Column() {
        Row(){
          Image($r('app.media.ic_back'))
            .width(30)
            .height(30)
            .onClick( () => {
              this.travelPathStack.pop();
            })
          Row(){
            Text(this.attraction.name)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .margin({right:15})
            Blank()
            if( this.voice === false){
              Image($r('app.media.voice_close'))
                .width(30)
                .height(30)
                .margin({left:15})
                .onClick( () => {
                  this.voice = true;
                })
            }else{
              Image($r('app.media.voice_open'))
                .width(30)
                .height(30)
                .margin({left:15})
                .onClick( () => {
                  this.voice = false;
                })
            }
          }
          .padding(5)
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)

        Image($r('app.media.gugong_map'))
          .width('100%')
          .height(300)
          .borderRadius(10)
          .margin({top:10})
          .onClick( () => {
            this.travelPathStack.pushPathByName('MapDemo', true);
          })

        Column(){
          Text('路径规划')
            .fontSize(24)
            .fontColor(Color.White)
            .backgroundColor(Color.Orange)
            .borderRadius(10)
            .padding(5)
            .margin({top:10})
          Text(myMap.get(this.attraction.name))
            .fontSize(18)
            .width('90%')
            .margin({top:5})
            .backgroundColor(Color.White)
        }
        .alignItems(HorizontalAlign.Start)
        .backgroundColor(Color.White)


        /*Column(){
          Image($r('app.media.avator'))
            .width(100)
            .height(150)
            .objectFit(ImageFit.Contain)
            .opacity(0.8)
            .scale({ x: this.myScale, y: this.myScale })
        }
        .position({x:270, y:550})*/
      }
      .width('95%')
      .height('100%')
      //.backgroundColor('#ffdee7ee')
    }
    .hideTitleBar(true)
  }
}

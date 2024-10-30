export class paintingData {
  name: string = ''; //画作名称
  type: string = ''; // 画种类型
  author: string = ''; //作者
  authorDynasty: string = '' //作者的朝代
  explain: string = '' //对画作的讲解
  path: ResourceStr = '' // 文件路径，我自己写
}

export const shanshuiList: paintingData[] = [
  {
    name: "潇湘图",
    type: "山水画",
    author: "董源",
    authorDynasty: '五代·南唐',
    explain: "潇湘”指湖南省境内的潇河与湘江，二水汇入洞庭湖，“潇湘”也泛指江南河湖密布的地区。图绘一片湖光山色，山势平缓连绵，大片的水面中沙洲苇渚映带无尽。画面中以水墨间杂淡色，山峦多运用点子皴法，几乎不见线条，以墨点表现远山的植被，塑造出模糊而富有质感的山型轮廓。墨点的疏密浓淡，表现了山石的起伏凹凸。画家在作水墨渲染时留出些许空白，营造云雾迷濛之感，山林深蔚，烟水微茫。山水之中又有人物渔舟点缀其间，赋色鲜明，刻画入微，为寂静幽深的山林增添了无限生机。",
    path: $r("app.media.painting_xiaoxiang")
  },
  {
    name: "富春山居图",
    type: "山水画",
    author: "黄公望",
    authorDynasty: "元",
    explain: "《富春山居图》以江南水乡的自然风光为题材，描绘了富春江两岸绵延起伏的山峦、静谧清新的湖泊以及散落的村舍。画面采用水墨结合的技法，以简洁淡雅的笔触描绘出江南山水的秀丽之美，墨色的浓淡、线条的粗细相互配合，形成一种淡雅、和谐的自然之境。整幅画作充满了山水之间的宁静与自由，画家用笔意流畅，气韵生动，将山水意境表现得淋漓尽致，呈现了元代山水画的高峰。",
    path: $r("app.media.painting_fuchunshanju")
  },
  {
    name: "千里江山图",
    type: "山水画",
    author: "王希孟",
    authorDynasty: "北宋",
    explain: "《千里江山图》是一幅绢本设色画卷，以青绿山水为主，描绘了广阔而壮丽的山河景象。画面中连绵起伏的山峦、奔腾的江水以及郁郁葱葱的植被，展现了千里江山的宏大气魄。画家以鲜明的青绿色调渲染山水，笔触细腻流畅，线条劲健有力，表现出山川壮阔的美感。此画既具有写实的细节描绘，又充满了浪漫的想象，展示了北宋时期的绘画技术及画家对自然的观察和热爱。",
    path: $r('app.media.painting_qianlijiangshangtu')
  }
]

export const figureList: paintingData[] = [
  {
    name: "虢国夫人游春图",
    type: "人物画",
    author: "张萱",
    authorDynasty: "唐",
    explain: "《虢国夫人游春图》描绘了唐代贵妇游春踏青的场景，虢国夫人坐于一匹高头大马上，身边围绕着侍女和仆从，构成一幅精致的贵族出游画面。画中人物衣饰华丽、神态自然，描绘精细，展现了唐代宫廷人物画的高超技艺。张萱运用了精细的勾勒和丰富的设色技巧，使得人物形象富有立体感，同时体现了唐代女性雍容华贵的气质。",
    path: $r('app.media.painting_guoguofuren')
  },
  {
    name: "洛神赋图",
    type: "人物画",
    author: "顾恺之",
    authorDynasty: "东晋",
    explain: "《洛神赋图》是东晋画家顾恺之依据曹植的《洛神赋》所创作的名作，画中以细腻的线条和柔和的设色表现了洛神出水而游于河畔的场景。顾恺之通过流畅的线条勾画人物形象，赋予其飘逸的神态和姿态，使人物具备神韵且极具生命力。同时，顾恺之在背景中细致描绘出湖水、山石、树木等自然景物，与洛神形象相映成趣，表现了人物和自然和谐相处的意境。",
    path: $r('app.media.painting_luoshenfu')
  },
  {
    name: "韩熙载夜宴图",
    type: "人物画",
    author: "顾闳中",
    authorDynasty: "五代·南唐",
    explain: "《韩熙载夜宴图》是五代南唐画家顾闳中受李后主之命所绘，以五段场景描绘了韩熙载在家中宴请宾客的情景。整幅画作不仅描写了宴会中的乐师、舞女、宾客和侍从等众多人物形象，还展现了五代人物画中对细节的关注，尤其是在面部表情和动态姿态的刻画上，具有强烈的现实主义色彩。画面层次分明、人物生动，展示了韩熙载复杂的心理状态以及当时社会生活的场景。",
    path: $r('app.media.painting_hanxizaiyeyan')
  }
]

export const FlowerBirdsList: paintingData[] = [
  {
    name: "写生珍禽图",
    type: "花鸟画",
    author: "张大千",
    authorDynasty: "现代",
    explain: "《写生珍禽图》描绘了多种珍禽，展现了作者细致入微的写生技艺。画面生动，色彩丰富，体现了对自然的热爱与对生命的深刻观察。",
    path: $r('app.media.painting_xieshengzhenqintu')
  },

  {
    name: "山鹧棘雀图",
    type: "花鸟画",
    author: "仇英",
    authorDynasty: "明",
    explain: "《山鹧棘雀图》描绘了山鹧与雀鸟栖息在棘枝上的场景，表现了自然中的和谐美。画面细腻，体现了作者对鸟类的深厚情感与自然的细致观察。",
    path: $r('app.media.painting_shanzhejijue')
  },
  {
    name: "春溪水族图",
    type: "花鸟画",
    author: "未知",
    authorDynasty: "明",
    explain: "《春溪水族图》描绘了春天的溪水与水中生物，展现了生机勃勃的自然景象。画中流畅的水流与活泼的水族，传达了春天的气息与生命的活力。",
    path: $r('app.media.painting_chunxishuizutu')
  },
  {
    name: "梅石水仙图",
    type: "花鸟画",
    author: "陆治",
    authorDynasty: "明",
    explain: "《梅石水仙图》是明代画家陆治的作品，图中描绘了一株盛开的梅花、一块奇石和水仙花。作品通过细腻的笔触和丰富的色彩展示了自然界的美景，同时也蕴含着文人画的意境和情趣。此画作不仅反映了陆治高超的艺术技巧，也体现了他对于自然景物深入的理解和独特的审美观。",
    path: $r('app.media.painting_meishishuixian') // 请替换为实际的图片路径或URL
  }
]

export const InkPaintingList: paintingData[] = [
  {
    name: "泼墨仙人图",
    type: "水墨画",
    author: "梁楷",
    authorDynasty: "五代",
    explain: "《泼墨仙人图》是五代画家梁楷的经典水墨画作。画中使用泼墨技法，表现出潇洒不拘的风格，具有浓厚的写意风格和独特的艺术张力。",
    path: $r('app.media.painting_pomoxianren') // 请替换为实际的图片路径或URL
  },
  {
    name: "墨竹图",
    type: "水墨画",
    author: "文同",
    authorDynasty: "南宋",
    explain: "《墨竹图》展现了文同对竹子的深刻观察与热爱，笔法细腻，墨色层次分明，给人一种宁静而坚韧的气质，是中国水墨画的典范。",
    path: $r('app.media.painting_mozhu') // 请替换为实际的图片路径或URL
  },
  {
    name: "溪山行旅图",
    type: "水墨画",
    author: "范宽",
    authorDynasty: "北宋",
    explain: "《溪山行旅图》以浓淡墨色描绘了北方的山川景观，展现出自然的壮丽。画作整体气势宏大，构图精妙，是北宋山水画的杰作。",
    path: $r("app.media.painting_xishanxinglv") // 请替换为实际的图片路径或URL
  },
  {
    name: "富春山居图",
    type: "水墨画",
    author: "黄公望",
    authorDynasty: "元代",
    explain: "《富春山居图》通过墨色的层次变化，描绘出江南的山水之美。作品表现出闲适的生活意趣，具有浓郁的文人气息。",
    path: $r("app.media.painting_fuchunshanju") // 请替换为实际的图片路径或URL
  },
  {
    name: "潇湘图",
    type: "水墨画",
    author: "米芾",
    authorDynasty: "北宋",
    explain: "《潇湘图》采用米点山水技法，画中点状墨迹营造出云雾缭绕的效果，表现出山水的朦胧之美，是宋代水墨画中的重要作品。",
    path: $r('app.media.painting_xiaoxiang') // 请替换为实际的图片路径或URL
  }
]

export const shinvList: paintingData[] = [
  {
    name: "簪花仕女图",
    type: "仕女图",
    author: "周昉",
    authorDynasty: "唐代",
    explain: "《簪花仕女图》表现了唐代贵族女子佩戴花饰的形象，线条流畅，衣纹精致，突显出仕女的雍容华贵，展示了盛唐时期的风采。",
    path: $r('app.media.painting_zanhuashinv') // 请替换为实际的图片路径或URL
  },

  {
    name: "贵妃上马图",
    type: "仕女图",
    author: "周昉",
    authorDynasty: "唐代",
    explain: "《贵妃上马图》描绘了杨贵妃骑马的瞬间，画面流畅自然，仕女神态柔美，展示了唐代仕女的优雅仪态。",
    path: $r('app.media.painting_guifeishangma') // 请替换为实际的图片路径或URL
  },
  {
    name: "挥扇仕女图",
    type: "仕女图",
    author: "周昉",
    authorDynasty: "唐代",
    explain: "《挥扇仕女图》描绘了唐代贵族女子挥扇纳凉的场景，仕女的形象端庄优雅，衣纹流畅，表现出唐代仕女的高贵气质。",
    path: $r('app.media.painting_huishansinv') // 请替换为实际的图片路径或URL
  },

];

export const HaipaiPaintingList: paintingData[] = [
  {
    name: "鱼虾图",
    type: "海派画",
    author: "齐白石",
    authorDynasty: "民国",
    explain: "《鱼虾图》以细腻的笔触描绘了鱼虾的生动形态，色彩鲜艳，展现了齐白石对自然生物的深刻观察和表现力，是海派画的经典作品。",
    path: $r('app.media.painting_yuxia') // 请替换为实际的图片路径或URL
  },

  {
    name: "百花争艳",
    type: "海派画",
    author: "徐悲鸿",
    authorDynasty: "民国",
    explain: "《百花争艳》通过丰富的色彩表现了各种花卉的生机，笔法灵活多变，体现了海派画在花鸟题材上的独特魅力。",
    path: $r('app.media.painting_baihuazhengyan') // 请替换为实际的图片路径或URL
  },

  {
    name: "牡丹图",
    type: "海派画",
    author: "齐白石",
    authorDynasty: "民国",
    explain: "《牡丹图》以鲜艳的色彩和生动的构图描绘了盛开的牡丹，象征富贵和繁荣，体现了海派画的色彩运用和形式美。",
    path: $r('app.media.painting_mudan') // 请替换为实际的图片路径或URL
  },
  {
    name: "群鱼戏水",
    type: "海派画",
    author: "齐白石",
    authorDynasty: "民国",
    explain: "《群鱼戏水》通过生动的构图和鲜艳的色彩展现了鱼儿在水中嬉戏的场景，传达出活泼的生命力。",
    path: $r('app.media.painting_qunyu') // 请替换为实际的图片路径或URL
  }
];



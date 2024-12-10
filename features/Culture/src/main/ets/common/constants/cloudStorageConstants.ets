export class CloudStorageConstants {
  static readonly dirPath: string = "culture";
  // Original map with all constants
  static readonly constantsMap: Map<string, string> = new Map([
    ['artPageBackground', 'artPageBackground.png'],
    ['calligraphy_background', 'calligraphy_background.png'],
    ['painting_background', 'painting_background.png']
  // ... 其他非 calligraphy 或 painting 的条目
  ]);
  // Map containing only calligraphy-related constants
  static readonly calligraphyMap: Map<string, string> = new Map([
    ['calligraphy_chaoshu', 'calligraphy_chaoshu.png'],
    ['calligraphy_jiajuewen', 'calligraphy_jiajuewen.png'],
    ['calligraphy_jinwen', 'calligraphy_jinwen.png'],
    ['calligraphy_kaishu', 'calligraphy_kaishu.png'],
    ['calligraphy_lishu', 'calligraphy_lishu.png'],
    ['calligraphy_xingshu', 'calligraphy_xingshu.png'],
    ['calligraphy_zhuanshu', 'calligraphy_zhuanshu.png'],
    ['calligraphy_background', 'calligraphy_background.png']// 包含了背景图片
  ]);
  // Map containing only painting-related constants
  static readonly paintingMap: Map<string, string> = new Map([
    ['painting_baihuazhengyan', 'painting_baihuazhengyan.png'],
    ['painting_chunxishuizutuan', 'painting_chunxishuizutuan.png'],
    ['painting_fuchunshanju', 'painting_fuchunshanjutu.png'],
    ['painting_guihaishanqima', 'painting_guihaishanqima.png'],
    ['painting_guoguoqiuren', 'painting_guoguoqiuren.png'],
    ['painting_hanxizaiyeyan', 'painting_hanxizaiyeyan.png'],
    ['painting_huishanshanyu', 'painting_huishanshanyu.png'],
    ['painting_luoshenfu', 'painting_luoshenfu.png'],
    ['painting_meishishuxianji', 'painting_meishishuxianji.png'],
    ['painting_mozhu', 'painting_mozhu.png'],
    ['painting_mudan', 'painting_mudan.png'],
    ['painting_pomojianren', 'painting_pomojianren.png'],
    ['painting_qianlijiangshangtu', 'painting_qianlijiangshangtu.png'],
    ['painting_qunyu', 'painting_qunyu.png'],
    ['painting_shanzhejiuren', 'painting_shanzhejiuren.png'],
    ['painting_title', 'painting_title.png'],
    ['painting_taoxiangpupng', 'painting_taoxiangpupng'],
    ['painting_xieshengzhengqu', 'painting_xieshengzhengqu.png'],
    ['painting_xishanxinglv', 'painting_xishanxinglv.png'],
    ['painting_yuxia', 'painting_yuxia.png'],
    ['painting_zanhuaqishi', 'painting_zanhuaqishi.png'],
    ['painting_background', 'painting_background.png']
  ]);
  static imageFilenames: string[] = [
    "painting/baihuazhengyan.png",
    "painting/chunxishuizutu.png",
    "painting/fuchunshanju.png",
    "painting/guifeishangma.png",
    "painting/guoguofuren.png",
    "painting/hanxizaiyeyan.png",
    "painting/huishansinv.png",
    "painting/luoshenfu.png",
    "painting/meishishuixian.png",
    "painting/mozhu.png",
    "painting/mudan.png",
    "painting/pomoxianren.png",
    "painting/qianlijiangshang.png",
    "painting/qunyu.png",
    "painting/shanzhejijue.png",
    "painting/title.png",
    "painting/xiaoxiang.png",
    "painting/xieshengzhenqintu.png",
    "painting/xishanxinglv.png",
    "painting/yuxia.png",
    "painting/zanhuashinv.png"
  ];

  static getConstant(key: string): string | undefined {

    return CloudStorageConstants.constantsMap.get(key);
  }

  static getCalligraphyConstant(key: string): string | undefined {
    return CloudStorageConstants.calligraphyMap.get(key);
  }

  static getPaintingConstant(key: string): string | undefined {
    return CloudStorageConstants.paintingMap.get(key);
  }
}
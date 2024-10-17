if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { Attraction } from '@bundle:com.example.ictproject/Travel/ets/model/Attraction';
<<<<<<< HEAD
const myMap = new Map();
=======
>>>>>>> origin/zmx
export class AttractionDetailPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__attraction = new ObservedPropertyObjectPU(new Attraction(1, "null", { "id": 83886222, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "Travel" }), this, "attraction");
        this.__travelPathStack = this.initializeConsume('travelPathStack', "travelPathStack");
<<<<<<< HEAD
        this.__myScale = new ObservedPropertySimplePU(1, this, "myScale");
        this.__voice = new ObservedPropertySimplePU(false, this, "voice");
=======
>>>>>>> origin/zmx
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.attraction !== undefined) {
            this.attraction = params.attraction;
        }
<<<<<<< HEAD
        if (params.myScale !== undefined) {
            this.myScale = params.myScale;
        }
        if (params.voice !== undefined) {
            this.voice = params.voice;
        }
=======
>>>>>>> origin/zmx
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__attraction.purgeDependencyOnElmtId(rmElmtId);
        this.__travelPathStack.purgeDependencyOnElmtId(rmElmtId);
<<<<<<< HEAD
        this.__myScale.purgeDependencyOnElmtId(rmElmtId);
        this.__voice.purgeDependencyOnElmtId(rmElmtId);
=======
>>>>>>> origin/zmx
    }
    aboutToBeDeleted() {
        this.__attraction.aboutToBeDeleted();
        this.__travelPathStack.aboutToBeDeleted();
<<<<<<< HEAD
        this.__myScale.aboutToBeDeleted();
        this.__voice.aboutToBeDeleted();
=======
>>>>>>> origin/zmx
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get attraction() {
        return this.__attraction.get();
    }
    set attraction(newValue) {
        this.__attraction.set(newValue);
    }
    get travelPathStack() {
        return this.__travelPathStack.get();
    }
    set travelPathStack(newValue) {
        this.__travelPathStack.set(newValue);
    }
<<<<<<< HEAD
    get myScale() {
        return this.__myScale.get();
    }
    set myScale(newValue) {
        this.__myScale.set(newValue);
    }
    get voice() {
        return this.__voice.get();
    }
    set voice(newValue) {
        this.__voice.set(newValue);
    }
    aboutToAppear() {
        myMap.set("故宫", "午门进入 → 太和门广场 → 太和殿（金銮殿）→ 中和殿（皇帝更衣处）→ 保和殿（宴会和科举考场）→ 乾清宫（皇帝寝宫）→ 交泰殿（皇后生日庆典）→ 坤宁宫（皇后寝宫）→ 御花园（皇家园林）→ 珍宝馆（展示皇家珍宝）→ 天穹宝殿 → 宁寿宫（乾隆退位后居住）→ 神武门出");
        myMap.set("秦始皇陵", "陵园入口 → 1号兵马俑坑（规模最大）→ 2号兵马俑坑（战车陈列）→ 3号兵马俑坑（指挥中心）→ 铜车马展厅（展示两辆青铜马车）→ 秦始皇陵封土堆远观 → 丽山园（模拟考古区）");
        myMap.set("长城", "入口 → 箭楼（关口）→ 北一楼（烽火台）→ 北二楼（烽火台，观赏长城全景）→ 北三楼（烽火台，较为陡峭）→ 北四楼（烽火台）→ 北五楼（烽火台，重要军事位置）→ 北六楼（烽火台）→ 北七楼（烽火台）→ 北八楼（最高点，好汉坡）→ 返回途中可选爬南长城");
        myMap.set("敦煌莫高窟", "数字展示中心（观看介绍影片）→ 乘坐景区交通车 → 莫高窟窟区 → 参观主要洞窟（如96窟、130窟、148窟）→ 特窟参观（需额外购票）→ 藏经洞（发现大量文献的地方）→ 莫高窟博物馆（了解莫高窟的历史和艺术）");
        myMap.set("乐山大佛", "山门 → 钟鼓楼 → 凌云寺（佛教圣地）→ 九曲栈道（下至大佛脚部，途中可欣赏壁雕）→ 大佛脚部平台（近距离观赏大佛）→ 重新沿九曲栈道返回 → 苏园（江南园林风格）→ 乌尤寺（观赏乐山全景）");
        myMap.set("颐和园", "东宫门进入 → 苏州街（模仿江南水乡）→ 买卖街（古商业街）→ 长廊（画廊，欣赏壁画）→ 排云殿（慈禧祝寿的地方）→ 佛香阁（俯瞰整个园林）→ 宜芸馆（皇家书屋）→ 德和园（大戏楼）→ 昆明湖（划船或环湖散步）→ 十七孔桥（连接东岸和南湖岛）→ 铜牛（昆明湖畔的铜像）");
        myMap.set("天坛", "南门进入 → 圜丘坛（冬至祭天的地方）→ 回音壁（声学奇迹）→ 祈年殿（祈求丰收的地方）→ 祈年门 → 长廊（连接祈年殿和皇穹宇）→ 丹陛桥（连接祈年殿和皇穹宇的砖石桥）→ 斋宫（皇帝祭天前斋戒的地方）→ 北门出");
=======
    aboutToAppear() {
>>>>>>> origin/zmx
        this.attraction = this.travelPathStack.getParamByName('AttractionDetailPage')[0];
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            NavDestination.create(() => {
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
<<<<<<< HEAD
                    Column.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(30:7)", "travel");
=======
                    Column.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(14:7)", "travel");
>>>>>>> origin/zmx
                    Column.width('95%');
                    Column.height('100%');
                }, Column);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Row.create();
<<<<<<< HEAD
                    Row.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(31:9)", "travel");
=======
                    Row.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(15:9)", "travel");
>>>>>>> origin/zmx
                    Row.width('100%');
                    Row.justifyContent(FlexAlign.Start);
                }, Row);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Image.create({ "id": 83886088, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "Travel" });
<<<<<<< HEAD
                    Image.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(32:11)", "travel");
=======
                    Image.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(16:11)", "travel");
>>>>>>> origin/zmx
                    Image.width(30);
                    Image.height(30);
                    Image.onClick(() => {
                        this.travelPathStack.pop();
                    });
                }, Image);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Row.create();
<<<<<<< HEAD
                    Row.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(38:11)", "travel");
=======
                    Row.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(22:11)", "travel");
>>>>>>> origin/zmx
                    Row.layoutWeight(1);
                    Row.justifyContent(FlexAlign.Center);
                }, Row);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create(this.attraction.name);
<<<<<<< HEAD
                    Text.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(39:13)", "travel");
=======
                    Text.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(23:13)", "travel");
>>>>>>> origin/zmx
                    Text.fontSize(20);
                    Text.fontWeight(FontWeight.Bold);
                    Text.margin({ right: 15 });
                }, Text);
                Text.pop();
<<<<<<< HEAD
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Blank.create();
                    Blank.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(43:13)", "travel");
                }, Blank);
                Blank.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    If.create();
                    if (this.voice === false) {
                        this.ifElseBranchUpdateFunction(0, () => {
                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                Image.create({ "id": 33554446, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "Travel" });
                                Image.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(45:15)", "travel");
                                Image.width(30);
                                Image.height(30);
                                Image.margin({ left: 15 });
                                Image.onClick(() => {
                                    this.voice = true;
                                });
                            }, Image);
                        });
                    }
                    else {
                        this.ifElseBranchUpdateFunction(1, () => {
                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                Image.create({ "id": 33554445, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "Travel" });
                                Image.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(53:15)", "travel");
                                Image.width(30);
                                Image.height(30);
                                Image.margin({ left: 15 });
                                Image.onClick(() => {
                                    this.voice = false;
                                });
                            }, Image);
                        });
                    }
                }, If);
                If.pop();
                Row.pop();
                Row.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Image.create({ "id": 33554444, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "Travel" });
                    Image.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(69:9)", "travel");
                    Image.width('100%');
                    Image.height(300);
                    Image.borderRadius(10);
                }, Image);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
                    Column.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(74:9)", "travel");
                    Column.alignItems(HorizontalAlign.Start);
                    Column.backgroundColor(Color.White);
                }, Column);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create('路径规划');
                    Text.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(75:11)", "travel");
                    Text.fontSize(24);
                    Text.fontColor(Color.White);
                    Text.backgroundColor(Color.Orange);
                    Text.borderRadius(10);
                    Text.padding(5);
                    Text.margin({ top: 10 });
                }, Text);
                Text.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create(myMap.get(this.attraction.name));
                    Text.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(82:11)", "travel");
                    Text.fontSize(18);
                    Text.width('90%');
                    Text.margin({ top: 5 });
                    Text.backgroundColor(Color.White);
                }, Text);
                Text.pop();
                Column.pop();
                Column.pop();
            }, { moduleName: "Travel", pagePath: "features/Travel/src/main/ets/pages/AttractionDetailPage" });
            NavDestination.hideTitleBar(true);
            NavDestination.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(29:5)", "travel");
=======
                Row.pop();
                Row.pop();
                Column.pop();
            }, { moduleName: "Travel", pagePath: "features/Travel/src/main/ets/pages/AttractionDetailPage" });
            NavDestination.hideTitleBar(true);
            NavDestination.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(13:5)", "travel");
>>>>>>> origin/zmx
        }, NavDestination);
        NavDestination.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=AttractionDetailPage.js.map
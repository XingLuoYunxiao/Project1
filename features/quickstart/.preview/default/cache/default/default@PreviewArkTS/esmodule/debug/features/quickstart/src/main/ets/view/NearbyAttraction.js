if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { Attraction } from '@bundle:com.example.ictproject/quickstart/ets/model/Attraction';
//西安附近的景点，要有简介
const nearbyAttractions = [
    new Attraction(4, "秦始皇兵马俑博物馆", { "id": 83886092, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "quickstart" }, "秦始皇兵马俑博物馆位于陕西省西安市，是中国最著名的考古遗址之一，展示了秦始皇的陵墓及其壮观的兵马俑军队。"),
    new Attraction(5, "大雁塔", { "id": 83886093, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "quickstart" }, "大雁塔是唐代著名的佛塔，位于陕西省西安市，是玄奘法师为保存从印度带回的佛经而建。"),
    new Attraction(6, "西安城墙", { "id": 83886097, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "quickstart" }, "西安城墙是中国现存规模最大、保存最完整的古代城垣，是明代初年在唐长安城的基础上扩建而成的。"),
    new Attraction(7, "钟楼", { "id": 83886094, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "quickstart" }, "钟楼位于西安市中心，是明代建筑的典范，历史上用于晨钟暮鼓，现在是西安的标志性建筑之一。"),
    new Attraction(3, "大唐不夜城", { "id": 83886081, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "quickstart" }, "大唐不夜城位于陕西省西安市，是一个集文化、旅游、商业于一体的综合性旅游景区，以唐代皇家园林为主题，展现了盛唐时期的繁荣景象。"),
];
//定义一个景点距离数组
const distances = [
    12.2, 5.1, 36.6, 17.2, 49.8
];
export class NearbyAttraction extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("features/quickstart/src/main/ets/view/NearbyAttraction.ets(21:5)", "quickstart");
            Column.alignItems(HorizontalAlign.Start);
            Column.width('100%');
            Column.height('100%');
            Column.layoutWeight(1);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('附近景点');
            Text.debugLine("features/quickstart/src/main/ets/view/NearbyAttraction.ets(22:7)", "quickstart");
            Text.fontSize(18);
            Text.padding({ top: 10 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            /*List() {
      
            }
            .edgeEffect(EdgeEffect.Spring, {alwaysEnabled:true})
            .scrollBar(BarState.Off)
            .width('100%')
            .height('100%')
            .listDirection(Axis.Vertical)
            .layoutWeight(1)*/
            Scroll.create();
            Scroll.debugLine("features/quickstart/src/main/ets/view/NearbyAttraction.ets(34:7)", "quickstart");
            /*List() {
      
            }
            .edgeEffect(EdgeEffect.Spring, {alwaysEnabled:true})
            .scrollBar(BarState.Off)
            .width('100%')
            .height('100%')
            .listDirection(Axis.Vertical)
            .layoutWeight(1)*/
            Scroll.scrollable(ScrollDirection.Vertical);
            /*List() {
      
            }
            .edgeEffect(EdgeEffect.Spring, {alwaysEnabled:true})
            .scrollBar(BarState.Off)
            .width('100%')
            .height('100%')
            .listDirection(Axis.Vertical)
            .layoutWeight(1)*/
            Scroll.scrollBar(BarState.Off);
            /*List() {
      
            }
            .edgeEffect(EdgeEffect.Spring, {alwaysEnabled:true})
            .scrollBar(BarState.Off)
            .width('100%')
            .height('100%')
            .listDirection(Axis.Vertical)
            .layoutWeight(1)*/
            Scroll.width('100%');
            /*List() {
      
            }
            .edgeEffect(EdgeEffect.Spring, {alwaysEnabled:true})
            .scrollBar(BarState.Off)
            .width('100%')
            .height('100%')
            .listDirection(Axis.Vertical)
            .layoutWeight(1)*/
            Scroll.layoutWeight(1);
        }, Scroll);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("features/quickstart/src/main/ets/view/NearbyAttraction.ets(35:9)", "quickstart");
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = (_item, index) => {
                const item = _item;
                {
                    const itemCreation = (elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        itemCreation2(elmtId, isInitialRender);
                        if (!isInitialRender) {
                            ListItem.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    };
                    const itemCreation2 = (elmtId, isInitialRender) => {
                        ListItem.create(deepRenderFunction, true);
                        ListItem.debugLine("features/quickstart/src/main/ets/view/NearbyAttraction.ets(37:13)", "quickstart");
                    };
                    const deepRenderFunction = (elmtId, isInitialRender) => {
                        itemCreation(elmtId, isInitialRender);
                        this.NearbyItem.bind(this)(item, distances[index]);
                        ListItem.pop();
                    };
                    this.observeComponentCreation2(itemCreation2, ListItem);
                    ListItem.pop();
                }
            };
            this.forEachUpdateFunction(elmtId, nearbyAttractions, forEachItemGenFunction, undefined, true, false);
        }, ForEach);
        ForEach.pop();
        Column.pop();
        /*List() {
  
        }
        .edgeEffect(EdgeEffect.Spring, {alwaysEnabled:true})
        .scrollBar(BarState.Off)
        .width('100%')
        .height('100%')
        .listDirection(Axis.Vertical)
        .layoutWeight(1)*/
        Scroll.pop();
        Column.pop();
    }
    NearbyItem(attraction, index, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.debugLine("features/quickstart/src/main/ets/view/NearbyAttraction.ets(57:5)", "quickstart");
            Row.borderRadius(10);
            Row.backgroundColor(Color.White);
            Row.height(100);
            Row.width('100%');
            Row.padding(10);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("features/quickstart/src/main/ets/view/NearbyAttraction.ets(58:7)", "quickstart");
            Column.width('40%');
            Column.padding(8);
            Column.alignItems(HorizontalAlign.Center);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create(attraction.image);
            Image.debugLine("features/quickstart/src/main/ets/view/NearbyAttraction.ets(59:9)", "quickstart");
            Image.width('100%');
            Image.height(60);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(attraction.name);
            Text.debugLine("features/quickstart/src/main/ets/view/NearbyAttraction.ets(62:9)", "quickstart");
            Text.fontSize(14);
            Text.padding({ top: 5 });
            Text.fontColor(Color.Black);
            Text.fontWeight(500);
        }, Text);
        Text.pop();
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("features/quickstart/src/main/ets/view/NearbyAttraction.ets(72:7)", "quickstart");
            Column.layoutWeight(1);
            Column.alignItems(HorizontalAlign.End);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(`距离 ${index}km`);
            Text.debugLine("features/quickstart/src/main/ets/view/NearbyAttraction.ets(73:9)", "quickstart");
            Text.fontSize(16);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(attraction.description);
            Text.debugLine("features/quickstart/src/main/ets/view/NearbyAttraction.ets(75:9)", "quickstart");
            Text.fontSize(14);
            Text.padding({ top: 5 });
            Text.fontColor(Color.Gray);
            Text.textOverflow({ overflow: TextOverflow.Ellipsis });
            Text.maxLines(3);
        }, Text);
        Text.pop();
        Column.pop();
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=NearbyAttraction.js.map
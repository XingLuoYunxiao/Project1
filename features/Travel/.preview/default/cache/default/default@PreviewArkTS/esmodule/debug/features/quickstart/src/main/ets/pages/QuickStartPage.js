if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { Attraction } from '@bundle:com.example.ictproject/quickstart/ets/model/Attraction';
import { Classification } from '@bundle:com.example.ictproject/quickstart/ets/view/Classficiation';
import { NearbyAttraction } from '@bundle:com.example.ictproject/quickstart/ets/view/NearbyAttraction';
import { SearchHeader } from '@bundle:com.example.ictproject/quickstart/ets/view/SearchHeader';
export const attractions = [
    new Attraction(1, "长城", { "id": 83886222, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "quickstart" }),
    new Attraction(2, "故宫", { "id": 83886080, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "quickstart" }),
    new Attraction(3, "大唐不夜城", { "id": 83886081, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "quickstart" }),
];
export class QuickStartPage extends ViewPU {
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
            Column.debugLine("features/quickstart/src/main/ets/pages/QuickStartPage.ets(19:5)", "quickstart");
            Column.width('95%');
            Column.height('100%');
            Column.backgroundColor('#F1F3F5');
        }, Column);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new SearchHeader(this, {}, undefined, elmtId, () => { }, { page: "features/quickstart/src/main/ets/pages/QuickStartPage.ets", line: 21, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {};
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
            }, { name: "SearchHeader" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Swiper.create();
            Swiper.debugLine("features/quickstart/src/main/ets/pages/QuickStartPage.ets(23:7)", "quickstart");
            Swiper.autoPlay(true);
            Swiper.loop(true);
            Swiper.indicator(false);
            Swiper.width('100%');
        }, Swiper);
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
                        ListItem.width('100%');
                        ListItem.height(230);
                        ListItem.debugLine("features/quickstart/src/main/ets/pages/QuickStartPage.ets(25:11)", "quickstart");
                    };
                    const deepRenderFunction = (elmtId, isInitialRender) => {
                        itemCreation(elmtId, isInitialRender);
                        this.AttractionItem.bind(this)(item);
                        ListItem.pop();
                    };
                    this.observeComponentCreation2(itemCreation2, ListItem);
                    ListItem.pop();
                }
            };
            this.forEachUpdateFunction(elmtId, attractions, forEachItemGenFunction, undefined, true, false);
        }, ForEach);
        ForEach.pop();
        Swiper.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.padding({ top: 10, bottom: 10 });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new Classification(this, {}, undefined, elmtId, () => { }, { page: "features/quickstart/src/main/ets/pages/QuickStartPage.ets", line: 38, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {};
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
            }, { name: "Classification" });
        }
        __Common__.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.width('100%');
            __Common__.height('100%');
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new NearbyAttraction(this, {}, undefined, elmtId, () => { }, { page: "features/quickstart/src/main/ets/pages/QuickStartPage.ets", line: 41, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {};
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
            }, { name: "NearbyAttraction" });
        }
        __Common__.pop();
        Column.pop();
    }
    AttractionItem(attraction, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create();
            Stack.debugLine("features/quickstart/src/main/ets/pages/QuickStartPage.ets(53:5)", "quickstart");
            Stack.align(Alignment.TopStart);
            Stack.width('100%');
            Stack.backgroundColor(Color.White);
            Stack.borderRadius(10);
            Stack.margin({ top: 10 });
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create(attraction.image);
            Image.debugLine("features/quickstart/src/main/ets/pages/QuickStartPage.ets(55:7)", "quickstart");
            Image.width('100%');
            Image.height(200);
            Image.borderRadius(10);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(attraction.name);
            Text.debugLine("features/quickstart/src/main/ets/pages/QuickStartPage.ets(59:7)", "quickstart");
            Text.fontSize(18);
            Text.padding({ top: 5 });
            Text.padding(5);
            Text.fontColor(Color.White);
        }, Text);
        Text.pop();
        Stack.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
    static getEntryName() {
        return "QuickStartPage";
    }
}
registerNamedRoute(() => new QuickStartPage(undefined, {}), "", { bundleName: "com.example.ictproject", moduleName: "quickstart", pagePath: "pages/QuickStartPage", pageFullPath: "features/quickstart/src/main/ets/pages/QuickStartPage", integratedHsp: "false" });
//# sourceMappingURL=QuickStartPage.js.map
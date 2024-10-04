if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface QuickStartPage_Params {
}
import { Attraction } from "@bundle:com.example.ictproject/default@quickstart/ets/model/Attraction";
import { Classification } from "@bundle:com.example.ictproject/default@quickstart/ets/view/Classficiation";
import { NearbyAttraction } from "@bundle:com.example.ictproject/default@quickstart/ets/view/NearbyAttraction";
import { SearchHeader } from "@bundle:com.example.ictproject/default@quickstart/ets/view/SearchHeader";
export const attractions: Attraction[] = [
    new Attraction(1, "长城", { "id": 33554531, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }),
    new Attraction(2, "故宫", { "id": 33554532, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }),
    new Attraction(3, "大唐不夜城", { "id": 33554533, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }),
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
    setInitiallyProvidedValue(params: QuickStartPage_Params) {
    }
    updateStateVars(params: QuickStartPage_Params) {
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
    AttractionItem(attraction: Attraction, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create();
            Stack.align(Alignment.TopStart);
            Stack.width('100%');
            Stack.backgroundColor(Color.White);
            Stack.borderRadius(10);
            Stack.margin({ top: 10 });
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create(attraction.image);
            Image.width('100%');
            Image.height(200);
            Image.borderRadius(10);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(attraction.name);
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
    static getEntryName(): string {
        return "QuickStartPage";
    }
}
registerNamedRoute(() => new QuickStartPage(undefined, {}), "", { bundleName: "com.example.ictproject", moduleName: "default", pagePath: "../../../../../features/quickstart/src/main/ets/pages/QuickStartPage", pageFullPath: "features/quickstart/src/main/ets/pages/QuickStartPage", integratedHsp: "false" });

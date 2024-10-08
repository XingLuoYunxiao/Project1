if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface TravelStartPage_Params {
    travelPathStack?: NavPathStack;
}
import { Attraction } from "@bundle:com.example.ictproject/default@Travel/ets/model/Attraction";
import { LoadingAnimation } from "@bundle:com.example.ictproject/default@Travel/ets/util/Loading";
import { Classification } from "@bundle:com.example.ictproject/default@Travel/ets/view/Classficiation";
import { NearbyAttraction } from "@bundle:com.example.ictproject/default@Travel/ets/view/NearbyAttraction";
import { SearchHeader } from "@bundle:com.example.ictproject/default@Travel/ets/view/SearchHeader";
import { AttractionDetailPage } from "@bundle:com.example.ictproject/default@Travel/ets/pages/AttractionDetailPage";
import { FamousPlacePage } from "@bundle:com.example.ictproject/default@Travel/ets/pages/FamousPlacePage";
export const attractions: Attraction[] = [
    new Attraction(1, "长城", { "id": 33554531, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }),
    new Attraction(2, "故宫", { "id": 33554532, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }),
    new Attraction(3, "大唐不夜城", { "id": 33554533, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }),
];
export class TravelStartPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__travelPathStack = new ObservedPropertyObjectPU(new NavPathStack(), this, "travelPathStack");
        this.addProvidedVar("travelPathStack", this.__travelPathStack, false);
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: TravelStartPage_Params) {
        if (params.travelPathStack !== undefined) {
            this.travelPathStack = params.travelPathStack;
        }
    }
    updateStateVars(params: TravelStartPage_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__travelPathStack.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__travelPathStack.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __travelPathStack: ObservedPropertyObjectPU<NavPathStack>;
    get travelPathStack() {
        return this.__travelPathStack.get();
    }
    set travelPathStack(newValue: NavPathStack) {
        this.__travelPathStack.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Navigation.create(this.travelPathStack, { moduleName: "default", pagePath: "features/Travel/src/main/ets/pages/TravelStartPage", isUserCreateStack: true });
            Navigation.navDestination({ builder: this.travelStartRouter.bind(this) });
            Navigation.hideTitleBar(true);
            Navigation.mode(NavigationMode.Stack);
        }, Navigation);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('95%');
            Column.height('100%');
            Column.backgroundColor('#F1F3F5');
        }, Column);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    //搜索栏
                    SearchHeader(this, {}, undefined, elmtId, () => { }, { page: "features/Travel/src/main/ets/pages/TravelStartPage.ets", line: 25, col: 9 });
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
            //轮播图
            Swiper.create();
            //轮播图
            Swiper.autoPlay(true);
            //轮播图
            Swiper.loop(true);
            //轮播图
            Swiper.indicator(false);
            //轮播图
            Swiper.width('100%');
        }, Swiper);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
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
            this.forEachUpdateFunction(elmtId, attractions, forEachItemGenFunction);
        }, ForEach);
        ForEach.pop();
        //轮播图
        Swiper.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.padding({ top: 10, bottom: 10 });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    //旅游分类
                    Classification(this, {}, undefined, elmtId, () => { }, { page: "features/Travel/src/main/ets/pages/TravelStartPage.ets", line: 44, col: 9 });
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
                    let componentCall = new 
                    //附近景点
                    NearbyAttraction(this, {}, undefined, elmtId, () => { }, { page: "features/Travel/src/main/ets/pages/TravelStartPage.ets", line: 49, col: 9 });
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
        Navigation.pop();
    }
    travelStartRouter(path: string, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (path === 'FamousPlacePage') {
                this.ifElseBranchUpdateFunction(0, () => {
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new FamousPlacePage(this, {}, undefined, elmtId, () => { }, { page: "features/Travel/src/main/ets/pages/TravelStartPage.ets", line: 67, col: 7 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {};
                                };
                                componentCall.paramsGenerator_ = paramsLambda;
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                            }
                        }, { name: "FamousPlacePage" });
                    }
                });
            }
            else if (path === 'LoadingAnimation') {
                this.ifElseBranchUpdateFunction(1, () => {
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new LoadingAnimation(this, {}, undefined, elmtId, () => { }, { page: "features/Travel/src/main/ets/pages/TravelStartPage.ets", line: 69, col: 7 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {};
                                };
                                componentCall.paramsGenerator_ = paramsLambda;
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                            }
                        }, { name: "LoadingAnimation" });
                    }
                });
            }
            else if (path === 'AttractionDetailPage') {
                this.ifElseBranchUpdateFunction(2, () => {
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new AttractionDetailPage(this, {}, undefined, elmtId, () => { }, { page: "features/Travel/src/main/ets/pages/TravelStartPage.ets", line: 71, col: 7 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {};
                                };
                                componentCall.paramsGenerator_ = paramsLambda;
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                            }
                        }, { name: "AttractionDetailPage" });
                    }
                });
            }
            else {
                this.ifElseBranchUpdateFunction(3, () => {
                });
            }
        }, If);
        If.pop();
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
}

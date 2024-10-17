if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface Index_Params {
    currentIndex?: number;
    tabsController?: TabsController;
}
import { TravelStartPage } from "@bundle:com.example.ictproject/default@Travel/Index";
import { InfoMessagePage } from "@bundle:com.example.ictproject/default@Login/Index";
import { CulturalHeritageStartPage } from "@bundle:com.example.ictproject/default@Travel/Index";
class Index extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__currentIndex = new ObservedPropertySimplePU(0, this, "currentIndex");
        this.tabsController = new TabsController();
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: Index_Params) {
        if (params.currentIndex !== undefined) {
            this.currentIndex = params.currentIndex;
        }
        if (params.tabsController !== undefined) {
            this.tabsController = params.tabsController;
        }
    }
    updateStateVars(params: Index_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__currentIndex.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__currentIndex.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __currentIndex: ObservedPropertySimplePU<number>;
    get currentIndex() {
        return this.__currentIndex.get();
    }
    set currentIndex(newValue: number) {
        this.__currentIndex.set(newValue);
    }
    private tabsController: TabsController;
    tabBarBuilder(title: string, targetIndex: number, selectedIcon: Resource, unselectIcon: Resource, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("products/default/src/main/ets/pages/Index.ets(12:5)", "default");
            Column.width('100%');
            Column.height('100%');
            Column.justifyContent(FlexAlign.Center);
            Column.alignItems(HorizontalAlign.Center);
            Column.onClick(() => {
                this.currentIndex = targetIndex;
                this.tabsController.changeIndex(targetIndex);
            });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create(this.currentIndex === targetIndex ? selectedIcon : unselectIcon);
            Image.debugLine("products/default/src/main/ets/pages/Index.ets(13:7)", "default");
            Image.width(24);
            Image.height(24);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(title);
            Text.debugLine("products/default/src/main/ets/pages/Index.ets(16:7)", "default");
            Text.fontFamily('HarmonyHeiTi-Medium');
            Text.fontSize(10);
            Text.fontColor(this.currentIndex === targetIndex ? '#0A59F7' : 'rgba(0,0,0,0.60)');
            Text.textAlign(TextAlign.Center);
            Text.lineHeight(14);
            Text.fontWeight(500);
        }, Text);
        Text.pop();
        Column.pop();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Tabs.create({ barPosition: BarPosition.End, controller: this.tabsController });
            Tabs.debugLine("products/default/src/main/ets/pages/Index.ets(35:5)", "default");
            Tabs.vertical(false);
            Tabs.divider({
                strokeWidth: 0.5,
                color: '#0D182431'
            });
            Tabs.scrollable(false);
            Tabs.backgroundColor('#F1F3F5');
            Tabs.padding({ top: 36, bottom: 28 });
        }, Tabs);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TabContent.create(() => {
                {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        if (isInitialRender) {
<<<<<<< HEAD:products/default/.preview/default/cache/default/default@PreviewArkTS/esmodule/debug/products/default/src/main/ets/pages/Index.ts
                            let componentCall = new TravelStartPage(this, {}, undefined, elmtId, () => { }, { page: "products/default/src/main/ets/pages/Index.ets", line: 37, col: 9 });
=======
                            let componentCall = new TravelStartPage(this, {}, undefined, elmtId, () => { }, { page: "products/default/src/main/ets/pages/Index.ets", line: 38, col: 9 });
>>>>>>> origin/zmx:products/default/build/default/cache/default/default@CompileArkTS/esmodule/debug/products/default/src/main/ets/pages/Index.ts
                            ViewPU.create(componentCall);
                            let paramsLambda = () => {
                                return {};
                            };
                            componentCall.paramsGenerator_ = paramsLambda;
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                    }, { name: "TravelStartPage" });
                }
            });
            TabContent.tabBar({ builder: () => {
                    this.tabBarBuilder.call(this, '旅游', 0, { "id": 50331662, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, { "id": 50331654, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                } });
            TabContent.debugLine("products/default/src/main/ets/pages/Index.ets(36:7)", "default");
        }, TabContent);
        TabContent.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TabContent.create(() => {
                {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        if (isInitialRender) {
                            let componentCall = new CulturalHeritageStartPage(this, {}, undefined, elmtId, () => { }, { page: "products/default/src/main/ets/pages/Index.ets", line: 43, col: 9 });
                            ViewPU.create(componentCall);
                            let paramsLambda = () => {
                                return {};
                            };
                            componentCall.paramsGenerator_ = paramsLambda;
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                    }, { name: "CulturalHeritageStartPage" });
                }
            });
            TabContent.tabBar({ builder: () => {
                    this.tabBarBuilder.call(this, '非遗', 1, { "id": 50331665, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, { "id": 50331663, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                } });
            TabContent.debugLine("products/default/src/main/ets/pages/Index.ets(41:7)", "default");
        }, TabContent);
        TabContent.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TabContent.create(() => {
                {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        if (isInitialRender) {
                            let componentCall = new InfoMessagePage(this, {}, undefined, elmtId, () => { }, { page: "products/default/src/main/ets/pages/Index.ets", line: 48, col: 9 });
                            ViewPU.create(componentCall);
                            let paramsLambda = () => {
                                return {};
                            };
                            componentCall.paramsGenerator_ = paramsLambda;
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                    }, { name: "InfoMessagePage" });
                }
            });
            TabContent.tabBar({ builder: () => {
                    this.tabBarBuilder.call(this, '我的', 2, { "id": 50331655, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, { "id": 50331660, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                } });
            TabContent.debugLine("products/default/src/main/ets/pages/Index.ets(45:7)", "default");
        }, TabContent);
        TabContent.pop();
        Tabs.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
    static getEntryName(): string {
        return "Index";
    }
}
registerNamedRoute(() => new Index(undefined, {}), "", { bundleName: "com.example.ictproject", moduleName: "default", pagePath: "pages/Index", pageFullPath: "products/default/src/main/ets/pages/Index", integratedHsp: "false" });

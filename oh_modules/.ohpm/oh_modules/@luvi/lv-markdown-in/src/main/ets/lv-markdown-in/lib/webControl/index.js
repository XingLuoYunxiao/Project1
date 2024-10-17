if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import a17 from '@ohos.web.webview';
import { lvLink } from '../domain/LvLink';
export class WebControl extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.controller = undefined;
        this.webController = new a17.WebviewController();
        this.b2 = new ObservedPropertySimplePU(MixedMode.All, this, "mode");
        this.c2 = new ObservedPropertySimplePU(true, this, "loading");
        this.t1 = new ObservedPropertyObjectPU(lvLink, this, "nLink");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.controller !== undefined) {
            this.controller = params.controller;
        }
        if (params.webController !== undefined) {
            this.webController = params.webController;
        }
        if (params.mode !== undefined) {
            this.mode = params.mode;
        }
        if (params.loading !== undefined) {
            this.loading = params.loading;
        }
        if (params.nLink !== undefined) {
            this.nLink = params.nLink;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.b2.purgeDependencyOnElmtId(rmElmtId);
        this.c2.purgeDependencyOnElmtId(rmElmtId);
        this.t1.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.b2.aboutToBeDeleted();
        this.c2.aboutToBeDeleted();
        this.t1.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    setController(ctr) {
        this.controller = ctr;
    }
    get mode() {
        return this.b2.get();
    }
    set mode(newValue) {
        this.b2.set(newValue);
    }
    get loading() {
        return this.c2.get();
    }
    set loading(newValue) {
        this.c2.set(newValue);
    }
    get nLink() {
        return this.t1.get();
    }
    set nLink(newValue) {
        this.t1.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create({ alignContent: Alignment.Center });
            Stack.backgroundColor("#fff");
            Stack.height('85%');
            Stack.margin(15);
            Stack.borderRadius(15);
            Stack.clip(true);
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Web.create({ src: this.nLink.getLinkUrl(), controller: this.webController });
            Web.mixedMode(this.mode);
            Web.domStorageAccess(true);
            Web.javaScriptAccess(true);
            Web.overviewModeAccess(false);
            Web.width("100%");
            Web.onPageEnd((e) => {
                this.loading = false;
            });
        }, Web);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.loading) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Column.create();
                        Column.padding({
                            top: 20,
                            bottom: 22,
                            left: 30,
                            right: 30
                        });
                        Column.borderRadius(10);
                        Column.backgroundColor("#fff");
                        Column.shadow({ radius: 21, color: "rgba(0,0,0,0.09)" });
                    }, Column);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        LoadingProgress.create();
                        LoadingProgress.width(50);
                        LoadingProgress.height(50);
                        LoadingProgress.color("#333333");
                    }, LoadingProgress);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Text.create("加载中");
                        Text.fontSize(15);
                        Text.fontColor("#333333");
                        Text.margin({ top: 3 });
                    }, Text);
                    Text.pop();
                    Column.pop();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                });
            }
        }, If);
        If.pop();
        Stack.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

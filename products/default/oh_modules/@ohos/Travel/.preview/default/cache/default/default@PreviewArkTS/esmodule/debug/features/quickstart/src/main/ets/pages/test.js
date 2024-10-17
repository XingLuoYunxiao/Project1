"use strict";
if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
class ListItemExample extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.arr = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.arr !== undefined) {
            this.arr = params.arr;
        }
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
            Column.debugLine("features/quickstart/src/main/ets/pages/test.ets(8:5)", "quickstart");
            Column.width('100%');
            Column.height('100%');
            Column.backgroundColor(0xDCDCDC);
            Column.padding({ top: 5 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("features/quickstart/src/main/ets/pages/test.ets(9:7)", "quickstart");
            Column.width('100%');
            Column.height(200);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('1');
            Text.debugLine("features/quickstart/src/main/ets/pages/test.ets(10:9)", "quickstart");
        }, Text);
        Text.pop();
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            List.create({ space: 20, initialIndex: 0 });
            List.debugLine("features/quickstart/src/main/ets/pages/test.ets(15:7)", "quickstart");
            List.width('90%');
            List.height(300);
            List.scrollBar(BarState.Off);
        }, List);
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
                        ListItem.debugLine("features/quickstart/src/main/ets/pages/test.ets(17:11)", "quickstart");
                    };
                    const deepRenderFunction = (elmtId, isInitialRender) => {
                        itemCreation(elmtId, isInitialRender);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Text.create('' + item);
                            Text.debugLine("features/quickstart/src/main/ets/pages/test.ets(18:13)", "quickstart");
                            Text.width('100%');
                            Text.height(100);
                            Text.fontSize(16);
                            Text.textAlign(TextAlign.Center);
                            Text.borderRadius(10);
                            Text.backgroundColor(0xFFFFFF);
                        }, Text);
                        Text.pop();
                        ListItem.pop();
                    };
                    this.observeComponentCreation2(itemCreation2, ListItem);
                    ListItem.pop();
                }
            };
            this.forEachUpdateFunction(elmtId, this.arr, forEachItemGenFunction, (item) => item, false, false);
        }, ForEach);
        ForEach.pop();
        List.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("features/quickstart/src/main/ets/pages/test.ets(31:7)", "quickstart");
            Column.width('100%');
            Column.height(200);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('1');
            Text.debugLine("features/quickstart/src/main/ets/pages/test.ets(32:9)", "quickstart");
        }, Text);
        Text.pop();
        Column.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
    static getEntryName() {
        return "ListItemExample";
    }
}
registerNamedRoute(() => new ListItemExample(undefined, {}), "", { bundleName: "com.example.ictproject", moduleName: "quickstart", pagePath: "pages/test", pageFullPath: "features/quickstart/src/main/ets/pages/test", integratedHsp: "false" });
//# sourceMappingURL=test.js.map
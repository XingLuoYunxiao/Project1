"use strict";
if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
class ListExample extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__arr = new ObservedPropertyObjectPU([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], this, "arr");
        this.__editFlag = new ObservedPropertySimplePU(false, this, "editFlag");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.arr !== undefined) {
            this.arr = params.arr;
        }
        if (params.editFlag !== undefined) {
            this.editFlag = params.editFlag;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__arr.purgeDependencyOnElmtId(rmElmtId);
        this.__editFlag.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__arr.aboutToBeDeleted();
        this.__editFlag.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get arr() {
        return this.__arr.get();
    }
    set arr(newValue) {
        this.__arr.set(newValue);
    }
    get editFlag() {
        return this.__editFlag.get();
    }
    set editFlag(newValue) {
        this.__editFlag.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create({ alignContent: Alignment.TopStart });
            Stack.debugLine("features/quickstart/src/main/ets/pages/test.ets(9:5)", "quickstart");
            Stack.width('100%');
            Stack.height('200%');
            Stack.backgroundColor(0xDCDCDC);
            Stack.padding({ top: 5 });
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("features/quickstart/src/main/ets/pages/test.ets(10:7)", "quickstart");
            Column.width('100%');
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('List Example');
            Text.debugLine("features/quickstart/src/main/ets/pages/test.ets(11:9)", "quickstart");
            Text.fontSize(30);
            Text.fontColor(0x000000);
            Text.width('100%');
            Text.height(400);
            Text.textAlign(TextAlign.Center);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            List.create({ space: 20, initialIndex: 0 });
            List.debugLine("features/quickstart/src/main/ets/pages/test.ets(17:9)", "quickstart");
            List.width('90%');
            List.scrollBar(BarState.Off);
            List.friction(0.6);
        }, List);
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
                        ListItem.debugLine("features/quickstart/src/main/ets/pages/test.ets(19:13)", "quickstart");
                    };
                    const deepRenderFunction = (elmtId, isInitialRender) => {
                        itemCreation(elmtId, isInitialRender);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Flex.create({ direction: FlexDirection.Row, alignItems: ItemAlign.Center });
                            Flex.debugLine("features/quickstart/src/main/ets/pages/test.ets(20:15)", "quickstart");
                        }, Flex);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Text.create('' + item);
                            Text.debugLine("features/quickstart/src/main/ets/pages/test.ets(21:17)", "quickstart");
                            Text.width('100%');
                            Text.height(80);
                            Text.fontSize(20);
                            Text.textAlign(TextAlign.Center);
                            Text.borderRadius(10);
                            Text.backgroundColor(0xFFFFFF);
                            Text.flexShrink(1);
                        }, Text);
                        Text.pop();
                        Flex.pop();
                        ListItem.pop();
                    };
                    this.observeComponentCreation2(itemCreation2, ListItem);
                    ListItem.pop();
                }
            };
            this.forEachUpdateFunction(elmtId, this.arr, forEachItemGenFunction, (item) => item, true, false);
        }, ForEach);
        ForEach.pop();
        List.pop();
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel('edit list');
            Button.debugLine("features/quickstart/src/main/ets/pages/test.ets(37:7)", "quickstart");
            Button.onClick(() => {
                this.editFlag = !this.editFlag;
            });
            Button.margin({ top: 5, left: 20 });
        }, Button);
        Button.pop();
        Stack.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
    static getEntryName() {
        return "ListExample";
    }
}
registerNamedRoute(() => new ListExample(undefined, {}), "", { bundleName: "com.example.ictproject", moduleName: "quickstart", pagePath: "pages/test", pageFullPath: "features/quickstart/src/main/ets/pages/test", integratedHsp: "false" });
//# sourceMappingURL=test.js.map
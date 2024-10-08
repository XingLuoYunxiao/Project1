if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { bufferToString } from '@bundle:com.example.ictproject/quickstart/ets/util/BufferUtil';
export class EnablementView extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__enablementList = new ObservedPropertyObjectPU([], this, "enablementList");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.enablementList !== undefined) {
            this.enablementList = params.enablementList;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__enablementList.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__enablementList.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get enablementList() {
        return this.__enablementList.get();
    }
    set enablementList(newValue) {
        this.__enablementList.set(newValue);
    }
    aboutToAppear() {
        this.getEnablementDataFromJSON();
    }
    getEnablementDataFromJSON() {
        getContext(this).resourceManager.getRawFileContent('EnablementData.json').then(value => {
            this.enablementList = JSON.parse(bufferToString(value));
        });
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("features/quickstart/src/main/ets/view/EnablementView.ets(19:5)", "quickstart");
            Column.margin({ top: 18 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('赋能套件');
            Text.debugLine("features/quickstart/src/main/ets/view/EnablementView.ets(20:7)", "quickstart");
            Text.fontColor('#182431');
            Text.fontSize(16);
            Text.fontWeight(500);
            Text.fontFamily('HarmonyHeiTi-medium');
            Text.textAlign(TextAlign.Start);
            Text.padding({ left: 16, right: 16 });
            Text.width('100%');
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Grid.create();
            Grid.debugLine("features/quickstart/src/main/ets/view/EnablementView.ets(28:7)", "quickstart");
            Grid.rowsTemplate('1fr');
            Grid.columnsGap(8);
            Grid.scrollBar(BarState.Off);
            Grid.height(169);
            Grid.padding({ top: 2, left: 16, right: 16 });
        }, Grid);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const item = _item;
                {
                    const itemCreation2 = (elmtId, isInitialRender) => {
                        GridItem.create(() => { }, false);
                        GridItem.debugLine("features/quickstart/src/main/ets/view/EnablementView.ets(30:11)", "quickstart");
                    };
                    const observedDeepRender = () => {
                        this.observeComponentCreation2(itemCreation2, GridItem);
                        {
                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                if (isInitialRender) {
                                    let componentCall = new EnablementItem(this, { enablementItem: item }, undefined, elmtId, () => { }, { page: "features/quickstart/src/main/ets/view/EnablementView.ets", line: 31, col: 13 });
                                    ViewPU.create(componentCall);
                                    let paramsLambda = () => {
                                        return {
                                            enablementItem: item
                                        };
                                    };
                                    componentCall.paramsGenerator_ = paramsLambda;
                                }
                                else {
                                    this.updateStateVarsOfChildByElmtId(elmtId, {
                                        enablementItem: item
                                    });
                                }
                            }, { name: "EnablementItem" });
                        }
                        GridItem.pop();
                    };
                    observedDeepRender();
                }
            };
            this.forEachUpdateFunction(elmtId, this.enablementList, forEachItemGenFunction, (item) => item.id, false, false);
        }, ForEach);
        ForEach.pop();
        Grid.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
export class EnablementItem extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__enablementItem = new SynchedPropertyObjectOneWayPU(params.enablementItem, this, "enablementItem");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
    }
    updateStateVars(params) {
        this.__enablementItem.reset(params.enablementItem);
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__enablementItem.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__enablementItem.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get enablementItem() {
        return this.__enablementItem.get();
    }
    set enablementItem(newValue) {
        this.__enablementItem.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("features/quickstart/src/main/ets/view/EnablementView.ets(50:5)", "quickstart");
            Column.width(160);
            Column.height(169);
            Column.borderRadius(16);
            Column.backgroundColor(Color.White);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": -1, "type": -1, params: [this.enablementItem.imageSrc], "bundleName": "com.example.ictproject", "moduleName": "quickstart" });
            Image.debugLine("features/quickstart/src/main/ets/view/EnablementView.ets(51:7)", "quickstart");
            Image.width('100%');
            Image.objectFit(ImageFit.Cover);
            Image.height(96);
            Image.borderRadius({
                topLeft: 16,
                topRight: 16
            });
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.enablementItem.title);
            Text.debugLine("features/quickstart/src/main/ets/view/EnablementView.ets(59:7)", "quickstart");
            Text.height(19);
            Text.width('100%');
            Text.fontSize(14);
            Text.textAlign(TextAlign.Start);
            Text.textOverflow({ overflow: TextOverflow.Ellipsis });
            Text.maxLines(1);
            Text.fontWeight(400);
            Text.padding({ left: 12, right: 12 });
            Text.margin({ top: 8 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.enablementItem.brief);
            Text.debugLine("features/quickstart/src/main/ets/view/EnablementView.ets(69:7)", "quickstart");
            Text.height(32);
            Text.width('100%');
            Text.fontSize(12);
            Text.textAlign(TextAlign.Start);
            Text.textOverflow({ overflow: TextOverflow.Ellipsis });
            Text.maxLines(2);
            Text.fontWeight(400);
            Text.fontColor('rgba(0, 0, 0, 0.6)');
            Text.padding({ left: 12, right: 12 });
            Text.margin({ top: 2 });
        }, Text);
        Text.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=EnablementView.js.map
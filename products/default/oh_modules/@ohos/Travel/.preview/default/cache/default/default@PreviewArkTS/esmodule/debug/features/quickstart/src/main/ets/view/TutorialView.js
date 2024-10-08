if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { bufferToString } from '@bundle:com.example.ictproject/quickstart/ets/util/BufferUtil';
export class TutorialView extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__tutorialList = new ObservedPropertyObjectPU([], this, "tutorialList");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.tutorialList !== undefined) {
            this.tutorialList = params.tutorialList;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__tutorialList.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__tutorialList.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get tutorialList() {
        return this.__tutorialList.get();
    }
    set tutorialList(newValue) {
        this.__tutorialList.set(newValue);
    }
    aboutToAppear() {
        this.getTutorialDataFromJSON();
    }
    getTutorialDataFromJSON() {
        getContext(this).resourceManager.getRawFileContent('TutorialData.json').then(value => {
            this.tutorialList = JSON.parse(bufferToString(value));
        });
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("features/quickstart/src/main/ets/view/TutorialView.ets(19:5)", "quickstart");
            Column.margin({ top: 18 });
            Column.alignItems(HorizontalAlign.Start);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('入门教程');
            Text.debugLine("features/quickstart/src/main/ets/view/TutorialView.ets(20:7)", "quickstart");
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
            List.create({ space: 12 });
            List.debugLine("features/quickstart/src/main/ets/view/TutorialView.ets(29:7)", "quickstart");
            List.scrollBar(BarState.Off);
            List.padding({ left: 16, right: 16 });
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
                        ListItem.debugLine("features/quickstart/src/main/ets/view/TutorialView.ets(31:11)", "quickstart");
                    };
                    const deepRenderFunction = (elmtId, isInitialRender) => {
                        itemCreation(elmtId, isInitialRender);
                        {
                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                if (isInitialRender) {
                                    let componentCall = new TutorialItem(this, { tutorialItem: item }, undefined, elmtId, () => { }, { page: "features/quickstart/src/main/ets/view/TutorialView.ets", line: 32, col: 13 });
                                    ViewPU.create(componentCall);
                                    let paramsLambda = () => {
                                        return {
                                            tutorialItem: item
                                        };
                                    };
                                    componentCall.paramsGenerator_ = paramsLambda;
                                }
                                else {
                                    this.updateStateVarsOfChildByElmtId(elmtId, {
                                        tutorialItem: item
                                    });
                                }
                            }, { name: "TutorialItem" });
                        }
                        ListItem.pop();
                    };
                    this.observeComponentCreation2(itemCreation2, ListItem);
                    ListItem.pop();
                }
            };
            this.forEachUpdateFunction(elmtId, this.tutorialList, forEachItemGenFunction, (item) => item.id, false, false);
        }, ForEach);
        ForEach.pop();
        List.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
export class TutorialItem extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__tutorialItem = new SynchedPropertyObjectOneWayPU(params.tutorialItem, this, "tutorialItem");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
    }
    updateStateVars(params) {
        this.__tutorialItem.reset(params.tutorialItem);
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__tutorialItem.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__tutorialItem.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get tutorialItem() {
        return this.__tutorialItem.get();
    }
    set tutorialItem(newValue) {
        this.__tutorialItem.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.debugLine("features/quickstart/src/main/ets/view/TutorialView.ets(49:5)", "quickstart");
            Row.width('100%');
            Row.height(88);
            Row.borderRadius(16);
            Row.backgroundColor(Color.White);
            Row.padding(12);
            Row.alignItems(VerticalAlign.Top);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("features/quickstart/src/main/ets/view/TutorialView.ets(50:7)", "quickstart");
            Column.height('100%');
            Column.layoutWeight(1);
            Column.alignItems(HorizontalAlign.Start);
            Column.margin({ right: 12 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.tutorialItem.title);
            Text.debugLine("features/quickstart/src/main/ets/view/TutorialView.ets(51:9)", "quickstart");
            Text.height(19);
            Text.width('100%');
            Text.fontSize(14);
            Text.textAlign(TextAlign.Start);
            Text.textOverflow({ overflow: TextOverflow.Ellipsis });
            Text.maxLines(1);
            Text.fontWeight(400);
            Text.margin({ top: 4 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.tutorialItem.brief);
            Text.debugLine("features/quickstart/src/main/ets/view/TutorialView.ets(61:9)", "quickstart");
            Text.height(32);
            Text.width('100%');
            Text.fontSize(12);
            Text.textAlign(TextAlign.Start);
            Text.textOverflow({ overflow: TextOverflow.Ellipsis });
            Text.maxLines(2);
            Text.fontWeight(400);
            Text.fontColor('rgba(0, 0, 0, 0.6)');
            Text.margin({ top: 5 });
        }, Text);
        Text.pop();
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": -1, "type": -1, params: [this.tutorialItem.imageSrc], "bundleName": "com.example.ictproject", "moduleName": "quickstart" });
            Image.debugLine("features/quickstart/src/main/ets/view/TutorialView.ets(77:7)", "quickstart");
            Image.objectFit(ImageFit.Cover);
            Image.height(64);
            Image.width(108);
            Image.borderRadius(16);
        }, Image);
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=TutorialView.js.map
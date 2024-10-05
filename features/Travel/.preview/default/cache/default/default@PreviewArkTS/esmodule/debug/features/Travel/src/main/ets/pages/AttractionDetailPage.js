if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { Attraction } from '@bundle:com.example.ictproject/Travel/ets/model/Attraction';
export class AttractionDetailPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__attraction = new ObservedPropertyObjectPU(new Attraction(1, "null", { "id": 83886222, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "Travel" }), this, "attraction");
        this.__travelPathStack = this.initializeConsume('travelPathStack', "travelPathStack");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.attraction !== undefined) {
            this.attraction = params.attraction;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__attraction.purgeDependencyOnElmtId(rmElmtId);
        this.__travelPathStack.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__attraction.aboutToBeDeleted();
        this.__travelPathStack.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get attraction() {
        return this.__attraction.get();
    }
    set attraction(newValue) {
        this.__attraction.set(newValue);
    }
    get travelPathStack() {
        return this.__travelPathStack.get();
    }
    set travelPathStack(newValue) {
        this.__travelPathStack.set(newValue);
    }
    aboutToAppear() {
        this.attraction = this.travelPathStack.getParamByName('AttractionDetailPage')[0];
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            NavDestination.create(() => {
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
                    Column.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(14:7)", "travel");
                    Column.width('95%');
                    Column.height('100%');
                }, Column);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Row.create();
                    Row.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(15:9)", "travel");
                    Row.width('100%');
                    Row.justifyContent(FlexAlign.Start);
                }, Row);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Image.create({ "id": 83886088, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "Travel" });
                    Image.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(16:11)", "travel");
                    Image.width(30);
                    Image.height(30);
                    Image.onClick(() => {
                        this.travelPathStack.pop();
                    });
                }, Image);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Row.create();
                    Row.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(22:11)", "travel");
                    Row.layoutWeight(1);
                    Row.justifyContent(FlexAlign.Center);
                }, Row);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create(this.attraction.name);
                    Text.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(23:13)", "travel");
                    Text.fontSize(20);
                    Text.fontWeight(FontWeight.Bold);
                    Text.margin({ right: 15 });
                }, Text);
                Text.pop();
                Row.pop();
                Row.pop();
                Column.pop();
            }, { moduleName: "Travel", pagePath: "features/Travel/src/main/ets/pages/AttractionDetailPage" });
            NavDestination.hideTitleBar(true);
            NavDestination.debugLine("features/Travel/src/main/ets/pages/AttractionDetailPage.ets(13:5)", "travel");
        }, NavDestination);
        NavDestination.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=AttractionDetailPage.js.map
if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface SearchHeader_Params {
}
export class SearchHeader extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: SearchHeader_Params) {
    }
    updateStateVars(params: SearchHeader_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create({ space: 5 });
            Row.margin({ top: 5 });
            Row.width('100%');
            Row.height(30);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 33554530, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Image.width(30);
            Image.height(30);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Search.create({ placeholder: "搜索想要去的景点" });
            Search.height(30);
            Search.layoutWeight(1);
        }, Search);
        Search.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Badge.create({ count: 1, position: BadgePosition.RightTop, style: { fontSize: 14, badgeColor: Color.Red } });
        }, Badge);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 33554529, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Image.width(24);
        }, Image);
        Badge.pop();
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

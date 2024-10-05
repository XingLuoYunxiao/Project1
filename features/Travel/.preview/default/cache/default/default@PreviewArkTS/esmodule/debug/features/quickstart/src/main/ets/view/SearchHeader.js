if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
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
    setInitiallyProvidedValue(params) {
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
            Row.create({ space: 5 });
            Row.debugLine("features/quickstart/src/main/ets/view/SearchHeader.ets(5:5)", "quickstart");
            Row.margin({ top: 5 });
            Row.width('100%');
            Row.height(30);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 83886086, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "quickstart" });
            Image.debugLine("features/quickstart/src/main/ets/view/SearchHeader.ets(6:7)", "quickstart");
            Image.width(30);
            Image.height(30);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Search.create({ placeholder: "搜索想要去的景点" });
            Search.debugLine("features/quickstart/src/main/ets/view/SearchHeader.ets(9:7)", "quickstart");
            Search.height(30);
            Search.layoutWeight(1);
        }, Search);
        Search.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Badge.create({ count: 1, position: BadgePosition.RightTop, style: { fontSize: 14, badgeColor: Color.Red } });
            Badge.debugLine("features/quickstart/src/main/ets/view/SearchHeader.ets(12:7)", "quickstart");
        }, Badge);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 83886095, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "quickstart" });
            Image.debugLine("features/quickstart/src/main/ets/view/SearchHeader.ets(13:9)", "quickstart");
            Image.width(24);
        }, Image);
        Badge.pop();
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=SearchHeader.js.map
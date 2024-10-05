if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
export class VirtualCharacter extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__mouthOpenness = new ObservedPropertySimplePU(0, this, "mouthOpenness");
        this.__bodyRotation = new ObservedPropertySimplePU(0, this, "bodyRotation");
        this.animationInterval = -1;
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.mouthOpenness !== undefined) {
            this.mouthOpenness = params.mouthOpenness;
        }
        if (params.bodyRotation !== undefined) {
            this.bodyRotation = params.bodyRotation;
        }
        if (params.animationInterval !== undefined) {
            this.animationInterval = params.animationInterval;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__mouthOpenness.purgeDependencyOnElmtId(rmElmtId);
        this.__bodyRotation.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__mouthOpenness.aboutToBeDeleted();
        this.__bodyRotation.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get mouthOpenness() {
        return this.__mouthOpenness.get();
    }
    set mouthOpenness(newValue) {
        this.__mouthOpenness.set(newValue);
    }
    get bodyRotation() {
        return this.__bodyRotation.get();
    }
    set bodyRotation(newValue) {
        this.__bodyRotation.set(newValue);
    }
    aboutToAppear() {
        this.animationInterval = setInterval(() => {
            this.animateMouthAndBody();
        }, 100);
    }
    aboutToDisappear() {
        clearInterval(this.animationInterval);
    }
    animateMouthAndBody() {
        this.mouthOpenness = Math.sin(new Date().getTime() / 200) * 10 + 10; // 0-20的范围
        this.bodyRotation = Math.sin(new Date().getTime() / 1000) * 5; // -5到5度的范围
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create({ alignContent: Alignment.Center });
            Stack.debugLine("features/Travel/src/main/ets/util/avatar.ets(24:5)", "travel");
            Stack.width('100%');
            Stack.height('100%');
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 身体
            Image.create({ "id": 33554444, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "Travel" });
            Image.debugLine("features/Travel/src/main/ets/util/avatar.ets(26:7)", "travel");
            // 身体
            Image.width(300);
            // 身体
            Image.height(400);
            // 身体
            Image.rotate({ angle: this.bodyRotation });
            // 身体
            Image.objectFit(ImageFit.Contain);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 头部（不动）
            Image.create({ "id": 33554443, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "Travel" });
            Image.debugLine("features/Travel/src/main/ets/util/avatar.ets(33:7)", "travel");
            // 头部（不动）
            Image.width(200);
            // 头部（不动）
            Image.height(200);
            // 头部（不动）
            Image.objectFit(ImageFit.Contain);
            // 头部（不动）
            Image.margin({ top: -150 });
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 嘴巴（动态）
            Stack.create();
            Stack.debugLine("features/Travel/src/main/ets/util/avatar.ets(40:7)", "travel");
            // 嘴巴（动态）
            Stack.width(80);
            // 嘴巴（动态）
            Stack.height(40);
            // 嘴巴（动态）
            Stack.margin({ top: 50 });
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 闭嘴图片
            Image.create({ "id": 33554445, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "Travel" });
            Image.debugLine("features/Travel/src/main/ets/util/avatar.ets(42:9)", "travel");
            // 闭嘴图片
            Image.width(80);
            // 闭嘴图片
            Image.height(40);
            // 闭嘴图片
            Image.objectFit(ImageFit.Cover);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 张嘴图片（动态调整透明度）
            Image.create({ "id": 33554446, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "Travel" });
            Image.debugLine("features/Travel/src/main/ets/util/avatar.ets(48:9)", "travel");
            // 张嘴图片（动态调整透明度）
            Image.width(80);
            // 张嘴图片（动态调整透明度）
            Image.height(40);
            // 张嘴图片（动态调整透明度）
            Image.objectFit(ImageFit.Cover);
            // 张嘴图片（动态调整透明度）
            Image.opacity(this.mouthOpenness / 20);
        }, Image);
        // 嘴巴（动态）
        Stack.pop();
        Stack.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
    static getEntryName() {
        return "VirtualCharacter";
    }
}
registerNamedRoute(() => new VirtualCharacter(undefined, {}), "", { bundleName: "com.example.ictproject", moduleName: "Travel", pagePath: "util/avatar", pageFullPath: "features/Travel/src/main/ets/util/avatar", integratedHsp: "false" });
//# sourceMappingURL=avatar.js.map
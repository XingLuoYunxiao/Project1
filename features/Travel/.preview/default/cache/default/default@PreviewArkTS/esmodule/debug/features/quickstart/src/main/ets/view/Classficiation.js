if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
export const colorList = [
    {
        color: Color.Green
    },
    {
        color: '#ff578be2'
    },
    {
        color: Color.Orange
    },
    {
        color: Color.Pink
    },
    {
        color: '#ffcabd44'
    }
];
export const classificationList = [
    {
        category: '景点门票',
        image: { "id": 83886083, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "quickstart" }
    },
    {
        category: '必游榜单',
        image: { "id": 83886085, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "quickstart" }
    },
    {
        category: '动植物园',
        image: { "id": 83886090, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "quickstart" }
    },
    {
        category: '著名遗迹',
        image: { "id": 83886089, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "quickstart" }
    },
    {
        category: '一日游玩',
        image: { "id": 83886091, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "quickstart" }
    }
];
export class Classification extends ViewPU {
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
            //景点分类
            Row.create();
            Row.debugLine("features/quickstart/src/main/ets/view/Classficiation.ets(55:5)", "quickstart");
            //景点分类
            Row.width('100%');
            //景点分类
            Row.height(100);
            //景点分类
            Row.backgroundColor(Color.White);
        }, Row);
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
                        ListItem.debugLine("features/quickstart/src/main/ets/view/Classficiation.ets(57:9)", "quickstart");
                    };
                    const deepRenderFunction = (elmtId, isInitialRender) => {
                        itemCreation(elmtId, isInitialRender);
                        this.myClassBuilder.bind(this)(item, index);
                        ListItem.pop();
                    };
                    this.observeComponentCreation2(itemCreation2, ListItem);
                    ListItem.pop();
                }
            };
            this.forEachUpdateFunction(elmtId, classificationList, forEachItemGenFunction, undefined, true, false);
        }, ForEach);
        ForEach.pop();
        //景点分类
        Row.pop();
    }
    myClassBuilder(item, index, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 5 });
            Column.debugLine("features/quickstart/src/main/ets/view/Classficiation.ets(68:5)", "quickstart");
            Column.alignItems(HorizontalAlign.Center);
            Column.justifyContent(FlexAlign.Center);
            Column.width(70);
            Column.height(70);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("features/quickstart/src/main/ets/view/Classficiation.ets(69:7)", "quickstart");
            Column.alignItems(HorizontalAlign.Center);
            Column.justifyContent(FlexAlign.Center);
            Column.width(40);
            Column.borderRadius(50);
            Column.height(40);
            Column.backgroundColor(colorList[index].color);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create(item.image);
            Image.debugLine("features/quickstart/src/main/ets/view/Classficiation.ets(70:9)", "quickstart");
            Image.width(30);
            Image.height(30);
        }, Image);
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(item.category);
            Text.debugLine("features/quickstart/src/main/ets/view/Classficiation.ets(81:7)", "quickstart");
            Text.fontSize(14);
            Text.margin({ left: 10, top: 10 });
            Text.width('100%');
        }, Text);
        Text.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=Classficiation.js.map
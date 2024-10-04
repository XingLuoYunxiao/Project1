if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface Classification_Params {
}
interface classification {
    category: string;
    image: Resource;
}
interface color {
    color: Color | string;
}
export const colorList: color[] = [
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
export const classificationList: classification[] = [
    {
        category: '景点门票',
        image: { "id": 33554534, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }
    },
    {
        category: '必游榜单',
        image: { "id": 33554535, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }
    },
    {
        category: '动植物园',
        image: { "id": 33554536, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }
    },
    {
        category: '著名遗迹',
        image: { "id": 33554537, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }
    },
    {
        category: '一日游玩',
        image: { "id": 33554538, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }
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
    setInitiallyProvidedValue(params: Classification_Params) {
    }
    updateStateVars(params: Classification_Params) {
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
    myClassBuilder(item: classification, index: number, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 5 });
            Column.alignItems(HorizontalAlign.Center);
            Column.justifyContent(FlexAlign.Center);
            Column.width(70);
            Column.height(70);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.alignItems(HorizontalAlign.Center);
            Column.justifyContent(FlexAlign.Center);
            Column.width(40);
            Column.borderRadius(50);
            Column.height(40);
            Column.backgroundColor(colorList[index].color);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create(item.image);
            Image.width(30);
            Image.height(30);
        }, Image);
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(item.category);
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

if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface Classification_Params {
    travelPathStack?: NavPathStack;
}
interface classification {
    category: string;
    image: Resource;
    page?: string;
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
        image: { "id": 50331690, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
        page: 'AttractionTicketPage'
    },
    {
        category: '必游榜单',
        image: { "id": 50331705, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
        page: 'MustVisitListPage'
    },
    {
        category: '动植物园',
        image: { "id": 50331694, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
        page: 'AnimalParkPage'
    },
    {
        category: '著名遗迹',
        image: { "id": 50331680, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
        page: 'FamousPlacePage'
    },
    {
        category: '一日游玩',
        image: { "id": 50331688, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
        page: 'OneDayTourPage'
    }
];
export class Classification extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__travelPathStack = this.initializeConsume('travelPathStack', "travelPathStack");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: Classification_Params) {
    }
    updateStateVars(params: Classification_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__travelPathStack.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__travelPathStack.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __travelPathStack: ObservedPropertyAbstractPU<NavPathStack>;
    get travelPathStack() {
        return this.__travelPathStack.get();
    }
    set travelPathStack(newValue: NavPathStack) {
        this.__travelPathStack.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            //景点分类
            Row.create();
            Row.debugLine("features/Travel/src/main/ets/view/Classficiation.ets(63:5)", "travel");
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
                        ListItem.onClick(() => {
                            this.travelPathStack.pushPathByName(classificationList[index].page, item.category);
                        });
                        ListItem.debugLine("features/Travel/src/main/ets/view/Classficiation.ets(65:9)", "travel");
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
            Column.debugLine("features/Travel/src/main/ets/view/Classficiation.ets(79:5)", "travel");
            Column.alignItems(HorizontalAlign.Center);
            Column.justifyContent(FlexAlign.Center);
            Column.width(70);
            Column.height(70);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.debugLine("features/Travel/src/main/ets/view/Classficiation.ets(80:7)", "travel");
            Column.alignItems(HorizontalAlign.Center);
            Column.justifyContent(FlexAlign.Center);
            Column.width(40);
            Column.borderRadius(50);
            Column.height(40);
            Column.backgroundColor(colorList[index].color);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create(item.image);
            Image.debugLine("features/Travel/src/main/ets/view/Classficiation.ets(81:9)", "travel");
            Image.width(30);
            Image.height(30);
        }, Image);
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(item.category);
            Text.debugLine("features/Travel/src/main/ets/view/Classficiation.ets(92:7)", "travel");
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

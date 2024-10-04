if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface InfoMessagePage_Params {
    readCount?: number;
    bookCount?: number;
    personName?: string;
}
import router from "@ohos:router";
export class InfoMessagePage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__readCount = this.createStorageProp('readCount', 0, "readCount");
        this.__bookCount = this.createStorageProp('bookCount', 0, "bookCount");
        this.__personName = this.createStorageProp('personName', '', "personName");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: InfoMessagePage_Params) {
    }
    updateStateVars(params: InfoMessagePage_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__readCount.purgeDependencyOnElmtId(rmElmtId);
        this.__bookCount.purgeDependencyOnElmtId(rmElmtId);
        this.__personName.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__readCount.aboutToBeDeleted();
        this.__bookCount.aboutToBeDeleted();
        this.__personName.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __readCount: ObservedPropertyAbstractPU<number>;
    get readCount() {
        return this.__readCount.get();
    }
    set readCount(newValue: number) {
        this.__readCount.set(newValue);
    }
    private __bookCount: ObservedPropertyAbstractPU<number>;
    get bookCount() {
        return this.__bookCount.get();
    }
    set bookCount(newValue: number) {
        this.__bookCount.set(newValue);
    }
    private __personName: ObservedPropertyAbstractPU<string>;
    get personName() {
        return this.__personName.get();
    }
    set personName(newValue: string) {
        this.__personName.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 10 });
            Column.backgroundColor('#ffe0dede');
            Column.width('100%');
            Column.height('100%');
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            //登录
            Row.create({ space: 10 });
            //登录
            Row.backgroundColor(Color.White);
            //登录
            Row.padding({
                top: 10,
                left: 10,
                right: 10
            });
            //登录
            Row.width('100%');
            //登录
            Row.height(100);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.personName) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Image.create({ "id": 33554494, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                        Image.width(70);
                        Image.height(70);
                        Image.borderRadius(35);
                    }, Image);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Text.create(this.personName);
                        Text.fontSize(18);
                        Text.height(25);
                    }, Text);
                    Text.pop();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Image.create({ "id": 33554492, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                        Image.width(70);
                        Image.height(70);
                        Image.borderRadius(35);
                    }, Image);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Text.create('登  录');
                        Text.fontSize(18);
                        Text.height(25);
                    }, Text);
                    Text.pop();
                });
            }
        }, If);
        If.pop();
        //登录
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width('100%');
            Row.height(60);
            Row.justifyContent(FlexAlign.Center);
            Row.padding({ top: 12, bottom: 12 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.margin({ right: 5 });
            Row.width('47.5%');
            Row.height(60);
            Row.backgroundColor(Color.White);
            Row.borderRadius(10);
            Row.padding({ top: 10, bottom: 10, left: 5 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('收藏');
            Text.fontSize(16);
            Text.margin({ left: 10, right: 20 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('0个');
            Text.fontSize(16);
            Text.fontColor('#ff838282');
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Blank.create();
        }, Blank);
        Blank.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('···');
            Text.margin({ right: 10 });
            Text.fontSize(16);
            Text.fontColor('#ff838282');
        }, Text);
        Text.pop();
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width('47.5%');
            Row.height(60);
            Row.backgroundColor(Color.White);
            Row.borderRadius(10);
            Row.padding({ top: 10, bottom: 10, right: 5 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('成就');
            Text.fontSize(16);
            Text.margin({ left: 10, right: 20 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('0个');
            Text.fontSize(16);
            Text.fontColor('#ff838282');
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Blank.create();
        }, Blank);
        Blank.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('···');
            Text.margin({ right: 10 });
            Text.fontSize(16);
            Text.fontColor('#ff838282');
        }, Text);
        Text.pop();
        Row.pop();
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 我的账户
            Column.create();
            // 我的账户
            Column.backgroundColor(Color.White);
            // 我的账户
            Column.borderRadius(10);
            // 我的账户
            Column.height(240);
            // 我的账户
            Column.width('95%');
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            List.create();
        }, List);
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
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Row.create();
                    Row.onClick(() => {
                        router.pushUrl({
                            url: 'pages/InfoPage'
                        });
                    });
                    Row.enabled(this.personName ? true : false);
                }, Row);
                this.myListItem.bind(this)({ "id": 33554490, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, "我的账户");
                Row.pop();
                ListItem.pop();
            };
            this.observeComponentCreation2(itemCreation2, ListItem);
            ListItem.pop();
        }
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
                this.myListItem.bind(this)({ "id": 33554513, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, "历史记录");
                ListItem.pop();
            };
            this.observeComponentCreation2(itemCreation2, ListItem);
            ListItem.pop();
        }
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
                this.myListItem.bind(this)({ "id": 33554516, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }, "设置");
                ListItem.pop();
            };
            this.observeComponentCreation2(itemCreation2, ListItem);
            ListItem.pop();
        }
        List.pop();
        // 我的账户
        Column.pop();
        Column.pop();
    }
    myListItem(image: Resource, title: string, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create({ space: 10 });
            Row.width('90%');
            Row.height(60);
            Row.backgroundColor(Color.White);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create(image);
            Image.width(30);
            Image.height(30);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(title);
            Text.fontSize(16);
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Blank.create();
        }, Blank);
        Blank.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(">");
            Text.fontSize(20);
            Text.fontColor('#ff919090');
        }, Text);
        Text.pop();
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Divider.create();
            Divider.width('100%');
            Divider.height(1);
            Divider.color('#ffb0aeae');
        }, Divider);
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

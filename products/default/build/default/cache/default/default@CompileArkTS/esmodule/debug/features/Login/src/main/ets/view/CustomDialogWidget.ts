if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface CustomDialogWidget_Params {
    controller?: CustomDialogController;
    hobbyItems?: HobbyItem[];
    hobbies?: string;
}
import HobbyItem from "@bundle:com.example.ictproject/default@Login/ets/viewmodel/HobbyItem";
import CommonUtils from "@bundle:com.example.ictproject/default@Login/ets/utils/CommonUtil";
import CommonConstants from "@bundle:com.example.ictproject/default@Login/ets/common/CommonConstants";
export default class CustomDialogWidget extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.controller = undefined;
        this.__hobbyItems = new ObservedPropertyObjectPU([], this, "hobbyItems");
        this.__hobbies = new SynchedPropertySimpleTwoWayPU(params.hobbies, this, "hobbies");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: CustomDialogWidget_Params) {
        if (params.controller !== undefined) {
            this.controller = params.controller;
        }
        if (params.hobbyItems !== undefined) {
            this.hobbyItems = params.hobbyItems;
        }
    }
    updateStateVars(params: CustomDialogWidget_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__hobbyItems.purgeDependencyOnElmtId(rmElmtId);
        this.__hobbies.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__hobbyItems.aboutToBeDeleted();
        this.__hobbies.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private controller: CustomDialogController;
    setController(ctr: CustomDialogController) {
        this.controller = ctr;
    }
    private __hobbyItems: ObservedPropertyObjectPU<HobbyItem[]>;
    get hobbyItems() {
        return this.__hobbyItems.get();
    }
    set hobbyItems(newValue: HobbyItem[]) {
        this.__hobbyItems.set(newValue);
    }
    private __hobbies: SynchedPropertySimpleTwoWayPU<string>;
    get hobbies() {
        return this.__hobbies.get();
    }
    set hobbies(newValue: string) {
        this.__hobbies.set(newValue);
    }
    aboutToAppear() {
        let context: Context = getContext(this);
        if (CommonUtils.isEmpty(context) || CommonUtils.isEmpty(context.resourceManager)) {
            console.error('message:', 'context or resourceManager为空！');
            return;
        }
        let manager = context.resourceManager;
        manager.getStringArrayValue({ "id": 33554441, "type": 10009, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }.id, (error, hobbyArray) => {
            if (!CommonUtils.isEmpty(error)) {
                console.error('error= ' + JSON.stringify(error));
            }
            else {
                hobbyArray.forEach((hobbyItem: string) => {
                    let tmpHobbyItem = new HobbyItem();
                    tmpHobbyItem.label = hobbyItem;
                    tmpHobbyItem.isChecked = false;
                    this.hobbyItems.push(tmpHobbyItem);
                });
            }
        });
    }
    /**
     * 设置爱好的值
     */
    setHobbiesValue(hobbyItems: HobbyItem[]) {
        const selectedHobbies = hobbyItems
            .filter(item => item.isChecked)
            .map(item => item.label);
        this.hobbies = selectedHobbies.join(', ');
    }
    //自行设计自定义弹窗
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width(CommonConstants.COMMON_DIALOG_WIDTH);
            Column.padding({
                top: { "id": 33554459, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                bottom: { "id": 33554457, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }
            });
            Column.borderRadius({ "id": 33554458, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Column.backgroundColor(Color.White);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 33554437, "type": 10003, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Text.fontColor({ "id": 33554445, "type": 10001, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Text.fontSize({ "id": 33554485, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Text.lineHeight({ "id": 33554487, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Text.fontWeight(500);
            Text.alignSelf(ItemAlign.Start);
            Text.margin({ left: { "id": 33554486, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" } });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            List.create();
            List.margin({
                top: { "id": 33554473, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                bottom: { "id": 33554472, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }
            });
            List.divider({
                strokeWidth: { "id": 33554460, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                color: { "id": 33554446, "type": 10001, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }
            });
            List.listDirection(Axis.Vertical);
            List.edgeEffect(EdgeEffect.None);
            List.width(CommonConstants.FULL_WIDTH);
            List.height({ "id": 33554476, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
        }, List);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const itemHobby = _item;
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
                            Row.height({ "id": 33554475, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                            Row.margin({
                                top: { "id": 33554477, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                                bottom: { "id": 33554474, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }
                            });
                        }, Row);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Text.create(itemHobby.label);
                            Text.fontSize({ "id": 33554471, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                            Text.fontColor({ "id": 33554445, "type": 10001, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                            Text.layoutWeight(CommonConstants.WEIGHT_ONE);
                            Text.textAlign(TextAlign.Start);
                            Text.fontWeight(500);
                            Text.margin({ left: { "id": 33554470, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" } });
                        }, Text);
                        Text.pop();
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Toggle.create({ type: ToggleType.Checkbox, isOn: false });
                            Toggle.onChange((isCheck) => {
                                itemHobby.isChecked = isCheck;
                            });
                            Toggle.width({ "id": 33554489, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                            Toggle.height({ "id": 33554489, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                            Toggle.margin({ right: { "id": 33554488, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" } });
                        }, Toggle);
                        Toggle.pop();
                        Row.pop();
                        ListItem.pop();
                    };
                    this.observeComponentCreation2(itemCreation2, ListItem);
                    ListItem.pop();
                }
            };
            this.forEachUpdateFunction(elmtId, this.hobbyItems, forEachItemGenFunction, (itemHobby: HobbyItem) => JSON.stringify(itemHobby.label), false, false);
        }, ForEach);
        ForEach.pop();
        List.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel({ "id": 33554432, "type": 10003, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            __Button__dialogButtonStyle();
            Button.onClick(() => {
                this.controller?.close();
            });
        }, Button);
        Button.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Blank.create();
            Blank.backgroundColor({ "id": 33554444, "type": 10001, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Blank.width({ "id": 33554454, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Blank.opacity({ "id": 33554453, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Blank.height({ "id": 33554452, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
        }, Blank);
        Blank.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel({ "id": 33554434, "type": 10003, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            __Button__dialogButtonStyle();
            Button.onClick(() => {
                this.setHobbiesValue(ObservedObject.GetRawObject(this.hobbyItems));
                this.controller?.close();
            });
        }, Button);
        Button.pop();
        Row.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
/*
 * 创建一个Button的通用样式
 * */
function __Button__dialogButtonStyle(): void {
    Button.fontSize('16fp');
    Button.fontColor('#007DFF');
    Button.layoutWeight(1);
    Button.backgroundColor(Color.White);
    Button.width('100%');
    Button.height(40);
}

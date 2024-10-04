if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface TextCommonWidget_Params {
    content?: string;
    textImage?: Resource;
    title?: Resource;
    // 点击事件回调
    onItemClick?;
}
import CommonConstants from "@bundle:com.example.ictproject/default@Login/ets/common/CommonConstants";
export default class TextCommonWidget extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__content = new SynchedPropertySimpleTwoWayPU(params.content, this, "content");
        this.textImage = undefined;
        this.title = undefined;
        this.onItemClick = () => { };
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: TextCommonWidget_Params) {
        if (params.textImage !== undefined) {
            this.textImage = params.textImage;
        }
        if (params.title !== undefined) {
            this.title = params.title;
        }
        if (params.onItemClick !== undefined) {
            this.onItemClick = params.onItemClick;
        }
    }
    updateStateVars(params: TextCommonWidget_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__content.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__content.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    // 显示内容
    private __content: SynchedPropertySimpleTwoWayPU<string
    // 文字标题左侧图片
    >;
    get content() {
        return this.__content.get();
    }
    set content(newValue: string) {
        this.__content.set(newValue);
    }
    // 文字标题左侧图片
    private textImage?: Resource;
    // 文本标题
    private title?: Resource;
    // 点击事件回调
    private onItemClick;
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.margin({ top: { "id": 33554481, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" } });
            Row.borderRadius({ "id": 33554480, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Row.backgroundColor(Color.White);
            Row.width(CommonConstants.COMMON_DIALOG_WIDTH);
            Row.height({ "id": 33554479, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Row.onClick(this.onItemClick);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create(this.textImage !== undefined ? this.textImage : '');
            Image.width({ "id": 33554482, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Image.height({ "id": 33554482, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Image.margin({ left: { "id": 33554461, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" } });
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.title);
            Text.fontSize({ "id": 33554484, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Text.margin({ left: { "id": 33554461, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" } });
            Text.height('100%');
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.content);
            Text.fontSize({ "id": 33554484, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Text.textAlign(TextAlign.End);
            Text.textOverflow({ overflow: TextOverflow.Ellipsis });
            Text.maxLines(1);
            Text.margin({
                left: { "id": 33554455, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                right: { "id": 33554456, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }
            });
            Text.layoutWeight(CommonConstants.WEIGHT_ONE);
            Text.width(CommonConstants.FULL_WIDTH);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 16777235, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Image.width({ "id": 33554449, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Image.height({ "id": 33554448, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Image.margin({ right: { "id": 33554450, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" } });
        }, Image);
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

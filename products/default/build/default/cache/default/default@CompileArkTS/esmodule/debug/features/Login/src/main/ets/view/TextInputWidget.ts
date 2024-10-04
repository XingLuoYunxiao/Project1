if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface TextInputWidget_Params {
    content?: string;
    inputImage?: Resource;
    hintText?: Resource;
}
import CommonConstants from "@bundle:com.example.ictproject/default@Login/ets/common/CommonConstants";
export default class TextInputWidget extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__content = new SynchedPropertySimpleTwoWayPU(params.content, this, "content");
        this.inputImage = undefined;
        this.hintText = undefined;
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: TextInputWidget_Params) {
        if (params.inputImage !== undefined) {
            this.inputImage = params.inputImage;
        }
        if (params.hintText !== undefined) {
            this.hintText = params.hintText;
        }
    }
    updateStateVars(params: TextInputWidget_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__content.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__content.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    //显示内容
    private __content: SynchedPropertySimpleTwoWayPU<string
    // 文本框左侧图片
    >;
    get content() {
        return this.__content.get();
    }
    set content(newValue: string) {
        this.__content.set(newValue);
    }
    // 文本框左侧图片
    private inputImage?: Resource;
    // 文本框提示
    private hintText?: Resource;
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.margin({ top: { "id": 33554468, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" } });
            Row.borderRadius({ "id": 33554467, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Row.backgroundColor(Color.White);
            Row.width(CommonConstants.COMMON_DIALOG_WIDTH);
            Row.height({ "id": 33554466, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create(this.inputImage !== undefined ? this.inputImage : '');
            Image.width({ "id": 33554463, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Image.height({ "id": 33554463, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Image.margin({ left: { "id": 33554462, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" } });
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            //placeholder设置无输入时的提示文本；text设置输入框当前的文本内容
            TextInput.create({ placeholder: this.hintText, text: this.content });
            //placeholder设置无输入时的提示文本；text设置输入框当前的文本内容
            TextInput.fontSize({ "id": 33554469, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            //placeholder设置无输入时的提示文本；text设置输入框当前的文本内容
            TextInput.padding({ left: { "id": 33554464, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" } });
            //placeholder设置无输入时的提示文本；text设置输入框当前的文本内容
            TextInput.placeholderColor({ "id": 33554447, "type": 10001, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            //placeholder设置无输入时的提示文本；text设置输入框当前的文本内容
            TextInput.backgroundColor(Color.White);
            //placeholder设置无输入时的提示文本；text设置输入框当前的文本内容
            TextInput.fontWeight(FontWeight.Normal);
            //placeholder设置无输入时的提示文本；text设置输入框当前的文本内容
            TextInput.fontStyle(FontStyle.Normal);
            //placeholder设置无输入时的提示文本；text设置输入框当前的文本内容
            TextInput.fontColor(Color.Black);
            //placeholder设置无输入时的提示文本；text设置输入框当前的文本内容
            TextInput.margin({ right: { "id": 33554465, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" } });
            //placeholder设置无输入时的提示文本；text设置输入框当前的文本内容
            TextInput.layoutWeight(CommonConstants.WEIGHT_ONE);
            //placeholder设置无输入时的提示文本；text设置输入框当前的文本内容
            TextInput.height({ "id": 33554483, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            //placeholder设置无输入时的提示文本；text设置输入框当前的文本内容
            TextInput.enableKeyboardOnFocus(false);
            //placeholder设置无输入时的提示文本；text设置输入框当前的文本内容
            TextInput.onChange((value) => {
                this.content = value; //获取TextInput组件的值
            });
        }, TextInput);
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

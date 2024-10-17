if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface CustomDialogComponent_Params {
    controller?: CustomDialogController;
    confirm?: () => void;
    cancel?: () => void;
}
export class CustomDialogComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.controller = undefined;
        this.confirm = undefined;
        this.cancel = undefined;
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: CustomDialogComponent_Params) {
        if (params.controller !== undefined) {
            this.controller = params.controller;
        }
        if (params.confirm !== undefined) {
            this.confirm = params.confirm;
        }
        if (params.cancel !== undefined) {
            this.cancel = params.cancel;
        }
    }
    updateStateVars(params: CustomDialogComponent_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private controller: CustomDialogController;
    setController(ctr: CustomDialogController) {
        this.controller = ctr;
    }
    private confirm?: () => void;
    private cancel?: () => void;
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 10 });
            Column.debugLine("features/Login/src/main/ets/view/CustomDialogComponent.ets(12:5)", "login");
            Column.width('100%');
            Column.padding(10);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 1.标题
            Text.create('欢迎使用古韵游踪APP');
            Text.debugLine("features/Login/src/main/ets/view/CustomDialogComponent.ets(14:7)", "login");
            // 1.标题
            Text.fontSize(20);
            // 1.标题
            Text.fontWeight(700);
        }, Text);
        // 1.标题
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 2.文本
            Text.create('我们充分尊重用户的隐私权，并按照法律要求和业界成熟的安全标准，为您的个人信息提供相应的安全保护措施');
            Text.debugLine("features/Login/src/main/ets/view/CustomDialogComponent.ets(18:7)", "login");
            // 2.文本
            Text.fontSize(16);
        }, Text);
        // 2.文本
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('隐私协议保护声明');
            Text.debugLine("features/Login/src/main/ets/view/CustomDialogComponent.ets(20:7)", "login");
            Text.width('100%');
            Text.fontColor('#ff3fcff1');
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('（以下简称“本声明”）以便您了解我们如何搜集、使用、披露、保护、存储及传输您的个人数据。请您仔细阅读本声明。如您有任何疑问，请告知我们。');
            Text.debugLine("features/Login/src/main/ets/view/CustomDialogComponent.ets(24:7)", "login");
            Text.fontSize(16);
            Text.fontColor(Color.Gray);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 3.按钮
            // 不同意
            Row.create();
            Row.debugLine("features/Login/src/main/ets/view/CustomDialogComponent.ets(29:7)", "login");
            // 3.按钮
            // 不同意
            Row.width('100%');
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel('不同意');
            Button.debugLine("features/Login/src/main/ets/view/CustomDialogComponent.ets(30:9)", "login");
            Button.width(150);
            Button.fontColor('#ff5e6060');
            Button.backgroundColor(Color.White);
            Button.onClick(() => {
                if (this.cancel)
                    this.cancel();
                this.controller.close();
            });
        }, Button);
        Button.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 同意
            Button.createWithLabel('同意');
            Button.debugLine("features/Login/src/main/ets/view/CustomDialogComponent.ets(41:9)", "login");
            // 同意
            Button.width(150);
            // 同意
            Button.fontColor('#ff3fcff1');
            // 同意
            Button.backgroundColor(Color.White);
            // 同意
            Button.onClick(() => {
                if (this.confirm)
                    this.confirm();
                this.controller.close();
            });
        }, Button);
        // 同意
        Button.pop();
        // 3.按钮
        // 不同意
        Row.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

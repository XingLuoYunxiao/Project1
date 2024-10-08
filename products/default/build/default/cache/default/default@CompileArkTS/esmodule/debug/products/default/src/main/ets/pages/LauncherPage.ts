if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface LauncherPage_Params {
    context?;
    controller?: CustomDialogController;
}
import router from "@ohos:router";
import { CustomDialogComponent } from "@bundle:com.example.ictproject/default@Login/Index";
import type common from "@ohos:app.ability.common";
import { PreferenceUtil as preferenceUtil } from "@bundle:com.example.ictproject/default@utils/Index";
const PREF_KEY = 'iReadUserKey';
class LauncherPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.context = getContext(this) as common.UIAbilityContext;
        this.controller = new CustomDialogController({
            builder: () => {
                let jsDialog = new CustomDialogComponent(this, {
                    confirm: (): void => this.onConfirm(),
                    cancel: (): void => this.exitApp()
                }, undefined, -1, () => { }, { page: "products/default/src/main/ets/pages/LauncherPage.ets", line: 13, col: 14 });
                jsDialog.setController(this.controller);
                ViewPU.create(jsDialog);
                let paramsLambda = () => {
                    return {
                        confirm: (): void => this.onConfirm(),
                        cancel: (): void => this.exitApp()
                    };
                };
                jsDialog.paramsGenerator_ = paramsLambda;
            }
        }, this);
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: LauncherPage_Params) {
        if (params.context !== undefined) {
            this.context = params.context;
        }
        if (params.controller !== undefined) {
            this.controller = params.controller;
        }
    }
    updateStateVars(params: LauncherPage_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private context;
    private controller: CustomDialogController;
    async onPageShow(): Promise<void> {
        // 加载首选项
        let isAgree = await preferenceUtil.getPreferenceValue(PREF_KEY, false);
        // 判断是否同意
        if (isAgree)
            // 同意跳转页面
            this.jumpToIndex();
        //不同意，退出
        else {
            this.controller.open();
        }
    }
    jumpToIndex() {
        setTimeout(() => {
            router.replaceUrl({
                url: 'pages/AdvertisingPage'
            });
        });
    }
    onConfirm() {
        // 1.保存首选项
        preferenceUtil.putPreferenceValue(PREF_KEY, true);
        // 2.跳转到主页
        this.jumpToIndex();
    }
    exitApp() {
        //退出
        this.context.terminateSelf();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 10 });
            Column.height('100%');
            Column.width('100%');
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 67108995, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Image.objectFit(ImageFit.Fill);
        }, Image);
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
    static getEntryName(): string {
        return "LauncherPage";
    }
}
registerNamedRoute(() => new LauncherPage(undefined, {}), "", { bundleName: "com.example.ictproject", moduleName: "default", pagePath: "pages/LauncherPage", pageFullPath: "products/default/src/main/ets/pages/LauncherPage", integratedHsp: "false" });

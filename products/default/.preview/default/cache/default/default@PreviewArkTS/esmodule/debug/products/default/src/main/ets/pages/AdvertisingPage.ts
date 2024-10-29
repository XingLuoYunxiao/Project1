if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface AdvertisingPage_Params {
    countDownSeconds?: number;
    timeId?: number;
}
import router from "@ohos:router";
class AdvertisingPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__countDownSeconds = new ObservedPropertySimplePU(4, this, "countDownSeconds");
        this.timeId = 0;
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: AdvertisingPage_Params) {
        if (params.countDownSeconds !== undefined) {
            this.countDownSeconds = params.countDownSeconds;
        }
        if (params.timeId !== undefined) {
            this.timeId = params.timeId;
        }
    }
    updateStateVars(params: AdvertisingPage_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__countDownSeconds.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__countDownSeconds.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __countDownSeconds: ObservedPropertySimplePU<number>;
    get countDownSeconds() {
        return this.__countDownSeconds.get();
    }
    set countDownSeconds(newValue: number) {
        this.__countDownSeconds.set(newValue);
    }
    private timeId: number;
    /**
     * 跳转到 APP 首页面
     */
    jumpToAppHomePage() {
        router.replaceUrl({
            url: 'pages/Index'
        });
    }
    judgeToCount() {
        this.countDownSeconds -= 1;
        if (this.countDownSeconds === 0) {
            this.jumpToAppHomePage();
        }
    }
    //页面显示
    onPageShow() {
        //setInterval()重复调用一个函数，在每次调用之间具有固定的时间延迟。
        this.timeId = setInterval(() => {
            this.judgeToCount();
        }, 1000);
    }
    //页面隐藏
    onPageHide() {
        //清除所有历史页面并仅保留堆栈顶部的当前页面
        //取消通过 setInterval()设置的重复定时任务
        clearInterval(this.timeId);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            //层叠布局
            Stack.create({ alignContent: Alignment.Top });
            Stack.debugLine("products/default/src/main/ets/pages/AdvertisingPage.ets(44:5)", "default");
            //层叠布局
            Stack.onClick(() => {
                router.replaceUrl({ url: 'pages/Index' });
                clearInterval(this.timeId);
            });
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 50331656, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Image.debugLine("products/default/src/main/ets/pages/AdvertisingPage.ets(45:7)", "default");
            Image.objectFit(ImageFit.Fill);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.debugLine("products/default/src/main/ets/pages/AdvertisingPage.ets(47:7)", "default");
            Row.width('100%');
            Row.justifyContent(FlexAlign.End);
            Row.padding({ right: 10, top: 20 });
            Row.margin({ top: 10 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(`跳过 ${this.countDownSeconds}`);
            Text.debugLine("products/default/src/main/ets/pages/AdvertisingPage.ets(48:9)", "default");
            Text.padding({ left: 18 });
            Text.width(100);
            Text.borderRadius(10);
            Text.border({ style: BorderStyle.Solid });
            Text.borderWidth(1);
            Text.fontSize(20);
        }, Text);
        Text.pop();
        Row.pop();
        //层叠布局
        Stack.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
    static getEntryName(): string {
        return "AdvertisingPage";
    }
}
registerNamedRoute(() => new AdvertisingPage(undefined, {}), "", { bundleName: "com.example.ictproject", moduleName: "default", pagePath: "pages/AdvertisingPage", pageFullPath: "products/default/src/main/ets/pages/AdvertisingPage", integratedHsp: "false" });

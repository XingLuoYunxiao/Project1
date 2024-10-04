if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface LoginPage_Params {
    controller?: webview.WebviewController;
}
import webview from "@ohos:web.webview";
import router from "@ohos:router";
import { getToken } from "@bundle:com.example.ictproject/default@Login/ets/utils/AccountUtil";
import { getPersonalMsg } from "@bundle:com.example.ictproject/default@Login/ets/utils/MessageUtil";
export class LoginPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.controller = new webview.WebviewController();
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: LoginPage_Params) {
        if (params.controller !== undefined) {
            this.controller = params.controller;
        }
    }
    updateStateVars(params: LoginPage_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private controller: webview.WebviewController;
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Web.create({ src: { "id": 0, "type": 30000, params: ['Index.html'], "bundleName": "com.example.ictproject", "moduleName": "default" }, controller: this.controller });
            Web.onLoadIntercept((event) => {
                let url: string = event.data.getRequestUrl();
                console.log("url: ", url);
                // 正则表达式，用于匹配 code 参数
                const regex = /code=([^&]+)/;
                // 使用正则表达式匹配 URL 中的 code 参数
                const match = regex.exec(url);
                // 检查是否有匹配项，并提取 code 的值
                const code = match ? match[1] : null;
                console.log(code);
                if (url.indexOf('http://ireadbook.html') === 0 && code) {
                    this.handleLogin(code);
                    // 跳转APP主界面
                    router.back();
                    return true;
                }
                return false;
            });
        }, Web);
        Column.pop();
    }
    async handleLogin(code: string) {
        try {
            let tokenValue = await getToken(code);
            if (tokenValue && tokenValue.id_token) {
                let personalMsg = await getPersonalMsg(tokenValue.id_token);
                if (personalMsg && personalMsg.display_name) {
                    AppStorage.setOrCreate('personName', personalMsg.display_name);
                    AppStorage.setOrCreate('readCount', 40); // 示例数据
                    AppStorage.setOrCreate('bookCount', 28); // 示例数据
                }
            }
        }
        catch (error) {
            console.error('Login failed:', error);
        }
    }
    rerender() {
        this.updateDirtyElements();
    }
}

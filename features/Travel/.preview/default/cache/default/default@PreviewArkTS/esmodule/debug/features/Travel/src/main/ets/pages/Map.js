if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { MapComponent } from '@bundle:com.huawei.hms.mapservice.kit/mapLibrary/ets/MapComponent';
class HuaweiMapDemo extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.TAG = "HuaweiMapDemo";
        this.mapOptions = undefined;
        this.callback = undefined;
        this.mapController = undefined;
        this.mapEventManager = undefined;
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.TAG !== undefined) {
            this.TAG = params.TAG;
        }
        if (params.mapOptions !== undefined) {
            this.mapOptions = params.mapOptions;
        }
        if (params.callback !== undefined) {
            this.callback = params.callback;
        }
        if (params.mapController !== undefined) {
            this.mapController = params.mapController;
        }
        if (params.mapEventManager !== undefined) {
            this.mapEventManager = params.mapEventManager;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    aboutToAppear() {
        // 地图初始化参数，设置地图中心点坐标及层级
        this.mapOptions = {
            position: {
                target: {
                    latitude: 39.9,
                    longitude: 116.4
                },
                zoom: 10
            }
        };
        // 地图初始化的回调
        this.callback = async (err, mapController) => {
            if (!err) {
                // 获取地图的控制器类，用来操作地图
                this.mapController = mapController;
                this.mapEventManager = this.mapController.getEventManager();
                let callback = () => {
                    console.info(this.TAG, `on-mapLoad`);
                };
                this.mapEventManager.on("mapLoad", callback);
            }
        };
    }
    // 页面每次显示时触发一次，包括路由过程、应用进入前台等场景，仅@Entry装饰的自定义组件生效
    onPageShow() {
        // 将地图切换到前台
        if (this.mapController !== undefined) {
            this.mapController.show();
        }
    }
    // 页面每次隐藏时触发一次，包括路由过程、应用进入后台等场景，仅@Entry装饰的自定义组件生效。
    onPageHide() {
        // 将地图切换到后台
        if (this.mapController !== undefined) {
            this.mapController.hide();
        }
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create();
            Stack.debugLine("features/Travel/src/main/ets/pages/Map.ets(56:5)", "travel");
            Stack.height('100%');
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.width('100%');
            __Common__.height('100%');
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    // 调用MapComponent组件初始化地图
                    MapComponent(this, { mapOptions: this.mapOptions, mapCallback: this.callback }, undefined, elmtId, () => { }, { page: "features/Travel/src/main/ets/pages/Map.ets", line: 58, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            mapOptions: this.mapOptions,
                            mapCallback: this.callback
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
            }, { name: "MapComponent" });
        }
        __Common__.pop();
        Stack.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
    static getEntryName() {
        return "HuaweiMapDemo";
    }
}
registerNamedRoute(() => new HuaweiMapDemo(undefined, {}), "", { bundleName: "com.example.ictproject", moduleName: "Travel", pagePath: "pages/Map", pageFullPath: "features/Travel/src/main/ets/pages/Map", integratedHsp: "false" });
//# sourceMappingURL=Map.js.map
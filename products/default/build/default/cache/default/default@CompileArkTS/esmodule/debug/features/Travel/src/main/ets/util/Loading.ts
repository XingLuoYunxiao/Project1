if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface LoadingAnimation_Params {
    currentStep?: number;
    travelPathStack?: NavPathStack;
    steps?: string[];
    intervalID?: number;
}
import type { LoadParams } from "../pages/FamousPlacePage";
export class LoadingAnimation extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__currentStep = new ObservedPropertySimplePU(0, this, "currentStep");
        this.__travelPathStack = this.initializeConsume('travelPathStack', "travelPathStack");
        this.steps = ['正在为您智能规划路径', '正在生成虚拟人为您讲解', '已完成'];
        this.intervalID = -1;
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: LoadingAnimation_Params) {
        if (params.currentStep !== undefined) {
            this.currentStep = params.currentStep;
        }
        if (params.steps !== undefined) {
            this.steps = params.steps;
        }
        if (params.intervalID !== undefined) {
            this.intervalID = params.intervalID;
        }
    }
    updateStateVars(params: LoadingAnimation_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__currentStep.purgeDependencyOnElmtId(rmElmtId);
        this.__travelPathStack.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__currentStep.aboutToBeDeleted();
        this.__travelPathStack.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __currentStep: ObservedPropertySimplePU<number>;
    get currentStep() {
        return this.__currentStep.get();
    }
    set currentStep(newValue: number) {
        this.__currentStep.set(newValue);
    }
    private __travelPathStack: ObservedPropertyAbstractPU<NavPathStack>;
    get travelPathStack() {
        return this.__travelPathStack.get();
    }
    set travelPathStack(newValue: NavPathStack) {
        this.__travelPathStack.set(newValue);
    }
    private steps: string[];
    private intervalID: number;
    aboutToAppear() {
        let object = this.travelPathStack.getParamByName('LoadingAnimation')[0] as LoadParams;
        this.intervalID = setInterval(() => {
            if (this.currentStep < this.steps.length - 1) {
                this.currentStep++;
            }
            else {
                clearInterval(this.intervalID);
                this.travelPathStack.replacePathByName(object.param1, object.param2);
            }
        }, 1000); // 每秒更新一次，总共3秒
    }
    aboutToDisappear() {
        clearInterval(this.intervalID);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            NavDestination.create(() => {
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
                    Column.width('100%');
                    Column.height('100%');
                    Column.backgroundImage({ "id": 67108903, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                    Column.backgroundImageSize({ width: '100%', height: '100%' });
                    Column.backgroundColor(Color.White);
                    Column.justifyContent(FlexAlign.Center);
                }, Column);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Progress.create({
                        value: ((this.currentStep + 1) * 100) / this.steps.length,
                        total: 100,
                        type: ProgressType.Linear
                    });
                    Progress.color('#ff62eae8');
                    Progress.width('80%');
                    Progress.height(20);
                    Progress.style({ strokeWidth: 10 });
                    Progress.margin({ bottom: 20 });
                }, Progress);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Row.create();
                    Row.width('80%');
                    Row.justifyContent(FlexAlign.Start);
                }, Row);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    If.create();
                    if (this.currentStep < this.steps.length - 1) {
                        this.ifElseBranchUpdateFunction(0, () => {
                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                LoadingProgress.create();
                                LoadingProgress.color(Color.White);
                                LoadingProgress.width(30);
                                LoadingProgress.height(40);
                                LoadingProgress.margin({ right: 10 });
                            }, LoadingProgress);
                        });
                    }
                    else {
                        this.ifElseBranchUpdateFunction(1, () => {
                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                Image.create({ "id": 67108888, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                                Image.width(20);
                                Image.height(20);
                                Image.margin({ right: 10 });
                            }, Image);
                        });
                    }
                }, If);
                If.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create(this.steps[this.currentStep]);
                    Text.fontSize(18);
                    Text.fontColor(Color.White);
                    Text.fontWeight(FontWeight.Bold);
                }, Text);
                Text.pop();
                Row.pop();
                Column.pop();
            }, { moduleName: "default", pagePath: "features/Travel/src/main/ets/util/Loading" });
            NavDestination.hideTitleBar(true);
        }, NavDestination);
        NavDestination.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

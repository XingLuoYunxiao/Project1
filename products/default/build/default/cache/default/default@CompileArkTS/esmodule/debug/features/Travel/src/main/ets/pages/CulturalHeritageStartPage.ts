if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface CulturalHeritageStartPage_Params {
    travelPathStack?: NavPathStack;
    MasterpieceIArr?: MasterpieceI[];
    AncientGameIArr?: AncientGames[];
}
import { FlyingFlowerOrderPage } from "@bundle:com.example.ictproject/default@Travel/ets/pages/FlyingFlowerOrderPage";
import { ttf } from "@bundle:com.example.ictproject/default@Travel/ets/util/ttf";
import { tsetMasterPieceIArr } from "@bundle:com.example.ictproject/default@Travel/ets/model/MasterpieceI";
import type { MasterpieceI } from "@bundle:com.example.ictproject/default@Travel/ets/model/MasterpieceI";
import { tsetAncientGamesIArr } from "@bundle:com.example.ictproject/default@Travel/ets/model/AncientGamesI";
import type { AncientGames } from "@bundle:com.example.ictproject/default@Travel/ets/model/AncientGamesI";
export class CulturalHeritageStartPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__travelPathStack = new ObservedPropertyObjectPU(new NavPathStack(), this, "travelPathStack");
        this.addProvidedVar("travelPathStack", this.__travelPathStack, false);
        this.MasterpieceIArr = tsetMasterPieceIArr();
        this.AncientGameIArr = tsetAncientGamesIArr();
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: CulturalHeritageStartPage_Params) {
        if (params.travelPathStack !== undefined) {
            this.travelPathStack = params.travelPathStack;
        }
        if (params.MasterpieceIArr !== undefined) {
            this.MasterpieceIArr = params.MasterpieceIArr;
        }
        if (params.AncientGameIArr !== undefined) {
            this.AncientGameIArr = params.AncientGameIArr;
        }
    }
    updateStateVars(params: CulturalHeritageStartPage_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__travelPathStack.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__travelPathStack.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __travelPathStack: ObservedPropertyObjectPU<NavPathStack>;
    get travelPathStack() {
        return this.__travelPathStack.get();
    }
    set travelPathStack(newValue: NavPathStack) {
        this.__travelPathStack.set(newValue);
    }
    private MasterpieceIArr: MasterpieceI[];
    private AncientGameIArr: AncientGames[];
    aboutToAppear(): void {
        ttf('STXINGKAFont', 'STXINGKA.TTF');
        console.log('testlog' + this.MasterpieceIArr.length);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Navigation.create(this.travelPathStack, { moduleName: "default", pagePath: "features/Travel/src/main/ets/pages/CulturalHeritageStartPage", isUserCreateStack: true });
            Navigation.navDestination({ builder: this.travelStartRouter.bind(this) });
            Navigation.hideTitleBar(true);
            Navigation.mode(NavigationMode.Stack);
        }, Navigation);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('95%');
            Column.height('100%');
            Column.backgroundColor('#F1F3F5');
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            //TODO 非遗天地
            Row.create();
            //TODO 非遗天地
            Row.width('100%');
            //TODO 非遗天地
            Row.height(50);
            //TODO 非遗天地
            Row.alignItems(VerticalAlign.Center);
            //TODO 非遗天地
            Row.justifyContent(FlexAlign.Center);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('非遗天地');
            Text.fontSize(30);
            Text.fontFamily('STXINGKAFont');
            Text.letterSpacing(10);
        }, Text);
        Text.pop();
        //TODO 非遗天地
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Blank.create();
            Blank.size({ height: 20 });
        }, Blank);
        Blank.pop();
        //TODO 经典著作
        this.secondaryHeader.bind(this)('经典著作');
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Blank.create();
            Blank.height(10);
        }, Blank);
        Blank.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            //TODO 经典著作格栅
            Grid.create();
            //TODO 经典著作格栅
            Grid.width('100%');
            //TODO 经典著作格栅
            Grid.height(250);
            //TODO 经典著作格栅
            Grid.columnsTemplate('1fr 1fr 1fr');
            //TODO 经典著作格栅
            Grid.rowsTemplate('1fr 1fr');
            //TODO 经典著作格栅
            Grid.backgroundColor(Color.White);
            //TODO 经典著作格栅
            Grid.borderRadius(15);
        }, Grid);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const MasterpieceI = _item;
                {
                    const itemCreation2 = (elmtId, isInitialRender) => {
                        GridItem.create(() => { }, false);
                        GridItem.onClick(() => {
                            this.travelPathStack.pushPathByName(MasterpieceI.id, null);
                        });
                    };
                    const observedDeepRender = () => {
                        this.observeComponentCreation2(itemCreation2, GridItem);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Column.create({ space: 10 });
                        }, Column);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Image.create(MasterpieceI.img);
                            Image.size({ height: 40, width: 40 });
                            Image.backgroundColor(Color.Green);
                            Image.borderRadius(20);
                        }, Image);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Text.create(MasterpieceI.id);
                            Text.fontSize(15);
                        }, Text);
                        Text.pop();
                        Column.pop();
                        GridItem.pop();
                    };
                    observedDeepRender();
                }
            };
            this.forEachUpdateFunction(elmtId, this.MasterpieceIArr, forEachItemGenFunction);
        }, ForEach);
        ForEach.pop();
        //TODO 经典著作格栅
        Grid.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Blank.create();
            Blank.size({ height: 20 });
        }, Blank);
        Blank.pop();
        //TODO 游识古韵
        this.secondaryHeader.bind(this)('游识古韵');
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Blank.create();
            Blank.height(10);
        }, Blank);
        Blank.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            //TODO 游识古韵格栅
            Grid.create();
            //TODO 游识古韵格栅
            Grid.width('100%');
            //TODO 游识古韵格栅
            Grid.height(250);
            //TODO 游识古韵格栅
            Grid.columnsTemplate('1fr 1fr 1fr');
            //TODO 游识古韵格栅
            Grid.rowsTemplate('1fr 1fr');
            //TODO 游识古韵格栅
            Grid.backgroundColor(Color.White);
            //TODO 游识古韵格栅
            Grid.borderRadius(15);
        }, Grid);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const AncientGameI = _item;
                {
                    const itemCreation2 = (elmtId, isInitialRender) => {
                        GridItem.create(() => { }, false);
                        GridItem.onClick(() => {
                            console.log('testlog' + AncientGameI.path);
                            this.travelPathStack.pushPathByName(AncientGameI.path, null);
                        });
                    };
                    const observedDeepRender = () => {
                        this.observeComponentCreation2(itemCreation2, GridItem);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Column.create({ space: 10 });
                        }, Column);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Image.create(AncientGameI.img);
                            Image.size({ height: 40, width: 40 });
                            Image.backgroundColor(Color.Green);
                            Image.borderRadius(20);
                        }, Image);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Text.create(AncientGameI.id);
                            Text.fontSize(15);
                        }, Text);
                        Text.pop();
                        Column.pop();
                        GridItem.pop();
                    };
                    observedDeepRender();
                }
            };
            this.forEachUpdateFunction(elmtId, this.AncientGameIArr, forEachItemGenFunction);
        }, ForEach);
        ForEach.pop();
        //TODO 游识古韵格栅
        Grid.pop();
        Column.pop();
        Navigation.pop();
    }
    travelStartRouter(path: string, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (path === 'PoetryPage') {
                this.ifElseBranchUpdateFunction(0, () => {
                });
            }
            else if (path === 'IntangibleCulturalHeritagePage') {
                this.ifElseBranchUpdateFunction(1, () => {
                });
            }
            else if (path === 'FlyingFlowerOrderPage') {
                this.ifElseBranchUpdateFunction(2, () => {
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new FlyingFlowerOrderPage(this, {}, undefined, elmtId, () => { }, { page: "features/Travel/src/main/ets/pages/CulturalHeritageStartPage.ets", line: 116, col: 7 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {};
                                };
                                componentCall.paramsGenerator_ = paramsLambda;
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                            }
                        }, { name: "FlyingFlowerOrderPage" });
                    }
                });
            }
            else if (path === '...') {
                this.ifElseBranchUpdateFunction(3, () => {
                });
            }
            else {
                this.ifElseBranchUpdateFunction(4, () => {
                });
            }
        }, If);
        If.pop();
    }
    //TODO 副标题
    secondaryHeader(msg: string, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width('100%');
            Row.justifyContent(FlexAlign.Start);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(msg);
            Text.fontSize(35);
            Text.fontFamily('STXINGKAFont');
        }, Text);
        Text.pop();
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

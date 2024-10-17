if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { lvFootnoteController } from './controller/lvFootnoteController';
import handleTableText from './handle/handleTableText';
import { lvCompositeComponent } from './lvCompositeComponent';
export class lvTableComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.o = new ObservedPropertySimplePU("", this, "text");
        this.h1 = new ObservedPropertyObjectPU(null, this, "dialogController");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.text !== undefined) {
            this.text = params.text;
        }
        if (params.dialogController !== undefined) {
            this.dialogController = params.dialogController;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.o.purgeDependencyOnElmtId(rmElmtId);
        this.h1.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.o.aboutToBeDeleted();
        this.h1.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get text() {
        return this.o.get();
    }
    set text(newValue) {
        this.o.set(newValue);
    }
    get dialogController() {
        return this.h1.get();
    }
    set dialogController(newValue) {
        this.h1.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            List.create();
            List.listDirection(Axis.Horizontal);
            List.width('100%');
            List.margin({ bottom: 5 });
        }, List);
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
                    Column.create();
                }, Column);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    ForEach.create();
                    const forEachItemGenFunction = (_item, p14) => {
                        const item = _item;
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Column.create();
                            Column.alignItems(HorizontalAlign.Start);
                            Column.width(item.split('|').length - 2 == 3 ? '100%' : (item.split('|').length - 2) * 30 + '%');
                        }, Column);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            If.create();
                            if (handleTableText(this.text)[1].split('-').length - 1 < 2) {
                                this.ifElseBranchUpdateFunction(0, () => {
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        Text.create(item);
                                        Text.fontSize(15);
                                    }, Text);
                                    Text.pop();
                                });
                            }
                            else {
                                this.ifElseBranchUpdateFunction(1, () => {
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        If.create();
                                        if (p14 === 0) {
                                            this.ifElseBranchUpdateFunction(0, () => {
                                                n13.bind(this)(item, this.dialogController);
                                            });
                                        }
                                        else {
                                            this.ifElseBranchUpdateFunction(1, () => {
                                            });
                                        }
                                    }, If);
                                    If.pop();
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        If.create();
                                        if (p14 > 1 && p14 < handleTableText(this.text).length - 2) {
                                            this.ifElseBranchUpdateFunction(0, () => {
                                                o13.bind(this)(item, p14, this.dialogController);
                                            });
                                        }
                                        else {
                                            this.ifElseBranchUpdateFunction(1, () => {
                                            });
                                        }
                                    }, If);
                                    If.pop();
                                });
                            }
                        }, If);
                        If.pop();
                        Column.pop();
                    };
                    this.forEachUpdateFunction(elmtId, handleTableText(this.text), forEachItemGenFunction, undefined, true, false);
                }, ForEach);
                ForEach.pop();
                Column.pop();
                ListItem.pop();
            };
            this.observeComponentCreation2(itemCreation2, ListItem);
            ListItem.pop();
        }
        List.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
function n13(text, z13, parent = null) {
    (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender) => {
        Row.create();
        Row.width("100%");
        Row.backgroundColor("#F5F7FA");
    }, Row);
    (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender) => {
        ForEach.create();
        const forEachItemGenFunction = _item => {
            const item = _item;
            (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender) => {
                __Common__.create();
                __Common__.padding({ top: 8, bottom: 8 });
                __Common__.layoutWeight(1);
            }, __Common__);
            {
                (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender) => {
                    if (isInitialRender) {
                        let componentCall = new lvCompositeComponent(parent ? parent : this, {
                            footnoteController: lvFootnoteController,
                            text: item.trim(),
                            fontWeight: FontWeight.Bold,
                            textOverflow: TextOverflow.MARQUEE,
                            maxLines: 5,
                            dialogController: z13
                        }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/utils/lvTableComponent.ets", line: 68, f1: 7 });
                        ViewPU.create(componentCall);
                        let paramsLambda = () => {
                            return {
                                footnoteController: lvFootnoteController,
                                text: item.trim(),
                                fontWeight: FontWeight.Bold,
                                textOverflow: TextOverflow.MARQUEE,
                                maxLines: 5,
                                dialogController: z13
                            };
                        };
                        componentCall.paramsGenerator_ = paramsLambda;
                    }
                    else {
                        (parent ? parent : this).updateStateVarsOfChildByElmtId(elmtId, {
                            footnoteController: lvFootnoteController
                        });
                    }
                }, { name: "lvCompositeComponent" });
            }
            __Common__.pop();
        };
        (parent ? parent : this).forEachUpdateFunction(elmtId, text.split('|').filter((item) => item.trim()), forEachItemGenFunction);
    }, ForEach);
    ForEach.pop();
    Row.pop();
}
function o13(text, p13, q13, parent = null) {
    (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender) => {
        Row.create();
        Row.width("100%");
        Row.backgroundColor(p13 % 2 === 0 ? "#fff" : "#fafafa");
    }, Row);
    (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender) => {
        ForEach.create();
        const forEachItemGenFunction = _item => {
            const item = _item;
            (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender) => {
                __Common__.create();
                __Common__.layoutWeight(1);
                __Common__.padding({ top: 8, bottom: 8 });
            }, __Common__);
            {
                (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender) => {
                    if (isInitialRender) {
                        let componentCall = new lvCompositeComponent(parent ? parent : this, {
                            footnoteController: lvFootnoteController,
                            text: item.trim(),
                            textOverflow: TextOverflow.Ellipsis,
                            maxLines: 5,
                            dialogController: q13
                        }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/utils/lvTableComponent.ets", line: 85, f1: 7 });
                        ViewPU.create(componentCall);
                        let paramsLambda = () => {
                            return {
                                footnoteController: lvFootnoteController,
                                text: item.trim(),
                                textOverflow: TextOverflow.Ellipsis,
                                maxLines: 5,
                                dialogController: q13
                            };
                        };
                        componentCall.paramsGenerator_ = paramsLambda;
                    }
                    else {
                        (parent ? parent : this).updateStateVarsOfChildByElmtId(elmtId, {
                            footnoteController: lvFootnoteController
                        });
                    }
                }, { name: "lvCompositeComponent" });
            }
            __Common__.pop();
        };
        (parent ? parent : this).forEachUpdateFunction(elmtId, text.split('|').filter((item) => item.trim()), forEachItemGenFunction);
    }, ForEach);
    ForEach.pop();
    Row.pop();
}

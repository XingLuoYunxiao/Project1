if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { lvText } from '../domain/LvText';
import { lvFootnoteController } from './controller/lvFootnoteController';
import { lvQuoteComponent } from './lvQuoteComponent';
import { lvCompositeComponent } from './lvCompositeComponent';
export class lvTabulateComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.o = new ObservedPropertySimplePU("", this, "text");
        this.g1 = new ObservedPropertyObjectPU(lvText, this, "nText");
        this.h1 = new ObservedPropertyObjectPU(null, this, "dialogController");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.text !== undefined) {
            this.text = params.text;
        }
        if (params.nText !== undefined) {
            this.nText = params.nText;
        }
        if (params.dialogController !== undefined) {
            this.dialogController = params.dialogController;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.o.purgeDependencyOnElmtId(rmElmtId);
        this.g1.purgeDependencyOnElmtId(rmElmtId);
        this.h1.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.o.aboutToBeDeleted();
        this.g1.aboutToBeDeleted();
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
    get nText() {
        return this.g1.get();
    }
    set nText(newValue) {
        this.g1.set(newValue);
    }
    get dialogController() {
        return this.h1.get();
    }
    set dialogController(newValue) {
        this.h1.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.text.trim().slice(0, 2) == '* ' || this.text.trim().slice(0, 2) == '+ ' ||
                this.text.trim().slice(0, 2) == '- ') {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Row.create();
                        Row.alignItems(VerticalAlign.Top);
                    }, Row);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Row.create();
                        Row.height(this.nText.getTextLineHeight());
                        Row.margin({ right: 5 });
                    }, Row);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        If.create();
                        if (this.text.split(this.text.trim().slice(0, 1))[0].length >= 0 &&
                            this.text.split(this.text.trim().slice(0, 1))[0].length < 4) {
                            this.ifElseBranchUpdateFunction(0, () => {
                                this.observeComponentCreation2((elmtId, isInitialRender) => {
                                    Row.create();
                                    Row.width(5);
                                    Row.height(5);
                                    Row.backgroundColor('#000');
                                    Row.borderRadius(100);
                                    Row.margin({ left: 20 + this.text.split(this.text.trim().slice(0, 1))[0].length * 5 });
                                }, Row);
                                Row.pop();
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
                        if (this.text.split(this.text.trim().slice(0, 1))[0].length >= 4 &&
                            this.text.split(this.text.trim().slice(0, 1))[0].length < 8) {
                            this.ifElseBranchUpdateFunction(0, () => {
                                this.observeComponentCreation2((elmtId, isInitialRender) => {
                                    Row.create();
                                    Row.width(5);
                                    Row.height(5);
                                    Row.borderRadius(100);
                                    Row.border({
                                        width: 1
                                    });
                                    Row.margin({ left: 20 + this.text.split(this.text.trim().slice(0, 1))[0].length * 5 });
                                }, Row);
                                Row.pop();
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
                        if (this.text.split(this.text.trim().slice(0, 1))[0].length >= 8) {
                            this.ifElseBranchUpdateFunction(0, () => {
                                this.observeComponentCreation2((elmtId, isInitialRender) => {
                                    Row.create();
                                    Row.width(5);
                                    Row.height(5);
                                    Row.backgroundColor('#000');
                                    Row.margin({ left: 20 + this.text.split(this.text.trim().slice(0, 1))[0].length * 5 });
                                }, Row);
                                Row.pop();
                            });
                        }
                        else {
                            this.ifElseBranchUpdateFunction(1, () => {
                            });
                        }
                    }, If);
                    If.pop();
                    Row.pop();
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        If.create();
                        if (this.text.split(this.text.trim().slice(0, 1))[1].trim().slice(0, 2) == "> ") {
                            this.ifElseBranchUpdateFunction(0, () => {
                                {
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        if (isInitialRender) {
                                            let componentCall = new lvQuoteComponent(this, { text: this.text.trim().slice(2) }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/utils/lvTabulateComponent.ets", line: 49, f1: 11 });
                                            ViewPU.create(componentCall);
                                            let paramsLambda = () => {
                                                return {
                                                    text: this.text.trim().slice(2)
                                                };
                                            };
                                            componentCall.paramsGenerator_ = paramsLambda;
                                        }
                                        else {
                                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                                        }
                                    }, { name: "lvQuoteComponent" });
                                }
                            });
                        }
                        else {
                            this.ifElseBranchUpdateFunction(1, () => {
                                {
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        if (isInitialRender) {
                                            let componentCall = new lvCompositeComponent(this, {
                                                footnoteController: lvFootnoteController,
                                                text: this.text.split(this.text.trim().slice(0, 1))[1],
                                                dialogController: this.dialogController
                                            }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/utils/lvTabulateComponent.ets", line: 51, f1: 11 });
                                            ViewPU.create(componentCall);
                                            let paramsLambda = () => {
                                                return {
                                                    footnoteController: lvFootnoteController,
                                                    text: this.text.split(this.text.trim().slice(0, 1))[1],
                                                    dialogController: this.dialogController
                                                };
                                            };
                                            componentCall.paramsGenerator_ = paramsLambda;
                                        }
                                        else {
                                            this.updateStateVarsOfChildByElmtId(elmtId, {
                                                footnoteController: lvFootnoteController
                                            });
                                        }
                                    }, { name: "lvCompositeComponent" });
                                }
                            });
                        }
                    }, If);
                    If.pop();
                    Row.pop();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        __Common__.create();
                        __Common__.margin({ left: 20 });
                    }, __Common__);
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new lvCompositeComponent(this, {
                                    footnoteController: lvFootnoteController,
                                    text: this.text.trim(),
                                    dialogController: this.dialogController
                                }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/utils/lvTabulateComponent.ets", line: 59, f1: 7 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {
                                        footnoteController: lvFootnoteController,
                                        text: this.text.trim(),
                                        dialogController: this.dialogController
                                    };
                                };
                                componentCall.paramsGenerator_ = paramsLambda;
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {
                                    footnoteController: lvFootnoteController
                                });
                            }
                        }, { name: "lvCompositeComponent" });
                    }
                    __Common__.pop();
                });
            }
        }, If);
        If.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

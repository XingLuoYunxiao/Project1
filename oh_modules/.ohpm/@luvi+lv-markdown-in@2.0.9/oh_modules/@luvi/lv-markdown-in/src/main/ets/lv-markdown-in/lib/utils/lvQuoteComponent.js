if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { lvQuote } from '../domain/LvQuote';
import { lvFootnoteController } from './controller/lvFootnoteController';
import { lvCompositeComponent } from './lvCompositeComponent';
export class lvQuoteComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.o = new ObservedPropertySimplePU("", this, "text");
        this.a2 = new ObservedPropertyObjectPU(lvQuote, this, "nQuote");
        this.h1 = new ObservedPropertyObjectPU(null, this, "dialogController");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.text !== undefined) {
            this.text = params.text;
        }
        if (params.nQuote !== undefined) {
            this.nQuote = params.nQuote;
        }
        if (params.dialogController !== undefined) {
            this.dialogController = params.dialogController;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.o.purgeDependencyOnElmtId(rmElmtId);
        this.a2.purgeDependencyOnElmtId(rmElmtId);
        this.h1.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.o.aboutToBeDeleted();
        this.a2.aboutToBeDeleted();
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
    get nQuote() {
        return this.a2.get();
    }
    set nQuote(newValue) {
        this.a2.set(newValue);
    }
    get dialogController() {
        return this.h1.get();
    }
    set dialogController(newValue) {
        this.h1.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.alignItems(HorizontalAlign.Start);
            Column.width('100%');
            Column.backgroundColor(this.nQuote.getBackgroundColor());
            Column.padding({
                left: 8,
                top: 12,
                right: 7,
                bottom: 12
            });
            Column.border({
                color: {
                    left: this.nQuote.getBorderColor()
                },
                style: {
                    left: BorderStyle.Solid
                },
                width: {
                    left: '4',
                    right: '0',
                    top: '0',
                    bottom: '0'
                }
            });
        }, Column);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new x12(this, { text: this.text.trim(), dialogController: this.dialogController }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/utils/lvQuoteComponent.ets", line: 13, f1: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: this.text.trim(),
                            dialogController: this.dialogController
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
            }, { name: "ft" });
        }
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
class x12 extends ViewPU {
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
            If.create();
            if (this.text.slice(0, 3) == "> >") {
                this.ifElseBranchUpdateFunction(0, () => {
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new lvQuoteComponent(this, { text: this.text.slice(1).trim(), dialogController: this.dialogController }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/utils/lvQuoteComponent.ets", line: 52, f1: 7 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {
                                        text: this.text.slice(1).trim(),
                                        dialogController: this.dialogController
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
                                    dialogController: this.dialogController,
                                    footnoteController: lvFootnoteController,
                                    text: this.text.slice(1)
                                }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/utils/lvQuoteComponent.ets", line: 54, f1: 7 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {
                                        dialogController: this.dialogController,
                                        footnoteController: lvFootnoteController,
                                        text: this.text.slice(1)
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
    }
    rerender() {
        this.updateDirtyElements();
    }
}

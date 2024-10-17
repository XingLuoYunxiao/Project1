if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { lvText } from '../domain/LvText';
import { lvFootnoteController } from './controller/lvFootnoteController';
import { lvCompositeComponent } from './lvCompositeComponent';
export class lvCheckboxComponent extends ViewPU {
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
            Row.create();
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Toggle.create({
                type: ToggleType.Checkbox,
                isOn: (this.text.split('- [')[1].split(']')[0] == 'X' || this.text.split('- [')[1].split(']')[0] == 'x') ?
                    true : false
            });
        }, Toggle);
        Toggle.pop();
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new lvCompositeComponent(this, {
                        footnoteController: lvFootnoteController,
                        text: this.text.split('- [')[1].split(']')[1],
                        dialogController: this.dialogController
                    }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/utils/lvCheckboxComponent.ets", line: 18, f1: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            footnoteController: lvFootnoteController,
                            text: this.text.split('- [')[1].split(']')[1],
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
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

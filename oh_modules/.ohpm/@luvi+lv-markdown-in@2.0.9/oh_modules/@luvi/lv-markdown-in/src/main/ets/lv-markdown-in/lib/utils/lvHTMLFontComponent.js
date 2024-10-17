if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { lvText } from '../domain/LvText';
import { lvFootnoteController } from './controller/lvFootnoteController';
import { lvCompositeComponent } from './lvCompositeComponent';
export class lvHTMLFontComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.o = new ObservedPropertySimplePU("", this, "text");
        this.g1 = new ObservedPropertyObjectPU(lvText, this, "nText");
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
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.o.purgeDependencyOnElmtId(rmElmtId);
        this.g1.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.o.aboutToBeDeleted();
        this.g1.aboutToBeDeleted();
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
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Flex.create({
                wrap: FlexWrap.Wrap,
                direction: FlexDirection.Row
            });
        }, Flex);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.text.trim().indexOf('<font') !== -1 && this.text.trim().indexOf('font>') !== -1) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Text.create(this.text.indexOf(">") !== -1 ?
                            this.text.slice(this.text.trim().indexOf('>') + 1, this.text.trim().slice(5).indexOf('<') + 5) :
                            null);
                        Text.fontColor(this.text.indexOf("color=") !== -1 ? this.text.slice(this.text.trim().indexOf('color=') + 7)
                            .split(this.text.slice(this.text.trim().indexOf('color=') + 6, this.text.trim().indexOf('color=') + 7))[0] :
                            this.nText.getTextColor());
                        Text.fontSize(this.text.indexOf("size=") !== -1 ?
                            9 + (Number(this.text.slice(this.text.trim().indexOf('size=') + 6)
                                .split(this.text.slice(this.text.trim().indexOf('size=') + 5, this.text.trim().indexOf('size=') + 6))[0]) - 1) * 3 :
                            this.nText.getTextSize());
                    }, Text);
                    Text.pop();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                    {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            if (isInitialRender) {
                                let componentCall = new lvCompositeComponent(this, {
                                    footnoteController: lvFootnoteController,
                                    text: this.text
                                }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/utils/lvHTMLFontComponent.ets", line: 28, f1: 9 });
                                ViewPU.create(componentCall);
                                let paramsLambda = () => {
                                    return {
                                        footnoteController: lvFootnoteController,
                                        text: this.text
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
        Flex.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

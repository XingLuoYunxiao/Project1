if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import lvHyperlinkBuilder from './lvHyperlinkComponent';
import handleUrlText from './handle/handleUrlText';
import { lvText } from '../domain/LvText';
import { lvLink } from '../domain/LvLink';
export class lvUrlComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.o = new ObservedPropertySimplePU("", this, "text");
        this.u1 = new ObservedPropertySimplePU("", this, "uri");
        this.g1 = new ObservedPropertyObjectPU(lvText, this, "nText");
        this.v1 = new ObservedPropertySimplePU("", this, "fontSize");
        this.o1 = new ObservedPropertySimplePU(FontWeight.Normal, this, "fontWeight");
        this.t1 = new ObservedPropertyObjectPU(lvLink, this, "nLink");
        this.h1 = new ObservedPropertyObjectPU(null, this, "dialogController");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.text !== undefined) {
            this.text = params.text;
        }
        if (params.uri !== undefined) {
            this.uri = params.uri;
        }
        if (params.nText !== undefined) {
            this.nText = params.nText;
        }
        if (params.fontSize !== undefined) {
            this.fontSize = params.fontSize;
        }
        if (params.fontWeight !== undefined) {
            this.fontWeight = params.fontWeight;
        }
        if (params.nLink !== undefined) {
            this.nLink = params.nLink;
        }
        if (params.dialogController !== undefined) {
            this.dialogController = params.dialogController;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.o.purgeDependencyOnElmtId(rmElmtId);
        this.u1.purgeDependencyOnElmtId(rmElmtId);
        this.g1.purgeDependencyOnElmtId(rmElmtId);
        this.v1.purgeDependencyOnElmtId(rmElmtId);
        this.o1.purgeDependencyOnElmtId(rmElmtId);
        this.t1.purgeDependencyOnElmtId(rmElmtId);
        this.h1.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.o.aboutToBeDeleted();
        this.u1.aboutToBeDeleted();
        this.g1.aboutToBeDeleted();
        this.v1.aboutToBeDeleted();
        this.o1.aboutToBeDeleted();
        this.t1.aboutToBeDeleted();
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
    get uri() {
        return this.u1.get();
    }
    set uri(newValue) {
        this.u1.set(newValue);
    }
    get nText() {
        return this.g1.get();
    }
    set nText(newValue) {
        this.g1.set(newValue);
    }
    get fontSize() {
        return this.v1.get();
    }
    set fontSize(newValue) {
        this.v1.set(newValue);
    }
    get fontWeight() {
        return this.o1.get();
    }
    set fontWeight(newValue) {
        this.o1.set(newValue);
    }
    get nLink() {
        return this.t1.get();
    }
    set nLink(newValue) {
        this.t1.set(newValue);
    }
    get dialogController() {
        return this.h1.get();
    }
    set dialogController(newValue) {
        this.h1.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create();
            Text.lineHeight(this.nText.getTextLineHeight());
        }, Text);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const item = _item;
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    If.create();
                    if (item.trim().slice(0, 1) == '[' && this.text.trim().indexOf('](') !== -1 &&
                        item.trim().indexOf(')') !== -1) {
                        this.ifElseBranchUpdateFunction(0, () => {
                            lvHyperlinkBuilder.bind(this)(String(item.split('](')[0]).split('[')[1], String(item.split('](')[1]).split(')')[0], this.nLink, this.fontSize, this.fontWeight, this.dialogController);
                        });
                    }
                    else {
                        this.ifElseBranchUpdateFunction(1, () => {
                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                Span.create(item);
                                Span.fontSize(this.fontSize || this.nText.getTextSize());
                                Span.fontColor(this.nText.getTextColor());
                                Span.fontWeight(this.fontWeight);
                            }, Span);
                        });
                    }
                }, If);
                If.pop();
            };
            this.forEachUpdateFunction(elmtId, handleUrlText(this.text), forEachItemGenFunction);
        }, ForEach);
        ForEach.pop();
        Text.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

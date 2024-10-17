if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { lvLink } from '../domain/LvLink';
import { lvText } from '../domain/LvText';
import { mdRegister } from './common';
import { SP_TYPE } from './constant';
import { lvFootnoteController } from './controller/lvFootnoteController';
function g9(item) {
    const e11 = /\[([^\]]+)\]\(([^)]+)\)/;
    const match = item.match(e11) || [];
    let content = "";
    let f11 = "";
    let g11 = "";
    if (match.length > 0) {
        content = match[1].slice(1);
        if ((match[2].indexOf('"') !== -1) || (match[2].indexOf(`'`) !== -1)) {
            f11 = match[2].slice(0, match[2].indexOf('"') || match[2].indexOf(`'`));
        }
        else {
            f11 = match[2];
        }
        const h11 = match[2].match(/"([^"]+)"/) || [];
        if (h11.length > 0) {
            g11 = h11[1];
        }
    }
    return { content: content, m1: f11, n1: g11 };
}
export class lvFootnoteView extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.e1 = new ObservedPropertyObjectPU(lvFootnoteController, this, "footnoteController");
        this.h1 = new ObservedPropertyObjectPU(null, this, "dialogController");
        this.g1 = new ObservedPropertyObjectPU(lvText, this, "nText");
        this.t1 = new ObservedPropertyObjectPU(lvLink, this, "nLink");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.footnoteController !== undefined) {
            this.footnoteController = params.footnoteController;
        }
        if (params.dialogController !== undefined) {
            this.dialogController = params.dialogController;
        }
        if (params.nText !== undefined) {
            this.nText = params.nText;
        }
        if (params.nLink !== undefined) {
            this.nLink = params.nLink;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.e1.purgeDependencyOnElmtId(rmElmtId);
        this.h1.purgeDependencyOnElmtId(rmElmtId);
        this.g1.purgeDependencyOnElmtId(rmElmtId);
        this.t1.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.e1.aboutToBeDeleted();
        this.h1.aboutToBeDeleted();
        this.g1.aboutToBeDeleted();
        this.t1.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get footnoteController() {
        return this.e1.get();
    }
    set footnoteController(newValue) {
        this.e1.set(newValue);
    }
    get dialogController() {
        return this.h1.get();
    }
    set dialogController(newValue) {
        this.h1.set(newValue);
    }
    get nText() {
        return this.g1.get();
    }
    set nText(newValue) {
        this.g1.set(newValue);
    }
    get nLink() {
        return this.t1.get();
    }
    set nLink(newValue) {
        this.t1.set(newValue);
    }
    openUrl(uri) {
        if (mdRegister.HandleHyperlink(uri)) {
            this.nLink.setLinkUrl(uri);
            this.dialogController?.open();
        }
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.footnoteController.getFootnoteList()) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Column.create();
                        Column.alignItems(HorizontalAlign.Start);
                        Column.margin({ top: 30, bottom: 10 });
                    }, Column);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        ForEach.create();
                        const forEachItemGenFunction = (_item, u) => {
                            const item = _item;
                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                If.create();
                                if (item) {
                                    this.ifElseBranchUpdateFunction(0, () => {
                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                            Row.create();
                                            Row.alignItems(VerticalAlign.Top);
                                        }, Row);
                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                            Text.create(`[${u + 1}]`);
                                            Text.fontColor("#ff9b9b9b");
                                            Text.fontSize(13);
                                            Text.width(30);
                                            Text.lineHeight(this.nText.getTextLineHeight());
                                            Text.fontWeight(FontWeight.Lighter);
                                        }, Text);
                                        Text.pop();
                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                            Row.create();
                                            Row.layoutWeight(1);
                                        }, Row);
                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                            Text.create();
                                            Text.lineHeight(this.nText.getTextLineHeight());
                                            Text.fontSize(this.nText.getTextSize());
                                        }, Text);
                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                            Span.create((g9(item).n1 || g9(item).content) + ": ");
                                            Span.fontColor("#F56C6C");
                                        }, Span);
                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                            Span.create(g9(item).m1);
                                            Span.fontColor(this.nText.getTextColor());
                                            Span.fontStyle(FontStyle.Italic);
                                            Span.onClick(() => {
                                                if (g9(item).m1.trim().slice(0, 4) == "http") {
                                                    this.openUrl(g9(item).m1.trim());
                                                }
                                            });
                                        }, Span);
                                        Text.pop();
                                        Row.pop();
                                        Row.pop();
                                    });
                                }
                                else {
                                    this.ifElseBranchUpdateFunction(1, () => {
                                    });
                                }
                            }, If);
                            If.pop();
                        };
                        this.forEachUpdateFunction(elmtId, this.footnoteController.getFootnoteList().split(SP_TYPE.SPK), forEachItemGenFunction, undefined, true, false);
                    }, ForEach);
                    ForEach.pop();
                    Column.pop();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                });
            }
        }, If);
        If.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { lvImage } from '../domain/LvImage';
import { mdRegister } from './common';
import { lvFootnoteController } from './controller/lvFootnoteController';
import { lvCompositeComponent } from './lvCompositeComponent';
export class lvHTMLImgComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.o = new ObservedPropertySimplePU("", this, "text");
        this.m = new ObservedPropertyObjectPU(lvImage, this, "nImage");
        this.h1 = new ObservedPropertyObjectPU(null, this, "dialogController");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.text !== undefined) {
            this.text = params.text;
        }
        if (params.nImage !== undefined) {
            this.nImage = params.nImage;
        }
        if (params.dialogController !== undefined) {
            this.dialogController = params.dialogController;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.o.purgeDependencyOnElmtId(rmElmtId);
        this.m.purgeDependencyOnElmtId(rmElmtId);
        this.h1.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.o.aboutToBeDeleted();
        this.m.aboutToBeDeleted();
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
    get nImage() {
        return this.m.get();
    }
    set nImage(newValue) {
        this.m.set(newValue);
    }
    get dialogController() {
        return this.h1.get();
    }
    set dialogController(newValue) {
        this.h1.set(newValue);
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
            if (this.text.trim().indexOf('<img ') !== -1) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Image.create(this.text.indexOf("<img ") !== -1 ? this.text.slice(this.text.trim().indexOf('src=') + 5)
                            .split(this.text.slice(this.text.trim().indexOf('src=') + 4, this.text.trim().indexOf('src=') + 5))[0] : null);
                        Image.width(this.text.indexOf("width=") !== -1 ? this.text.slice(this.text.trim().indexOf('width=') + 7)
                            .split(this.text.slice(this.text.trim().indexOf('width=') + 6, this.text.trim().indexOf('width=') + 7))[0] :
                            null);
                        Image.height(this.text.indexOf("height=") !== -1 ? this.text.slice(this.text.trim().indexOf('height=') + 8)
                            .split(this.text.slice(this.text.trim().indexOf('height=') + 7, this.text.trim().indexOf('height=') + 8))[0] : null);
                        Image.objectFit(ImageFit.Auto);
                        Image.borderRadius(5);
                        Image.margin({
                            top: 5, bottom: 5
                        });
                        Image.onClick(() => {
                            let uri = this.text.indexOf("<img ") !== -1 ?
                                this.text.slice(this.text.trim().indexOf('src=') + 5)
                                    .split(this.text.slice(this.text.trim().indexOf('src=') + 4, this.text.trim().indexOf('src=') + 5))[0] :
                                "";
                            if (mdRegister.HandleHyperlink(uri)) {
                                this.nImage.setImgUrl(uri);
                                this.dialogController?.open();
                            }
                        });
                    }, Image);
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
                                }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/utils/lvHTMLImgComponent.ets", line: 42, f1: 9 });
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

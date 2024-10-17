if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { lvImage } from '../domain/LvImage';
import { mdRegister } from './common';
import { lvFootnoteController } from './controller/lvFootnoteController';
import handleImgText from './handle/handleImgText';
import { lvCompositeComponent } from './lvCompositeComponent';
export class lvImgComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.o = new ObservedPropertySimplePU("", this, "text");
        this.m = new ObservedPropertyObjectPU(lvImage, this, "nImage");
        this.h1 = new ObservedPropertyObjectPU(null, this, "dialogController");
        this.w1 = new ObservedPropertySimplePU(this.nImage.getImgWidth(), this, "imgWidth");
        this.z1 = new ObservedPropertySimplePU(this.nImage.getImgHeight(), this, "imgHeight");
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
        if (params.imgWidth !== undefined) {
            this.imgWidth = params.imgWidth;
        }
        if (params.imgHeight !== undefined) {
            this.imgHeight = params.imgHeight;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.o.purgeDependencyOnElmtId(rmElmtId);
        this.m.purgeDependencyOnElmtId(rmElmtId);
        this.h1.purgeDependencyOnElmtId(rmElmtId);
        this.w1.purgeDependencyOnElmtId(rmElmtId);
        this.z1.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.o.aboutToBeDeleted();
        this.m.aboutToBeDeleted();
        this.h1.aboutToBeDeleted();
        this.w1.aboutToBeDeleted();
        this.z1.aboutToBeDeleted();
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
    get imgWidth() {
        return this.w1.get();
    }
    set imgWidth(newValue) {
        this.w1.set(newValue);
    }
    get imgHeight() {
        return this.z1.get();
    }
    set imgHeight(newValue) {
        this.z1.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Flex.create({
                wrap: FlexWrap.Wrap,
                direction: FlexDirection.Row
            });
        }, Flex);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const item = _item;
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    If.create();
                    if (item.trim().slice(0, 2) == '![' && item.trim().slice(-1) == ')' && item.trim().indexOf('](') !== -1) {
                        this.ifElseBranchUpdateFunction(0, () => {
                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                Image.create(item.split('](')[1].slice(0, -1));
                                Image.alt({ "id": -1, "type": 30000, params: ["imgs/imgErr.png"], "bundleName": "__harDefaultBundleName__", "moduleName": "__harDefaultModuleName__" });
                                Image.interpolation(ImageInterpolation.Medium);
                                Image.width(this.imgWidth);
                                Image.height(this.imgHeight);
                                Image.objectFit(ImageFit.Auto);
                                Image.borderRadius(5);
                                Image.margin({
                                    top: 5, bottom: 5
                                });
                                Image.onClick(() => {
                                    let uri = item.split('](')[1].slice(0, -1);
                                    if (mdRegister.HandleImage(uri)) {
                                        this.nImage.setImgUrl(uri);
                                        this.dialogController?.open();
                                    }
                                });
                                Image.onError(() => {
                                    this.imgWidth = 20;
                                    this.imgHeight = 20;
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
                                            text: item
                                        }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/utils/lvImgComponent.ets", line: 44, f1: 11 });
                                        ViewPU.create(componentCall);
                                        let paramsLambda = () => {
                                            return {
                                                footnoteController: lvFootnoteController,
                                                text: item
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
            };
            this.forEachUpdateFunction(elmtId, handleImgText(this.text), forEachItemGenFunction);
        }, ForEach);
        ForEach.pop();
        Flex.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { lvImage } from '../domain/LvImage';
export class ImgControl extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.controller = undefined;
        this.m = new ObservedPropertyObjectPU(lvImage, this, "nImage");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.controller !== undefined) {
            this.controller = params.controller;
        }
        if (params.nImage !== undefined) {
            this.nImage = params.nImage;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.m.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.m.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    setController(ctr) {
        this.controller = ctr;
    }
    get nImage() {
        return this.m.get();
    }
    set nImage(newValue) {
        this.m.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.height("100%");
            Column.justifyContent(FlexAlign.Center);
            Column.onClick(() => {
                this.controller.close();
            });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            List.create();
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
                    Image.create(this.nImage.getImgUrl());
                    Image.width("100%");
                    Image.objectFit(ImageFit.Auto);
                    Image.interpolation(ImageInterpolation.Medium);
                }, Image);
                ListItem.pop();
            };
            this.observeComponentCreation2(itemCreation2, ListItem);
            ListItem.pop();
        }
        List.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

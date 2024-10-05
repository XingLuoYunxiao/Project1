if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { bufferToString } from '@bundle:com.example.ictproject/quickstart/ets/util/BufferUtil';
export class Banner extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__bannerList = new ObservedPropertyObjectPU([], this, "bannerList");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.bannerList !== undefined) {
            this.bannerList = params.bannerList;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__bannerList.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__bannerList.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get bannerList() {
        return this.__bannerList.get();
    }
    set bannerList(newValue) {
        this.__bannerList.set(newValue);
    }
    aboutToAppear() {
        this.getBannerDataFromJSON();
    }
    getBannerDataFromJSON() {
        getContext(this).resourceManager.getRawFileContent('BannerData.json').then(value => {
            this.bannerList = JSON.parse(bufferToString(value));
        });
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Swiper.create();
            Swiper.debugLine("features/quickstart/src/main/ets/view/Banner.ets(19:5)", "quickstart");
            Swiper.autoPlay(true);
            Swiper.loop(true);
            Swiper.indicator(new DotIndicator()
                .color('#1a000000')
                .selectedColor('#0A59F7'));
        }, Swiper);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const item = _item;
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Image.create({ "id": -1, "type": -1, params: [item.imageSrc], "bundleName": "com.example.ictproject", "moduleName": "quickstart" });
                    Image.debugLine("features/quickstart/src/main/ets/view/Banner.ets(21:9)", "quickstart");
                    Image.objectFit(ImageFit.Contain);
                    Image.width('100%');
                    Image.borderRadius(16);
                    Image.padding({ top: 11, left: 16, right: 16 });
                }, Image);
            };
            this.forEachUpdateFunction(elmtId, this.bannerList, forEachItemGenFunction, (item) => item.id, false, false);
        }, ForEach);
        ForEach.pop();
        Swiper.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=Banner.js.map
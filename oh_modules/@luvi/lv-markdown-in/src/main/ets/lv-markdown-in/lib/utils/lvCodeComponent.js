if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { codeStyle } from './codeColorOn';
import handleCodeLib from './handle/handleCodeLib';
import pasteboard from '@ohos.pasteboard';
import promptAction from '@ohos.promptAction';
import { lvCode } from '../domain/LvCode';
const y6 = async (text) => {
    let t8 = pasteboard.createPlainTextData(text);
    let u8 = pasteboard.getSystemPasteboard();
    await u8.setData(t8).then((data) => {
        promptAction.showToast({
            message: '复制成功'
        });
    }).catch((err) => {
        promptAction.showToast({
            message: '复制成功'
        });
    });
};
let z6 = /(\.\w+\()/g;
export class lvCodeComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.o = new ObservedPropertySimplePU("", this, "text");
        this.i1 = new ObservedPropertyObjectPU(lvCode, this, "nCode");
        this.j1 = new ObservedPropertySimplePU(11, this, "rowLimit");
        this.l1 = new ObservedPropertySimplePU(10, this, "idxWidth");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.text !== undefined) {
            this.text = params.text;
        }
        if (params.nCode !== undefined) {
            this.nCode = params.nCode;
        }
        if (params.rowLimit !== undefined) {
            this.rowLimit = params.rowLimit;
        }
        if (params.idxWidth !== undefined) {
            this.idxWidth = params.idxWidth;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.o.purgeDependencyOnElmtId(rmElmtId);
        this.i1.purgeDependencyOnElmtId(rmElmtId);
        this.j1.purgeDependencyOnElmtId(rmElmtId);
        this.l1.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.o.aboutToBeDeleted();
        this.i1.aboutToBeDeleted();
        this.j1.aboutToBeDeleted();
        this.l1.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get text() {
        return this.o.get();
    }
    set text(newValue) {
        this.o.set(newValue);
    }
    get nCode() {
        return this.i1.get();
    }
    set nCode(newValue) {
        this.i1.set(newValue);
    }
    get rowLimit() {
        return this.j1.get();
    }
    set rowLimit(newValue) {
        this.j1.set(newValue);
    }
    get idxWidth() {
        return this.l1.get();
    }
    set idxWidth(newValue) {
        this.l1.set(newValue);
    }
    calcRow() {
        let len = this.text.split("\n").slice(1, -2).length;
        if (len >= 10) {
            this.idxWidth = 20;
        }
        if (len >= 100) {
            this.idxWidth = 30;
        }
        return len;
    }
    showMore() {
        this.rowLimit = -2;
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create({
                alignContent: Alignment.TopEnd
            });
            Stack.width('100%');
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.margin({
                top: 10, right: 10
            });
            Column.padding({
                top: 4,
                bottom: 4,
                left: 8,
                right: 8
            });
            Column.borderRadius(6);
            Column.backgroundColor(this.nCode.getTheme() == "dark" ? "rgba(0,0,0,0.7)" : "rgba(0, 0, 0, 0.03)");
            Column.zIndex(2);
            Column.onClick(() => {
                y6(this.text);
            });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.nCode.getTheme() == "dark") {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Image.create({ "id": -1, "type": 30000, params: ["imgs/copy_w1.png"], "bundleName": "__harDefaultBundleName__", "moduleName": "__harDefaultModuleName__" });
                        Image.width(18);
                        Image.height(18);
                        Image.interpolation(ImageInterpolation.Medium);
                    }, Image);
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Image.create({ "id": -1, "type": 30000, params: ["imgs/copy_g1.png"], "bundleName": "__harDefaultBundleName__", "moduleName": "__harDefaultModuleName__" });
                        Image.width(18);
                        Image.height(18);
                        Image.interpolation(ImageInterpolation.Medium);
                    }, Image);
                });
            }
        }, If);
        If.pop();
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create({ alignContent: Alignment.Bottom });
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            List.create();
            List.width('100%');
            List.listDirection(Axis.Horizontal);
            List.backgroundColor(this.nCode.getTheme() == "dark" ? "#282C35" : "#FAFAFA");
            List.borderRadius(6);
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
                ListItem.padding({
                    top: 15,
                    bottom: 15,
                    left: 10,
                    right: 10
                });
            };
            const deepRenderFunction = (elmtId, isInitialRender) => {
                itemCreation(elmtId, isInitialRender);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Flex.create({
                        wrap: FlexWrap.Wrap
                    });
                    Flex.width("150%");
                    Flex.margin({ bottom: (this.calcRow() >= 10 && this.rowLimit != -2) ? 20 : 0 });
                }, Flex);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    ForEach.create();
                    const forEachItemGenFunction = (_item, s7) => {
                        const t7 = _item;
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Row.create();
                            Row.width("100%");
                            Row.height(23);
                        }, Row);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            If.create();
                            if (this.nCode.getIndexState()) {
                                this.ifElseBranchUpdateFunction(0, () => {
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        Text.create(s7 + 1 + "");
                                        Text.width(this.idxWidth);
                                        Text.maxLines(1);
                                        Text.textOverflow({ overflow: TextOverflow.Ellipsis });
                                        Text.fontSize(13);
                                        Text.fontColor(this.nCode.getTheme() == "dark" ? "#80f1f1f1" : "#6d666666");
                                        Text.textAlign(TextAlign.End);
                                    }, Text);
                                    Text.pop();
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        Row.create();
                                        Row.margin({ left: 8, right: 8 });
                                        Row.width(1);
                                        Row.height(23);
                                        Row.backgroundColor(this.nCode.getTheme() == "dark" ? "#51f1f1f1" : "#77888888");
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
                            if (t7.trim().slice(0, 2) == "//") {
                                this.ifElseBranchUpdateFunction(0, () => {
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        Text.create(t7);
                                        Text.fontColor(this.nCode.getTheme() == "dark" ? "#80f1f1f1" : "#8b666666");
                                        Text.fontSize(14);
                                    }, Text);
                                    Text.pop();
                                });
                            }
                            else {
                                this.ifElseBranchUpdateFunction(1, () => {
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        ForEach.create();
                                        const forEachItemGenFunction = _item => {
                                            const item = _item;
                                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                                If.create();
                                                if (z6.test(item)) {
                                                    this.ifElseBranchUpdateFunction(0, () => {
                                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                                            Text.create(item.slice(0, -1));
                                                            Text.fontColor(this.nCode.getTheme() == "dark" ? "#4FC1FF" : "#ff108edd");
                                                            Text.fontSize(14);
                                                        }, Text);
                                                        Text.pop();
                                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                                            Text.create("(");
                                                            Text.fontColor(codeStyle["("]);
                                                            Text.fontSize(14);
                                                        }, Text);
                                                        Text.pop();
                                                    });
                                                }
                                                else {
                                                    this.ifElseBranchUpdateFunction(1, () => {
                                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                                            ForEach.create();
                                                            const forEachItemGenFunction = _item => {
                                                                const item = _item;
                                                                this.observeComponentCreation2((elmtId, isInitialRender) => {
                                                                    Text.create(item);
                                                                    Text.fontColor(codeStyle[item] ||
                                                                        (this.nCode.getTheme() == "dark" ? "#ffd9d9d9" : "#ff676767"));
                                                                    Text.fontSize(14);
                                                                }, Text);
                                                                Text.pop();
                                                            };
                                                            this.forEachUpdateFunction(elmtId, handleCodeLib(item), forEachItemGenFunction);
                                                        }, ForEach);
                                                        ForEach.pop();
                                                    });
                                                }
                                            }, If);
                                            If.pop();
                                        };
                                        this.forEachUpdateFunction(elmtId, t7.split(/(\w+|\.\w+\()/g), forEachItemGenFunction);
                                    }, ForEach);
                                    ForEach.pop();
                                });
                            }
                        }, If);
                        If.pop();
                        Row.pop();
                    };
                    this.forEachUpdateFunction(elmtId, this.calcRow() >= 10 ? this.text.split("\n").slice(1, this.rowLimit) :
                        this.text.split("\n").slice(1, -2), forEachItemGenFunction, undefined, true, false);
                }, ForEach);
                ForEach.pop();
                Flex.pop();
                ListItem.pop();
            };
            this.observeComponentCreation2(itemCreation2, ListItem);
            ListItem.pop();
        }
        List.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.calcRow() >= 10 && this.rowLimit != -2) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Row.create();
                        Row.justifyContent(FlexAlign.Center);
                        Row.width(60);
                        Row.height(25);
                        Row.borderRadius(99);
                        Row.backgroundColor("#5cffffff");
                        Row.margin({ bottom: 7 });
                        Row.onClick(() => {
                            this.showMore();
                        });
                    }, Row);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Image.create({ "id": -1, "type": 30000, params: ["imgs/down_b.png"], "bundleName": "__harDefaultBundleName__", "moduleName": "__harDefaultModuleName__" });
                        Image.width(20);
                        Image.height(20);
                    }, Image);
                    Row.pop();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                });
            }
        }, If);
        If.pop();
        Stack.pop();
        Stack.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

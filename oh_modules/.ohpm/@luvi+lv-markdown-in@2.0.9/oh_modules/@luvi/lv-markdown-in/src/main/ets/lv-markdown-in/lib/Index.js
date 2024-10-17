if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { LV_MD_CONTENT_TYPE, LV_MD_DATA_TYPE } from './utils/constant';
import { WebControl } from './webControl';
import { ImgControl } from './imgControl';
import { determineTitle } from './utils/determine/detTitle';
import { determineImg } from './utils/determine/detImg';
import { determineQuote } from './utils/determine/detQuote';
import { determineLine } from './utils/determine/detLine';
import { determineTable } from './utils/determine/detTable';
import { determineCode } from './utils/determine/detCode';
import { determineCheckbox } from './utils/determine/detCheckbox';
import { determineTabulate } from './utils/determine/detTabulate';
import { determineHTMLIMG, determineHTMLFONT } from './utils/determine/detHTMLEL';
import { lvTitleComponent } from './utils/lvTitleComponent';
import { lvCompositeComponent } from './utils/lvCompositeComponent';
import { lvTableComponent } from './utils/lvTableComponent';
import { lvCodeComponent } from './utils/lvCodeComponent';
import { lvImgComponent } from './utils/lvImgComponent';
import lvLineBuilder from './utils/lvLineBuilder';
import { lvQuoteComponent } from './utils/lvQuoteComponent';
import { lvCheckboxComponent } from './utils/lvCheckboxComponent';
import { lvTabulateComponent } from './utils/lvTabulateComponent';
import { lvHTMLImgComponent } from './utils/lvHTMLImgComponent';
import { lvHTMLFontComponent } from './utils/lvHTMLFontComponent';
import buffer from "@ohos.buffer";
import fs from "@ohos.file.fs";
import { lvFootnoteView } from './utils/lvFootnoteComponent';
import { LvFootnoteController } from './utils/controller/lvFootnoteController';
import { html2md } from '@luvi/html2md';
export default class lvMarkdownIn extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.o = new SynchedPropertySimpleOneWayPU(params.text, this, "text");
        this.t = new SynchedPropertySimpleOneWayPU(params.loadMode, this, "loadMode");
        this.u = new SynchedPropertySimpleOneWayPU(params.rawfilePath, this, "rawfilePath");
        this.a1 = new SynchedPropertySimpleOneWayPU(params.sandboxPath, this, "sandboxPath");
        this.b1 = new ObservedPropertyObjectPU(null, this, "context");
        this.loadCallBack = {
            success(msg) {
            },
            fail(msg) {
            }
        };
        this.c1 = new ObservedPropertySimplePU(new Date().getTime(), this, "cge");
        this.d1 = new ObservedPropertyObjectPU([], this, "resultData");
        this.e1 = new ObservedPropertyObjectPU(new LvFootnoteController(), this, "footnoteController");
        this.startTime = new Date().getTime();
        this.dialogController = new CustomDialogController({
            builder: () => {
                let jsDialog = new WebControl(this, {}, undefined, -1, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/Index.ets", line: 78, f1: 14 });
                jsDialog.setController(this.dialogController);
                ViewPU.create(jsDialog);
                let paramsLambda = () => {
                    return {};
                };
                jsDialog.paramsGenerator_ = paramsLambda;
            },
            alignment: DialogAlignment.Bottom,
            customStyle: true
        }, this);
        this.imgController = new CustomDialogController({
            builder: () => {
                let jsDialog = new ImgControl(this, {}, undefined, -1, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/Index.ets", line: 83, f1: 14 });
                jsDialog.setController(this.imgController);
                ViewPU.create(jsDialog);
                let paramsLambda = () => {
                    return {};
                };
                jsDialog.paramsGenerator_ = paramsLambda;
            },
            customStyle: true
        }, this);
        this.setInitiallyProvidedValue(params);
        this.declareWatch("text", this.textChange);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.loadMode === undefined) {
            this.t.set("text");
        }
        if (params.context !== undefined) {
            this.context = params.context;
        }
        if (params.loadCallBack !== undefined) {
            this.loadCallBack = params.loadCallBack;
        }
        if (params.cge !== undefined) {
            this.cge = params.cge;
        }
        if (params.resultData !== undefined) {
            this.resultData = params.resultData;
        }
        if (params.footnoteController !== undefined) {
            this.footnoteController = params.footnoteController;
        }
        if (params.startTime !== undefined) {
            this.startTime = params.startTime;
        }
        if (params.dialogController !== undefined) {
            this.dialogController = params.dialogController;
        }
        if (params.imgController !== undefined) {
            this.imgController = params.imgController;
        }
    }
    updateStateVars(params) {
        this.o.reset(params.text);
        this.t.reset(params.loadMode);
        this.u.reset(params.rawfilePath);
        this.a1.reset(params.sandboxPath);
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.o.purgeDependencyOnElmtId(rmElmtId);
        this.t.purgeDependencyOnElmtId(rmElmtId);
        this.u.purgeDependencyOnElmtId(rmElmtId);
        this.a1.purgeDependencyOnElmtId(rmElmtId);
        this.b1.purgeDependencyOnElmtId(rmElmtId);
        this.c1.purgeDependencyOnElmtId(rmElmtId);
        this.d1.purgeDependencyOnElmtId(rmElmtId);
        this.e1.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.o.aboutToBeDeleted();
        this.t.aboutToBeDeleted();
        this.u.aboutToBeDeleted();
        this.a1.aboutToBeDeleted();
        this.b1.aboutToBeDeleted();
        this.c1.aboutToBeDeleted();
        this.d1.aboutToBeDeleted();
        this.e1.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get text() {
        return this.o.get();
    }
    set text(newValue) {
        this.o.set(newValue);
    }
    get loadMode() {
        return this.t.get();
    }
    set loadMode(newValue) {
        this.t.set(newValue);
    }
    get rawfilePath() {
        return this.u.get();
    }
    set rawfilePath(newValue) {
        this.u.set(newValue);
    }
    get sandboxPath() {
        return this.a1.get();
    }
    set sandboxPath(newValue) {
        this.a1.set(newValue);
    }
    get context() {
        return this.b1.get();
    }
    set context(newValue) {
        this.b1.set(newValue);
    }
    get cge() {
        return this.c1.get();
    }
    set cge(newValue) {
        this.c1.set(newValue);
    }
    get resultData() {
        return this.d1.get();
    }
    set resultData(newValue) {
        this.d1.set(newValue);
    }
    get footnoteController() {
        return this.e1.get();
    }
    set footnoteController(newValue) {
        this.e1.set(newValue);
    }
    textChange() {
        if (this.loadMode == "text") {
            this._readText();
        }
    }
    cBack(type, code, message) {
        if (type == "success") {
            if (this.loadCallBack.success) {
                this.loadCallBack?.success({ code: code, message: message });
            }
        }
        if (type == "fail") {
            if (this.loadCallBack.fail) {
                this.loadCallBack?.fail({ code: code, message: message });
            }
        }
    }
    aboutToAppear() {
        this.startTime = new Date().getTime();
        if (this.loadMode == "text") {
            this._readText();
        }
        if (this.loadMode == "rawfile") {
            this._loadRawfile();
        }
        if (this.loadMode == "sandbox") {
            this._loadSandbox();
        }
    }
    _loadRawfile() {
        if (!this.rawfilePath && this.loadCallBack.fail) {
            this.cBack("fail", "50011", "The rawfile resource file is incorrect.");
            return;
        }
        if (!this.context) {
            this.cBack("fail", "50030", "The context is incorrect.");
            return;
        }
        try {
            let k5 = this.context?.resourceManager.getRawFileContentSync(this.rawfilePath);
            let l5 = buffer.from(k5).buffer;
            let m5 = new buffer.Blob([l5]);
            let n5 = m5.text();
            n5.then((str) => {
                this._readText(str);
            });
        }
        catch (error) {
            this.cBack("fail", "50012", "The resourceManager getRawFileContentSync is error, " +
                JSON.stringify(error));
        }
    }
    _loadSandbox() {
        if (!this.sandboxPath) {
            this.cBack("fail", "50021", "The sandbox file is incorrect.");
            return;
        }
        try {
            let j5 = {
                offset: 0,
                length: 0,
                encoding: 'utf-8'
            };
            let stat = fs.statSync(this.sandboxPath);
            j5.length = stat.size;
            let str = fs.readTextSync(this.sandboxPath, j5);
            this._readText(str);
        }
        catch (error) {
            this.cBack("fail", "50022", "The fileIo readText is error, " +
                JSON.stringify(error));
        }
    }
    _readText(text = this.text) {
        const a5 = html2md(text);
        let b5 = -1;
        let c5 = a5.split('\n').map((item) => {
            if (b5 < 0) {
                if (determineCode(item)) {
                    ++b5;
                    return LV_MD_CONTENT_TYPE.CODE;
                }
                if (determineTable(item)) {
                    return LV_MD_CONTENT_TYPE.TABLE;
                }
                return LV_MD_CONTENT_TYPE.TEXT;
            }
            else {
                if (determineCode(item)) {
                    b5 = -1;
                    return LV_MD_CONTENT_TYPE.TEXT;
                }
                else {
                    return LV_MD_CONTENT_TYPE.CODE;
                }
            }
        });
        let d5 = [];
        let e5 = "";
        let f5 = "";
        a5.split('\n').forEach((item, i5) => {
            if (c5[i5] == LV_MD_CONTENT_TYPE.TEXT) {
                if (e5 != "") {
                    e5 += item + '\n';
                    d5.push([LV_MD_CONTENT_TYPE.CODE, e5]);
                    e5 = "";
                }
                else if (f5 != "") {
                    f5 += item + '\n';
                    d5.push([LV_MD_CONTENT_TYPE.TABLE, f5]);
                    f5 = "";
                }
                else {
                    if (determineTitle(item)) {
                        return d5.push([LV_MD_CONTENT_TYPE.TITLE, item.trim()]);
                    }
                    else if (determineImg(item)) {
                        return d5.push([LV_MD_CONTENT_TYPE.IMG, item.trim()]);
                    }
                    else if (determineQuote(item)) {
                        return d5.push([LV_MD_CONTENT_TYPE.QUOTE, item.trim()]);
                    }
                    else if (determineLine(item)) {
                        return d5.push([LV_MD_CONTENT_TYPE.LINE, item.trim()]);
                    }
                    else if (determineCheckbox(item)) {
                        return d5.push([LV_MD_CONTENT_TYPE.CHECKBOX, item.trim()]);
                    }
                    else if (i5 > 0 && determineTabulate(item, a5.split('\n')[i5 - 1], a5.split('\n')[i5 + 1])) {
                        return d5.push([LV_MD_CONTENT_TYPE.TABULATE, item]);
                    }
                    else if (determineHTMLIMG(item)) {
                        return d5.push([LV_MD_CONTENT_TYPE.HTMLIMG, item]);
                    }
                    else if (determineHTMLFONT(item)) {
                        return d5.push([LV_MD_CONTENT_TYPE.HTMLFONT, item]);
                    }
                    else {
                        return d5.push([LV_MD_CONTENT_TYPE.TEXT, item.trim()]);
                    }
                }
            }
            else if (c5[i5] == LV_MD_CONTENT_TYPE.TABLE) {
                f5 += item + '\n';
            }
            else {
                e5 += item + '\n';
            }
            return item;
        });
        this.resultData = d5;
        this.cBack("success", "20000", "Component Load Success.");
        const endTime = new Date().getTime();
        const elapsedTime = endTime - this.startTime;
        console.log(`lv-markdown-in execution time is: ${elapsedTime} ms`);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            List.create();
            List.edgeEffect(EdgeEffect.None);
            List.scrollBar(BarState.Off);
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
                    Column.create();
                    Column.alignItems(HorizontalAlign.Start);
                    Column.width('100%');
                }, Column);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    ForEach.create();
                    const forEachItemGenFunction = _item => {
                        const item = _item;
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Row.create();
                            Row.margin({ top: !item[1] ? 10 : 5 });
                        }, Row);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            If.create();
                            if (item[LV_MD_DATA_TYPE.FLAG] === LV_MD_CONTENT_TYPE.TEXT) {
                                this.ifElseBranchUpdateFunction(0, () => {
                                    {
                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                            if (isInitialRender) {
                                                let componentCall = new lvCompositeComponent(this, {
                                                    text: item[LV_MD_DATA_TYPE.MSG],
                                                    dialogController: this.dialogController,
                                                    footnoteController: this.footnoteController
                                                }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/Index.ets", line: 244, f1: 19 });
                                                ViewPU.create(componentCall);
                                                let paramsLambda = () => {
                                                    return {
                                                        text: item[LV_MD_DATA_TYPE.MSG],
                                                        dialogController: this.dialogController,
                                                        footnoteController: this.footnoteController
                                                    };
                                                };
                                                componentCall.paramsGenerator_ = paramsLambda;
                                            }
                                            else {
                                                this.updateStateVarsOfChildByElmtId(elmtId, {
                                                    footnoteController: this.footnoteController
                                                });
                                            }
                                        }, { name: "lvCompositeComponent" });
                                    }
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
                            if (item[LV_MD_DATA_TYPE.FLAG] === LV_MD_CONTENT_TYPE.TITLE) {
                                this.ifElseBranchUpdateFunction(0, () => {
                                    {
                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                            if (isInitialRender) {
                                                let componentCall = new lvTitleComponent(this, { text: item[LV_MD_DATA_TYPE.MSG], dialogController: this.dialogController }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/Index.ets", line: 251, f1: 19 });
                                                ViewPU.create(componentCall);
                                                let paramsLambda = () => {
                                                    return {
                                                        text: item[LV_MD_DATA_TYPE.MSG],
                                                        dialogController: this.dialogController
                                                    };
                                                };
                                                componentCall.paramsGenerator_ = paramsLambda;
                                            }
                                            else {
                                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                                            }
                                        }, { name: "lvTitleComponent" });
                                    }
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
                            if (item[LV_MD_DATA_TYPE.FLAG] === LV_MD_CONTENT_TYPE.CODE) {
                                this.ifElseBranchUpdateFunction(0, () => {
                                    {
                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                            if (isInitialRender) {
                                                let componentCall = new lvCodeComponent(this, { text: item[LV_MD_DATA_TYPE.MSG] }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/Index.ets", line: 254, f1: 19 });
                                                ViewPU.create(componentCall);
                                                let paramsLambda = () => {
                                                    return {
                                                        text: item[LV_MD_DATA_TYPE.MSG]
                                                    };
                                                };
                                                componentCall.paramsGenerator_ = paramsLambda;
                                            }
                                            else {
                                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                                            }
                                        }, { name: "lvCodeComponent" });
                                    }
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
                            if (item[LV_MD_DATA_TYPE.FLAG] === LV_MD_CONTENT_TYPE.IMG) {
                                this.ifElseBranchUpdateFunction(0, () => {
                                    {
                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                            if (isInitialRender) {
                                                let componentCall = new lvImgComponent(this, { text: item[LV_MD_DATA_TYPE.MSG], dialogController: this.imgController }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/Index.ets", line: 257, f1: 19 });
                                                ViewPU.create(componentCall);
                                                let paramsLambda = () => {
                                                    return {
                                                        text: item[LV_MD_DATA_TYPE.MSG],
                                                        dialogController: this.imgController
                                                    };
                                                };
                                                componentCall.paramsGenerator_ = paramsLambda;
                                            }
                                            else {
                                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                                            }
                                        }, { name: "lvImgComponent" });
                                    }
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
                            if (item[LV_MD_DATA_TYPE.FLAG] === LV_MD_CONTENT_TYPE.HTMLIMG) {
                                this.ifElseBranchUpdateFunction(0, () => {
                                    {
                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                            if (isInitialRender) {
                                                let componentCall = new lvHTMLImgComponent(this, { text: item[LV_MD_DATA_TYPE.MSG], dialogController: this.imgController }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/Index.ets", line: 260, f1: 19 });
                                                ViewPU.create(componentCall);
                                                let paramsLambda = () => {
                                                    return {
                                                        text: item[LV_MD_DATA_TYPE.MSG],
                                                        dialogController: this.imgController
                                                    };
                                                };
                                                componentCall.paramsGenerator_ = paramsLambda;
                                            }
                                            else {
                                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                                            }
                                        }, { name: "lvHTMLImgComponent" });
                                    }
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
                            if (item[LV_MD_DATA_TYPE.FLAG] === LV_MD_CONTENT_TYPE.HTMLFONT) {
                                this.ifElseBranchUpdateFunction(0, () => {
                                    {
                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                            if (isInitialRender) {
                                                let componentCall = new lvHTMLFontComponent(this, { text: item[LV_MD_DATA_TYPE.MSG] }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/Index.ets", line: 263, f1: 19 });
                                                ViewPU.create(componentCall);
                                                let paramsLambda = () => {
                                                    return {
                                                        text: item[LV_MD_DATA_TYPE.MSG]
                                                    };
                                                };
                                                componentCall.paramsGenerator_ = paramsLambda;
                                            }
                                            else {
                                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                                            }
                                        }, { name: "lvHTMLFontComponent" });
                                    }
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
                            if (item[LV_MD_DATA_TYPE.FLAG] === LV_MD_CONTENT_TYPE.QUOTE) {
                                this.ifElseBranchUpdateFunction(0, () => {
                                    {
                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                            if (isInitialRender) {
                                                let componentCall = new lvQuoteComponent(this, {
                                                    text: item[LV_MD_DATA_TYPE.MSG],
                                                    dialogController: this.dialogController,
                                                }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/Index.ets", line: 266, f1: 19 });
                                                ViewPU.create(componentCall);
                                                let paramsLambda = () => {
                                                    return {
                                                        text: item[LV_MD_DATA_TYPE.MSG],
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
                                });
                            }
                        }, If);
                        If.pop();
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            If.create();
                            if (item[LV_MD_DATA_TYPE.FLAG] === LV_MD_CONTENT_TYPE.LINE) {
                                this.ifElseBranchUpdateFunction(0, () => {
                                    lvLineBuilder.bind(this)();
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
                            if (item[LV_MD_DATA_TYPE.FLAG] === LV_MD_CONTENT_TYPE.TABLE) {
                                this.ifElseBranchUpdateFunction(0, () => {
                                    {
                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                            if (isInitialRender) {
                                                let componentCall = new lvTableComponent(this, {
                                                    text: item[LV_MD_DATA_TYPE.MSG],
                                                    dialogController: this.dialogController,
                                                }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/Index.ets", line: 275, f1: 19 });
                                                ViewPU.create(componentCall);
                                                let paramsLambda = () => {
                                                    return {
                                                        text: item[LV_MD_DATA_TYPE.MSG],
                                                        dialogController: this.dialogController
                                                    };
                                                };
                                                componentCall.paramsGenerator_ = paramsLambda;
                                            }
                                            else {
                                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                                            }
                                        }, { name: "lvTableComponent" });
                                    }
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
                            if (item[LV_MD_DATA_TYPE.FLAG] === LV_MD_CONTENT_TYPE.CHECKBOX) {
                                this.ifElseBranchUpdateFunction(0, () => {
                                    {
                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                            if (isInitialRender) {
                                                let componentCall = new lvCheckboxComponent(this, {
                                                    text: item[LV_MD_DATA_TYPE.MSG],
                                                    dialogController: this.dialogController,
                                                }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/Index.ets", line: 281, f1: 19 });
                                                ViewPU.create(componentCall);
                                                let paramsLambda = () => {
                                                    return {
                                                        text: item[LV_MD_DATA_TYPE.MSG],
                                                        dialogController: this.dialogController
                                                    };
                                                };
                                                componentCall.paramsGenerator_ = paramsLambda;
                                            }
                                            else {
                                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                                            }
                                        }, { name: "lvCheckboxComponent" });
                                    }
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
                            if (item[LV_MD_DATA_TYPE.FLAG] === LV_MD_CONTENT_TYPE.TABULATE) {
                                this.ifElseBranchUpdateFunction(0, () => {
                                    {
                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                            if (isInitialRender) {
                                                let componentCall = new lvTabulateComponent(this, {
                                                    text: item[LV_MD_DATA_TYPE.MSG],
                                                    dialogController: this.dialogController,
                                                }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/Index.ets", line: 287, f1: 19 });
                                                ViewPU.create(componentCall);
                                                let paramsLambda = () => {
                                                    return {
                                                        text: item[LV_MD_DATA_TYPE.MSG],
                                                        dialogController: this.dialogController
                                                    };
                                                };
                                                componentCall.paramsGenerator_ = paramsLambda;
                                            }
                                            else {
                                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                                            }
                                        }, { name: "lvTabulateComponent" });
                                    }
                                });
                            }
                            else {
                                this.ifElseBranchUpdateFunction(1, () => {
                                });
                            }
                        }, If);
                        If.pop();
                        Row.pop();
                    };
                    this.forEachUpdateFunction(elmtId, this.resultData, forEachItemGenFunction);
                }, ForEach);
                ForEach.pop();
                {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        if (isInitialRender) {
                            let componentCall = new lvFootnoteView(this, { dialogController: this.dialogController }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/Index.ets", line: 295, f1: 13 });
                            ViewPU.create(componentCall);
                            let paramsLambda = () => {
                                return {
                                    dialogController: this.dialogController
                                };
                            };
                            componentCall.paramsGenerator_ = paramsLambda;
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                    }, { name: "lvFootnoteView" });
                }
                Column.pop();
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

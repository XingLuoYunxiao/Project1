if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { lvTitle } from '../domain/LvTitle';
import { lvFootnoteController } from './controller/lvFootnoteController';
import calcLevelTile from './handle/calcLevelTile';
import { lvCompositeComponent } from './lvCompositeComponent';
function h16(type) {
    let r = "";
    switch (type) {
        case "level1Tile":
            r = lvTitle.getLevel1Title();
            break;
        case "level2Tile":
            r = lvTitle.getLevel2Title();
            break;
        case "level3Tile":
            r = lvTitle.getLevel3Title();
            break;
        case "level4Tile":
            r = lvTitle.getLevel4Title();
            break;
        case "level5Tile":
            r = lvTitle.getLevel5Title();
            break;
        case "level6Tile":
            r = lvTitle.getLevel6Title();
            break;
        case "levelTitleColor":
            r = lvTitle.getLevelTitleColor();
            break;
    }
    return r;
}
export class lvTitleComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.o = new ObservedPropertySimplePU("", this, "text");
        this.h1 = new ObservedPropertyObjectPU(null, this, "dialogController");
        this.e2 = new ObservedPropertyObjectPU({
            level1Tile: lvTitle.getLevel1Title(),
            level2Tile: lvTitle.getLevel2Title(),
            level3Tile: lvTitle.getLevel3Title(),
            level4Tile: lvTitle.getLevel4Title(),
            level5Tile: lvTitle.getLevel5Title(),
            level6Tile: lvTitle.getLevel6Title(),
            levelTitleColor: lvTitle.getLevelTitleColor()
        }, this, "titleStyle");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.text !== undefined) {
            this.text = params.text;
        }
        if (params.dialogController !== undefined) {
            this.dialogController = params.dialogController;
        }
        if (params.titleStyle !== undefined) {
            this.titleStyle = params.titleStyle;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.o.purgeDependencyOnElmtId(rmElmtId);
        this.h1.purgeDependencyOnElmtId(rmElmtId);
        this.e2.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.o.aboutToBeDeleted();
        this.h1.aboutToBeDeleted();
        this.e2.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get text() {
        return this.o.get();
    }
    set text(newValue) {
        this.o.set(newValue);
    }
    get dialogController() {
        return this.h1.get();
    }
    set dialogController(newValue) {
        this.h1.set(newValue);
    }
    get titleStyle() {
        return this.e2.get();
    }
    set titleStyle(newValue) {
        this.e2.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.alignItems(HorizontalAlign.Start);
            Column.width('100%');
            Column.margin({ top: 10 });
        }, Column);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new lvCompositeComponent(this, {
                        text: this.text.slice(calcLevelTile(this.text)).trim(),
                        footnoteController: lvFootnoteController,
                        fontSize: h16(Object.keys(ObservedObject.GetRawObject(this.titleStyle))[calcLevelTile(this.text) - 1]),
                        fontWeight: FontWeight.Bold,
                        fontColor: this.titleStyle.levelTitleColor
                    }, undefined, elmtId, () => { }, { page: "lvMarkdownIn/src/main/ets/lv-markdown-in/lib/utils/lvTitleComponent.ets", line: 74, f1: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: this.text.slice(calcLevelTile(this.text)).trim(),
                            footnoteController: lvFootnoteController,
                            fontSize: h16(Object.keys(ObservedObject.GetRawObject(this.titleStyle))[calcLevelTile(this.text) - 1]),
                            fontWeight: FontWeight.Bold,
                            fontColor: this.titleStyle.levelTitleColor
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
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

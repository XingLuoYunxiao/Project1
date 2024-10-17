if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
import { famousPlaces, otherItemList } from '@bundle:com.example.ictproject/Travel/ets/model/Attraction';
//评分数组，最高10分
const scoreList = [9.7, 10.0, 8.8, 9.5, 9.2, 9.9, 9.0];
export class FamousPlacePage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__travelPathStack = this.initializeConsume('travelPathStack', "travelPathStack");
        this.__category = new ObservedPropertySimplePU("", this, "category");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params) {
        if (params.category !== undefined) {
            this.category = params.category;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__travelPathStack.purgeDependencyOnElmtId(rmElmtId);
        this.__category.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__travelPathStack.aboutToBeDeleted();
        this.__category.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get travelPathStack() {
        return this.__travelPathStack.get();
    }
    set travelPathStack(newValue) {
        this.__travelPathStack.set(newValue);
    }
    get category() {
        return this.__category.get();
    }
    set category(newValue) {
        this.__category.set(newValue);
    }
    aboutToAppear() {
        this.category = this.travelPathStack.getParamByName('FamousPlacePage')[0];
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            NavDestination.create(() => {
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Row.create({ space: 5 });
                    Row.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(26:7)", "travel");
                    Row.margin({ top: 5 });
                    Row.width('100%');
                    Row.height(30);
                }, Row);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Image.create({ "id": 83886088, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "Travel" });
                    Image.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(27:9)", "travel");
                    Image.width(30);
                    Image.height(30);
                    Image.onClick(() => {
                        this.travelPathStack.pop();
                    });
                }, Image);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Search.create({ placeholder: "搜索想要去的景点" });
                    Search.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(33:9)", "travel");
                    Search.height(30);
                    Search.layoutWeight(1);
                }, Search);
                Search.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Badge.create({ count: 1, position: BadgePosition.RightTop, style: { fontSize: 14, badgeColor: Color.Red } });
                    Badge.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(36:9)", "travel");
                }, Badge);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Image.create({ "id": 83886095, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "Travel" });
                    Image.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(37:11)", "travel");
                    Image.width(24);
                }, Image);
                Badge.pop();
                Row.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Tabs.create();
                    Tabs.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(45:7)", "travel");
                }, Tabs);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    TabContent.create(() => {
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Column.create();
                            Column.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(47:11)", "travel");
                            Column.width('95%');
                            Column.height('100%');
                        }, Column);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            List.create();
                            List.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(48:13)", "travel");
<<<<<<< HEAD
                            List.scrollBar(BarState.Off);
=======
>>>>>>> origin/zmx
                            List.width('100%');
                        }, List);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            ForEach.create();
                            const forEachItemGenFunction = (_item, index) => {
                                const item = _item;
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
                                        ListItem.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(50:17)", "travel");
                                    };
                                    const deepRenderFunction = (elmtId, isInitialRender) => {
                                        itemCreation(elmtId, isInitialRender);
                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                            Column.create();
                                            Column.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(51:19)", "travel");
                                        }, Column);
                                        this.FamousItem.bind(this)(item, index);
                                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                                            Divider.create();
                                            Divider.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(53:21)", "travel");
                                            Divider.color(Color.Gray);
                                            Divider.height(1);
                                            Divider.width('100%');
                                        }, Divider);
                                        Column.pop();
                                        ListItem.pop();
                                    };
                                    this.observeComponentCreation2(itemCreation2, ListItem);
                                    ListItem.pop();
                                }
                            };
                            this.forEachUpdateFunction(elmtId, famousPlaces, forEachItemGenFunction, undefined, true, false);
                        }, ForEach);
                        ForEach.pop();
                        List.pop();
                        Column.pop();
                    });
                    TabContent.tabBar('推荐');
                    TabContent.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(46:9)", "travel");
                }, TabContent);
                TabContent.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    TabContent.create();
                    TabContent.tabBar('跟团');
<<<<<<< HEAD
                    TabContent.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(67:9)", "travel");
=======
                    TabContent.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(66:9)", "travel");
>>>>>>> origin/zmx
                }, TabContent);
                TabContent.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    TabContent.create();
                    TabContent.tabBar('自由行');
<<<<<<< HEAD
                    TabContent.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(70:9)", "travel");
=======
                    TabContent.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(69:9)", "travel");
>>>>>>> origin/zmx
                }, TabContent);
                TabContent.pop();
                Tabs.pop();
            }, { moduleName: "Travel", pagePath: "features/Travel/src/main/ets/pages/FamousPlacePage" });
            NavDestination.hideTitleBar(true);
            NavDestination.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(25:5)", "travel");
        }, NavDestination);
        NavDestination.pop();
    }
    FamousItem(attraction, index, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
<<<<<<< HEAD
            Row.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(83:5)", "travel");
=======
            Row.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(82:5)", "travel");
>>>>>>> origin/zmx
            Row.backgroundColor(Color.White);
            Row.height(250);
            Row.width('100%');
            Row.padding(10);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
<<<<<<< HEAD
            Column.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(84:7)", "travel");
=======
            Column.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(83:7)", "travel");
>>>>>>> origin/zmx
            Column.width('40%');
            Column.padding(8);
            Column.alignItems(HorizontalAlign.Center);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create(attraction.image);
<<<<<<< HEAD
            Image.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(85:9)", "travel");
=======
            Image.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(84:9)", "travel");
>>>>>>> origin/zmx
            Image.width('100%');
            Image.borderRadius(10);
            Image.height(210);
        }, Image);
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
<<<<<<< HEAD
            Column.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(94:7)", "travel");
=======
            Column.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(93:7)", "travel");
>>>>>>> origin/zmx
            Column.justifyContent(FlexAlign.Start);
            Column.alignItems(HorizontalAlign.Start);
            Column.height(230);
            Column.padding(10);
            Column.layoutWeight(1);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(attraction.name);
<<<<<<< HEAD
            Text.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(95:9)", "travel");
=======
            Text.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(94:9)", "travel");
>>>>>>> origin/zmx
            Text.fontSize(20);
            Text.padding({ top: 5, bottom: 10 });
            Text.fontColor(Color.Black);
            Text.fontWeight(500);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create();
<<<<<<< HEAD
            Text.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(100:9)", "travel");
=======
            Text.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(99:9)", "travel");
>>>>>>> origin/zmx
            Text.backgroundColor('#ff52bdd7');
            Text.fontSize(14);
            Text.padding(5);
            Text.borderRadius(10);
            Text.margin({ bottom: 8 });
        }, Text);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Span.create(scoreList[index].toFixed(1) + '分');
<<<<<<< HEAD
            Span.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(101:11)", "travel");
=======
            Span.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(100:11)", "travel");
>>>>>>> origin/zmx
            Span.fontSize(16);
            Span.fontColor(Color.White);
        }, Span);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(attraction.description);
<<<<<<< HEAD
            Text.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(110:9)", "travel");
=======
            Text.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(109:9)", "travel");
>>>>>>> origin/zmx
            Text.fontSize(14);
            Text.fontColor(Color.Gray);
            Text.textOverflow({ overflow: TextOverflow.Ellipsis });
            Text.maxLines(3);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
<<<<<<< HEAD
            Row.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(116:9)", "travel");
=======
            Row.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(115:9)", "travel");
>>>>>>> origin/zmx
            Row.margin({ top: 8 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 8 });
<<<<<<< HEAD
            Column.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(117:11)", "travel");
=======
            Column.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(116:11)", "travel");
>>>>>>> origin/zmx
            Column.alignItems(HorizontalAlign.Start);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
<<<<<<< HEAD
            Row.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(118:13)", "travel");
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 33554435, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "Travel" });
            Image.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(119:15)", "travel");
=======
            Row.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(117:13)", "travel");
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 33554435, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "Travel" });
            Image.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(118:15)", "travel");
>>>>>>> origin/zmx
            Image.width(16);
            Image.height(16);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(`【${otherItemList[index].hotel}】`);
<<<<<<< HEAD
            Text.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(122:15)", "travel");
=======
            Text.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(121:15)", "travel");
>>>>>>> origin/zmx
            Text.fontSize(14);
            Text.fontColor(Color.Gray);
        }, Text);
        Text.pop();
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
<<<<<<< HEAD
            Row.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(126:13)", "travel");
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 33554439, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "Travel" });
            Image.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(127:15)", "travel");
=======
            Row.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(125:13)", "travel");
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 33554439, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "Travel" });
            Image.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(126:15)", "travel");
>>>>>>> origin/zmx
            Image.width(16);
            Image.height(16);
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(`【${otherItemList[index].guide}】`);
<<<<<<< HEAD
            Text.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(130:15)", "travel");
=======
            Text.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(129:15)", "travel");
>>>>>>> origin/zmx
            Text.fontSize(14);
            Text.fontColor(Color.Gray);
        }, Text);
        Text.pop();
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(`${otherItemList[index].people}人出行`);
<<<<<<< HEAD
            Text.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(134:13)", "travel");
=======
            Text.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(133:13)", "travel");
>>>>>>> origin/zmx
            Text.fontSize(14);
            Text.fontColor(Color.Gray);
        }, Text);
        Text.pop();
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
<<<<<<< HEAD
            Column.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(139:11)", "travel");
=======
            Column.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(138:11)", "travel");
>>>>>>> origin/zmx
            Column.alignItems(HorizontalAlign.End);
            Column.justifyContent(FlexAlign.End);
            Column.height(80);
            Column.layoutWeight(1);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel('AI导游');
<<<<<<< HEAD
            Button.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(140:13)", "travel");
=======
            Button.debugLine("features/Travel/src/main/ets/pages/FamousPlacePage.ets(139:13)", "travel");
>>>>>>> origin/zmx
            Button.type(ButtonType.Capsule);
            Button.fontSize(16);
            Button.backgroundColor(Color.Orange);
            Button.fontColor(Color.White);
            Button.onClick(() => {
                let params = {
                    param1: "AttractionDetailPage",
                    param2: attraction // 第二个参数
                };
                this.travelPathStack.pushPathByName('LoadingAnimation', params);
            });
        }, Button);
        Button.pop();
        Column.pop();
        Row.pop();
        Column.pop();
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=FamousPlacePage.js.map
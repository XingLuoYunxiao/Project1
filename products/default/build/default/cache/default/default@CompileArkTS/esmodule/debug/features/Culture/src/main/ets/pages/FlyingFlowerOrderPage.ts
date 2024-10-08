if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface FlyingFlowerOrderPage_Params {
    isListNull?: boolean;
    ChatItemList?: ChatI[];
    InputMessage?: string;
    travelPathStack?: NavPathStack;
}
import { ChatI } from "@bundle:com.example.ictproject/default@Culture/ets/model/ChatI";
import inputMethod from "@ohos:inputMethod";
import { ttf } from "@bundle:com.example.ictproject/default@Culture/ets/util/ttf";
export class FlyingFlowerOrderPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__isListNull = new ObservedPropertySimplePU(true, this, "isListNull");
        this.__ChatItemList = new ObservedPropertyObjectPU([new ChatI('我们来玩飞花令吧！\n我来第一句！\n花近高楼伤客心', 1), new ChatI('落花时节又逢君', 0),
            new ChatI('春江花朝秋月夜', 1)], this, "ChatItemList");
        this.__InputMessage = new ObservedPropertySimplePU('', this, "InputMessage");
        this.__travelPathStack = this.initializeConsume('travelPathStack', "travelPathStack");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: FlyingFlowerOrderPage_Params) {
        if (params.isListNull !== undefined) {
            this.isListNull = params.isListNull;
        }
        if (params.ChatItemList !== undefined) {
            this.ChatItemList = params.ChatItemList;
        }
        if (params.InputMessage !== undefined) {
            this.InputMessage = params.InputMessage;
        }
    }
    updateStateVars(params: FlyingFlowerOrderPage_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__isListNull.purgeDependencyOnElmtId(rmElmtId);
        this.__ChatItemList.purgeDependencyOnElmtId(rmElmtId);
        this.__InputMessage.purgeDependencyOnElmtId(rmElmtId);
        this.__travelPathStack.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__isListNull.aboutToBeDeleted();
        this.__ChatItemList.aboutToBeDeleted();
        this.__InputMessage.aboutToBeDeleted();
        this.__travelPathStack.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __isListNull: ObservedPropertySimplePU<boolean>;
    get isListNull() {
        return this.__isListNull.get();
    }
    set isListNull(newValue: boolean) {
        this.__isListNull.set(newValue);
    }
    private __ChatItemList: ObservedPropertyObjectPU<ChatI[]>;
    get ChatItemList() {
        return this.__ChatItemList.get();
    }
    set ChatItemList(newValue: ChatI[]) {
        this.__ChatItemList.set(newValue);
    }
    private __InputMessage: ObservedPropertySimplePU<string>;
    get InputMessage() {
        return this.__InputMessage.get();
    }
    set InputMessage(newValue: string) {
        this.__InputMessage.set(newValue);
    }
    private __travelPathStack: ObservedPropertyAbstractPU<NavPathStack>;
    get travelPathStack() {
        return this.__travelPathStack.get();
    }
    set travelPathStack(newValue: NavPathStack) {
        this.__travelPathStack.set(newValue);
    }
    aboutToAppear(): void {
        if (this.ChatItemList.length > 0) {
            this.isListNull = false;
            console.log('testlog' + this.ChatItemList.length);
        }
        let inputMethodController = inputMethod.getController();
        ttf('STXINGKAFont', 'STXINGKA.TTF');
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            NavDestination.create(() => {
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
                }, Column);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Row.create();
                    Row.justifyContent(FlexAlign.Center);
                    Row.height(100);
                    Row.width('100%');
                    Row.margin({ bottom: 20 });
                    Row.backgroundColor("#f1f1f1");
                    Row.expandSafeArea([SafeAreaType.KEYBOARD]);
                    Row.zIndex(999);
                    Row.layoutWeight(1);
                }, Row);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create('飞花令');
                    Text.fontSize(55);
                    Text.fontFamily('STXINGKAFont');
                    Text.letterSpacing(15);
                }, Text);
                Text.pop();
                Row.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create('输入开始飞花令来跟AI进行诗词储量比拼吧!');
                    Text.fontSize(16);
                    Text.fontColor(Color.Gray);
                    Text.visibility(this.isListNull ? Visibility.Visible : Visibility.None);
                    Text.expandSafeArea([SafeAreaType.KEYBOARD]);
                    Text.zIndex(999);
                }, Text);
                Text.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    List.create();
                    List.width('100%');
                    List.layoutWeight(2);
                    List.height(500);
                    List.width('100%');
                }, List);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    ForEach.create();
                    const forEachItemGenFunction = _item => {
                        const item = _item;
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            If.create();
                            if (item.id == 0) {
                                this.ifElseBranchUpdateFunction(0, () => {
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
                                            ListItem.margin({ bottom: 20, left: 15 });
                                        };
                                        const deepRenderFunction = (elmtId, isInitialRender) => {
                                            itemCreation(elmtId, isInitialRender);
                                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                                Row.create({ space: 15 });
                                                Row.width('100%');
                                                Row.justifyContent(FlexAlign.Start);
                                            }, Row);
                                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                                Image.create({ "id": 67109013, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                                                Image.size({ height: 50, width: 50 });
                                            }, Image);
                                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                                Text.create(item.message);
                                                Text.fontSize(21);
                                                Text.backgroundColor('rgba(207, 207, 207, 0.44)');
                                                Text.lineHeight(25);
                                                Text.borderRadius(5);
                                            }, Text);
                                            Text.pop();
                                            Row.pop();
                                            ListItem.pop();
                                        };
                                        this.observeComponentCreation2(itemCreation2, ListItem);
                                        ListItem.pop();
                                    }
                                });
                            }
                            else {
                                this.ifElseBranchUpdateFunction(1, () => {
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
                                            ListItem.margin({ bottom: 20 });
                                        };
                                        const deepRenderFunction = (elmtId, isInitialRender) => {
                                            itemCreation(elmtId, isInitialRender);
                                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                                Row.create({ space: 15 });
                                                Row.padding({ left: 15 });
                                                Row.width('95%');
                                                Row.justifyContent(FlexAlign.End);
                                            }, Row);
                                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                                Text.create(item.message);
                                                Text.fontSize(21);
                                                Text.backgroundColor('rgba(42, 134, 255, 0.69)');
                                                Text.lineHeight(25);
                                                Text.borderRadius(5);
                                            }, Text);
                                            Text.pop();
                                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                                Image.create({ "id": 67109014, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                                                Image.size({ height: 50, width: 50 });
                                            }, Image);
                                            Row.pop();
                                            ListItem.pop();
                                        };
                                        this.observeComponentCreation2(itemCreation2, ListItem);
                                        ListItem.pop();
                                    }
                                });
                            }
                        }, If);
                        If.pop();
                    };
                    this.forEachUpdateFunction(elmtId, this.ChatItemList, forEachItemGenFunction);
                }, ForEach);
                ForEach.pop();
                List.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Row.create({ space: 20 });
                    Row.backgroundColor("#f1f1f1");
                    Row.padding({ bottom: 20 });
                    Row.width('100%');
                    Row.height(80);
                }, Row);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    TextArea.create({ placeholder: 'Ask me anything...', text: this.InputMessage });
                    TextArea.fontSize(16);
                    TextArea.width(300);
                    TextArea.position({ left: '2%', bottom: 0 });
                    TextArea.onChange((val) => {
                        this.InputMessage = val;
                    });
                }, TextArea);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Button.createWithLabel('发送');
                    Button.backgroundColor('#00bd12');
                    Button.fontColor(Color.White);
                    Button.position({ bottom: 0, right: '2%' });
                    Button.onClick(() => {
                        if (this.InputMessage.length > 0) {
                            this.ChatItemList.push(new ChatI(this.InputMessage, 1));
                            this.InputMessage = '';
                            inputMethod.getController().stopInputSession();
                        }
                    });
                }, Button);
                Button.pop();
                Row.pop();
                Column.pop();
            }, { moduleName: "default", pagePath: "features/Culture/src/main/ets/pages/FlyingFlowerOrderPage" });
            NavDestination.height('100%');
            NavDestination.width('100%');
        }, NavDestination);
        NavDestination.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

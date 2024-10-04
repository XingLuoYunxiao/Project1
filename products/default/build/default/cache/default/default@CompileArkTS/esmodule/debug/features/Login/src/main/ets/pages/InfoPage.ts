if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface InfoPage_Params {
    personName?: string;
    nickname?: string;
    birthdate?: string;
    sex?: string;
    signature?: string;
    hobbies?: string;
    myId?: number;
    sexArray?: Resource;
    //自定义弹窗控制器
    customDialogController?: CustomDialogController;
}
import CommonUtils from "@bundle:com.example.ictproject/default@Login/ets/utils/CommonUtil";
import CommonConstants from "@bundle:com.example.ictproject/default@Login/ets/common/CommonConstants";
import TextInputWidget from "@bundle:com.example.ictproject/default@Login/ets/view/TextInputWidget";
import TextCommonWidget from "@bundle:com.example.ictproject/default@Login/ets/view/TextCommonWidget";
import CustomDialogWidget from "@bundle:com.example.ictproject/default@Login/ets/view/CustomDialogWidget";
import iReadDBUtil from "@bundle:com.example.ictproject/default@Login/ets/utils/DBUtil";
import router from "@ohos:router";
import promptAction from "@ohos:promptAction";
export class InfoPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__personName = this.createStorageProp('personName', ''
        //昵称
        , "personName");
        this.__nickname = new ObservedPropertySimplePU(''
        //出生日期
        , this, "nickname");
        this.__birthdate = new ObservedPropertySimplePU(''
        //性别
        , this, "birthdate");
        this.__sex = new ObservedPropertySimplePU(''
        //签名
        , this, "sex");
        this.__signature = new ObservedPropertySimplePU(''
        //爱好
        , this, "signature");
        this.__hobbies = new ObservedPropertySimplePU('', this, "hobbies");
        this.__myId = new ObservedPropertySimplePU(-1
        //值为男和女
        , this, "myId");
        this.sexArray = { "id": 33554442, "type": 10009, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" };
        this.customDialogController = new CustomDialogController({
            builder: () => {
                let jsDialog = new CustomDialogWidget(this, {
                    hobbies: this.__hobbies,
                }, undefined, -1, () => { }, { page: "features/Login/src/main/ets/pages/InfoPage.ets", line: 32, col: 14 });
                jsDialog.setController(this.
                //自定义弹窗控制器
                customDialogController);
                ViewPU.create(jsDialog);
                let paramsLambda = () => {
                    return {
                        hobbies: this.__hobbies
                    };
                };
                jsDialog.paramsGenerator_ = paramsLambda;
            },
            alignment: DialogAlignment.Bottom,
            customStyle: true,
            offset: {
                //x轴和y轴位置偏移量
                dx: 0,
                dy: CommonConstants.DY_OFFSET
            }
        }, this);
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: InfoPage_Params) {
        if (params.nickname !== undefined) {
            this.nickname = params.nickname;
        }
        if (params.birthdate !== undefined) {
            this.birthdate = params.birthdate;
        }
        if (params.sex !== undefined) {
            this.sex = params.sex;
        }
        if (params.signature !== undefined) {
            this.signature = params.signature;
        }
        if (params.hobbies !== undefined) {
            this.hobbies = params.hobbies;
        }
        if (params.myId !== undefined) {
            this.myId = params.myId;
        }
        if (params.sexArray !== undefined) {
            this.sexArray = params.sexArray;
        }
        if (params.customDialogController !== undefined) {
            this.customDialogController = params.customDialogController;
        }
    }
    updateStateVars(params: InfoPage_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__personName.purgeDependencyOnElmtId(rmElmtId);
        this.__nickname.purgeDependencyOnElmtId(rmElmtId);
        this.__birthdate.purgeDependencyOnElmtId(rmElmtId);
        this.__sex.purgeDependencyOnElmtId(rmElmtId);
        this.__signature.purgeDependencyOnElmtId(rmElmtId);
        this.__hobbies.purgeDependencyOnElmtId(rmElmtId);
        this.__myId.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__personName.aboutToBeDeleted();
        this.__nickname.aboutToBeDeleted();
        this.__birthdate.aboutToBeDeleted();
        this.__sex.aboutToBeDeleted();
        this.__signature.aboutToBeDeleted();
        this.__hobbies.aboutToBeDeleted();
        this.__myId.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    //@StorageProp(key)是和AppStorage中key对应的属性建立单向数据同步
    private __personName: ObservedPropertyAbstractPU<string>;
    get personName() {
        return this.__personName.get();
    }
    set personName(newValue: string) {
        this.__personName.set(newValue);
    }
    //昵称
    private __nickname: ObservedPropertySimplePU<string>;
    get nickname() {
        return this.__nickname.get();
    }
    set nickname(newValue: string) {
        this.__nickname.set(newValue);
    }
    //出生日期
    private __birthdate: ObservedPropertySimplePU<string>;
    get birthdate() {
        return this.__birthdate.get();
    }
    set birthdate(newValue: string) {
        this.__birthdate.set(newValue);
    }
    //性别
    private __sex: ObservedPropertySimplePU<string>;
    get sex() {
        return this.__sex.get();
    }
    set sex(newValue: string) {
        this.__sex.set(newValue);
    }
    //签名
    private __signature: ObservedPropertySimplePU<string>;
    get signature() {
        return this.__signature.get();
    }
    set signature(newValue: string) {
        this.__signature.set(newValue);
    }
    //爱好
    private __hobbies: ObservedPropertySimplePU<string>;
    get hobbies() {
        return this.__hobbies.get();
    }
    set hobbies(newValue: string) {
        this.__hobbies.set(newValue);
    }
    private __myId: ObservedPropertySimplePU<number>;
    get myId() {
        return this.__myId.get();
    }
    set myId(newValue: number) {
        this.__myId.set(newValue);
    }
    //值为男和女
    private sexArray: Resource;
    //自定义弹窗控制器
    private customDialogController: CustomDialogController;
    async aboutToAppear() {
        let date = new Date();
        let year = date.getFullYear();
        let month = date.getMonth() + CommonConstants.PLUS_ONE;
        let day = date.getDate();
        this.birthdate = CommonUtils.getBirthDateValue(year, month, day);
        let context = getContext(this);
        let manager = context.resourceManager;
        manager.getStringValue({ "id": 33554433, "type": 10003, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" }.id, (error, sexValue) => {
            if (!CommonUtils.isEmpty(error)) {
                console.error('error= ' + JSON.stringify(error));
            }
            else {
                this.sex = sexValue;
            }
        });
        // 尝试从数据库加载数据
        this.loadDataFromDB();
    }
    async loadDataFromDB() {
        try {
            const infos = await iReadDBUtil.getInfo();
            if (infos.length > 0) {
                const info = infos[0]; // 只关心第一条记录，可以根据查询name返回id来进行更新，这里采用简便做法
                if (info.name && info.birthdate && info.gender && info.signature && info.hobby && info.id) {
                    this.nickname = info.name;
                    this.birthdate = info.birthdate;
                    this.sex = info.gender;
                    this.signature = info.signature;
                    this.hobbies = info.hobby;
                    this.myId = info.id;
                }
            }
        }
        catch (error) {
            console.error('从数据库加载数据失败:', error);
        }
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.backgroundColor({ "id": 33554443, "type": 10001, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Column.width(CommonConstants.FULL_WIDTH);
            Column.height(CommonConstants.FULL_HEIGHT);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width('100%');
            Row.height(50);
            Row.margin({
                top: 5
            });
            Row.padding({
                left: 10,
                right: 10
            });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            //返回之前的页面
            Image.create({ "id": 33554495, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            //返回之前的页面
            Image.width(25);
            //返回之前的页面
            Image.aspectRatio(1);
            //返回之前的页面
            Image.onClick(() => {
                router.back();
            });
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create({ space: 50 });
            Row.onClick(() => {
                if (this.nickname && this.birthdate && this.sex && this.signature && this.hobbies) {
                    if (this.myId === -1) {
                        // 新增记录
                        let id = iReadDBUtil.addInfo(this.nickname, this.birthdate, this.sex, this.signature, this.hobbies);
                        if (id !== -1) {
                            this.myId = id;
                            promptAction.showToast({ message: '保存成功' });
                        }
                        else {
                            promptAction.showToast({ message: '保存失败' });
                        }
                    }
                    else {
                        // 更新记录
                        iReadDBUtil.updateInfo(this.myId, this.nickname, this.birthdate, this.sex, this.signature, this.hobbies)
                            .then((result) => {
                            if (result) {
                                promptAction.showToast({ message: '更新成功' });
                            }
                            else {
                                promptAction.showToast({ message: '更新失败' });
                            }
                        });
                    }
                }
                else {
                    promptAction.showToast({ message: '请填写完整信息' });
                }
            });
            Row.layoutWeight(1);
            Row.justifyContent(FlexAlign.End);
            Row.padding({
                right: 10
            });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('保存');
            Text.fontSize(20);
            Text.fontColor(Color.Red);
        }, Text);
        Text.pop();
        Row.pop();
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            /*
             * 个人信息
             * */
            if (this.personName) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        //登录之后显示此图片
                        Image.create({ "id": 33554494, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                        //登录之后显示此图片
                        Image.width({ "id": 33554451, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                        //登录之后显示此图片
                        Image.height({ "id": 33554451, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                        //登录之后显示此图片
                        Image.alignSelf(ItemAlign.Center);
                        //登录之后显示此图片
                        Image.margin({ top: '5.5%' });
                    }, Image);
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        //未登录显示此图片
                        Image.create({ "id": 33554503, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                        //未登录显示此图片
                        Image.width({ "id": 33554451, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                        //未登录显示此图片
                        Image.height({ "id": 33554451, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
                        //未登录显示此图片
                        Image.alignSelf(ItemAlign.Center);
                        //未登录显示此图片
                        Image.margin({ top: '5.5%' });
                    }, Image);
                });
            }
        }, If);
        If.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('头像');
            Text.fontColor(Color.Black);
            Text.fontSize({ "id": 33554478, "type": 10002, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" });
            Text.margin({ top: '2.1%' });
            Text.alignSelf(ItemAlign.Center);
        }, Text);
        Text.pop();
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    /*
                     * 昵称
                     * */
                    TextInputWidget(this, {
                        inputImage: { "id": 33554506, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                        hintText: { "id": 33554435, "type": 10003, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                        content: this.__nickname
                    }, undefined, elmtId, () => { }, { page: "features/Login/src/main/ets/pages/InfoPage.ets", line: 165, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            inputImage: { "id": 33554506, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                            hintText: { "id": 33554435, "type": 10003, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                            content: this.nickname
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
            }, { name: "TextInputWidget" });
        }
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    /*
                     * 出生日期
                     * */
                    TextCommonWidget(this, {
                        textImage: { "id": 33554504, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                        title: { "id": 33554438, "type": 10003, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                        content: this.__birthdate,
                        onItemClick: () => {
                            //日期弹窗
                            CommonUtils.datePickerDialog((birthValue: string) => {
                                this.birthdate = birthValue;
                            });
                        }
                    }, undefined, elmtId, () => { }, { page: "features/Login/src/main/ets/pages/InfoPage.ets", line: 173, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            textImage: { "id": 33554504, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                            title: { "id": 33554438, "type": 10003, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                            content: this.birthdate,
                            onItemClick: () => {
                                //日期弹窗
                                CommonUtils.datePickerDialog((birthValue: string) => {
                                    this.birthdate = birthValue;
                                });
                            }
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
            }, { name: "TextCommonWidget" });
        }
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    /*
                     * 性别
                     * */
                    TextCommonWidget(this, {
                        textImage: { "id": 33554507, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                        title: { "id": 33554440, "type": 10003, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                        content: this.__sex,
                        onItemClick: () => {
                            CommonUtils.textPickerDialog(this.sexArray, (sexValue: string) => {
                                this.sex = sexValue;
                            });
                        }
                    }, undefined, elmtId, () => { }, { page: "features/Login/src/main/ets/pages/InfoPage.ets", line: 187, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            textImage: { "id": 33554507, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                            title: { "id": 33554440, "type": 10003, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                            content: this.sex,
                            onItemClick: () => {
                                CommonUtils.textPickerDialog(this.sexArray, (sexValue: string) => {
                                    this.sex = sexValue;
                                });
                            }
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
            }, { name: "TextCommonWidget" });
        }
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    /*
                     * 个性签名
                     * */
                    TextInputWidget(this, {
                        inputImage: { "id": 33554508, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                        hintText: { "id": 33554436, "type": 10003, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                        content: this.__signature
                    }, undefined, elmtId, () => { }, { page: "features/Login/src/main/ets/pages/InfoPage.ets", line: 200, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            inputImage: { "id": 33554508, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                            hintText: { "id": 33554436, "type": 10003, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                            content: this.signature
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
            }, { name: "TextInputWidget" });
        }
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    /*
                     * 爱好
                     * */
                    TextCommonWidget(this, {
                        textImage: { "id": 33554505, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                        title: { "id": 33554439, "type": 10003, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                        content: this.__hobbies,
                        onItemClick: () => {
                            // 打开自定义弹窗
                            this.customDialogController.open();
                        }
                    }, undefined, elmtId, () => { }, { page: "features/Login/src/main/ets/pages/InfoPage.ets", line: 208, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            textImage: { "id": 33554505, "type": 20000, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                            title: { "id": 33554439, "type": 10003, params: [], "bundleName": "com.example.ictproject", "moduleName": "default" },
                            content: this.hobbies,
                            onItemClick: () => {
                                // 打开自定义弹窗
                                this.customDialogController.open();
                            }
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
            }, { name: "TextCommonWidget" });
        }
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

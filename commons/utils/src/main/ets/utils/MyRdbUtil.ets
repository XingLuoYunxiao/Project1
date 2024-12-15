import {relationalStore} from '@kit.ArkData';
class MyRdbUtil{
  private rdbStore:relationalStore.RdbStore|null=null
  private tableName:string='TALK'
  //初始化数据库
  initMyDB(context:Context){
    //初始化数据库配置
    const TALK_CONFIG:relationalStore.StoreConfig={
      name:'guyunyz.db',//数据库文件名
      securityLevel:relationalStore.SecurityLevel.S1,//数据库安全级别
      // encrypt: false, // 可选参数，指定数据库是否加密，默认不加密
    }
    //建表配置
    const CREATE_TABLE=`CREATE TABLE IF NOT EXISTS TALK (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    CONSULT TEXT,
    MINE TEXT)`
    //初始化数据库
    relationalStore.getRdbStore(context,TALK_CONFIG,(err,talk)=>{
      if(err){
        console.error(`获取RdbStore失败.Code:${err.code},message:${err.message}`);
        return;
      }else{
        console.info('获取RdbStore成功')
        this.rdbStore=talk
        //建表
        talk.executeSql(CREATE_TABLE,(error)=>{
          if(!error){
            console.log(`TALK创建成功`)
          }else {
            console.log(`TALK创建失败`)
          }
        });
      }
    })
  }
  getTalk(){
    //查询条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    //查询
    let res=this.rdbStore?.query(predicates,['ID','CONSULT','MINE'])
    //解析查询结果
    let talks:string[]=[]
  }
}
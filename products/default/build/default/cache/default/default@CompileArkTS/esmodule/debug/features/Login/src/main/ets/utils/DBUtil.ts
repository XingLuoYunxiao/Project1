import relationalStore from "@ohos:data.relationalStore";
import Person from "@bundle:com.example.ictproject/default@Login/ets/viewmodel/PersonInfo";
interface GeneratedObjectLiteralInterface_1 {
    name: string;
    securityLevel: relationalStore.SecurityLevel;
}
class DBUtil {
    private rdbStore?: relationalStore.RdbStore;
    private name: string = 'iReadTable';
    initTable(context: Context) {
        //1.rdb配置
        const config: GeneratedObjectLiteralInterface_1 = {
            name: 'iRead.db',
            securityLevel: relationalStore.SecurityLevel.S1
        };
        // 2.初始化表
        const sql = `create table if not exists ireadtable (
                ID INTEGER PRIMARY KEY AUTOINCREMENT,
                NAME VARCHAR(255) NOT NULL,
                BIRTHDATE VARCHAR(255),
                GENDER VARCHAR(255),
                SIGNATURE VARCHAR(255),
                HOBBY VARCHAR(255))`;
        // 3. 获取rdb
        relationalStore.getRdbStore(context, config, (err, rdbStore) => {
            if (err) {
                console.log('testTag', '获取rdbStore失败');
                return;
            }
            rdbStore.executeSql(sql);
            console.log('testTag', '创建iReadTable表成功');
            //保存rdbStore
            this.rdbStore = rdbStore;
        });
    }
    //查询
    async getInfo() {
        if (!this.rdbStore) {
            throw new Error('rdbStore 未初始化');
        }
        // 1.构建查询条件
        let predicates = new relationalStore.RdbPredicates(this.name);
        // 2.查询
        let result = await this.rdbStore.query(predicates, ['ID', 'NAME', 'BIRTHDATE', 'GENDER', 'SIGNATURE', 'HOBBY']);
        // 3.解析查询结果
        let infos: Person[] = [];
        while (!result.isAtLastRow) {
            result.goToNextRow();
            //获取数据
            let id = result.getLong(result.getColumnIndex('ID'));
            let name = result.getString(result.getColumnIndex('NAME'));
            let birthdate = result.getString(result.getColumnIndex('BIRTHDATE'));
            let gender = result.getString(result.getColumnIndex('GENDER'));
            let signature = result.getString(result.getColumnIndex('SIGNATURE'));
            let hobby = result.getString(result.getColumnIndex('HOBBY'));
            infos.push(new Person(id, name, birthdate, gender, signature, hobby));
        }
        console.log('testTag', '查询到数据', JSON.stringify(infos));
        return infos;
    }
    // 根据名字获取id
    async getId(name: string): Promise<number> {
        if (!this.rdbStore) {
            throw new Error('rdbStore 未初始化');
        }
        // 1. 构建查询条件
        let predicates = new relationalStore.RdbPredicates(this.name);
        predicates.equalTo('NAME', name);
        // 2. 执行查询
        try {
            let result = await this.rdbStore.query(predicates, ['ID']);
            // 3. 解析查询结果
            if (!result.rowCount) {
                console.log('testTag', `未找到名字为 ${name} 的记录`);
                return -1;
            }
            // 移动到第一行
            result.goToFirstRow();
            let id = result.getLong(result.getColumnIndex('ID'));
            console.log('testTag', `找到名字为 ${name} 的ID: ${id}`);
            return id;
        }
        catch (error) {
            console.error('testTag', `查询ID时发生错误: ${error}`);
            return -1;
        }
    }
    addInfo(name: string, birthdate: string, gender: string, signature: string, hobby: string) {
        if (!this.rdbStore) {
            throw new Error('rdbStore 未初始化');
        }
        console.log('Inserting data:', { name, birthdate, gender, signature, hobby });
        this.rdbStore.insert(this.name, { name, birthdate, gender, signature, hobby })
            .then(id => {
            console.log('Insert successful, ID:', id);
            return id;
        })
            .catch((error: Error) => {
            console.error('Insert failed:', error);
            return -1;
        });
        return -1;
    }
    updateInfo(id: number, name: string, birthdate: string, gender: string, signature: string, hobby: string) {
        if (!this.rdbStore) {
            throw new Error('rdbStore 未初始化');
        }
        let predicates = new relationalStore.RdbPredicates(this.name);
        predicates.equalTo('ID', id);
        //predicates.equalTo('NAME', name)
        return this.rdbStore.update({ name, birthdate, gender, signature, hobby }, predicates);
    }
    //根据id删除任务
    deleteTaskById(id: number) {
        if (!this.rdbStore) {
            throw new Error('rdbStore 未初始化');
        }
        let predicates = new relationalStore.RdbPredicates(this.name);
        predicates.equalTo('ID', id);
        // 删除操作
        return this.rdbStore.delete(predicates);
    }
}
let iReadDBUtil = new DBUtil();
export default iReadDBUtil as DBUtil;

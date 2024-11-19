import { Database } from '@hw-agconnect/cloud/src/main/ets/database/Database';
import cloud from '@hw-agconnect/cloud';
import info from "../../resources/rawfile/ProjectOne_5_cn.json"
import { t_test } from '../model/t_test';

@Entry
@Component


struct DataBasePage {
  @State message: string = 'Hello World';
  private database:Database |null= null
  // 接收数据集
  @State testList :t_test[] = []

  async aboutToAppear(): Promise<void> {
    // 初始化
    this.database= cloud.database({
      zoneName:'test',
      objectTypeInfo:info
    })

    this.testList = await this.database.collection(t_test).query().get()
  }



  build() {
    Column(){
      ForEach(this.testList,(test:t_test)=>{
        Row(){
          Text(`${test.getId()}`)
          Text(test.getName())
        }
      })
    }.width("100%").height("100%")
  }
}

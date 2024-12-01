import { PreferencesUtil } from "utils/src/main/ets/puraUtils/PreferencesUtil"
import { EXP } from "../../model/EXP"
import { LogUtil } from "utils/src/main/ets/puraUtils/LogUtil"


export async function addExp(key: string, value?: number) {

  let EXPString: string = PreferencesUtil.getSync("EXP", "") as string;

  LogUtil.debug("EXPstring:" + EXPString)
  if (EXPString === '') {
    let exp: EXP[] = []
    PreferencesUtil.put("EXP", JSON.stringify(exp))
  } else {
    let exp: EXP[] = JSON.parse(EXPString) as EXP[]
    LogUtil.debug("从首选项中获取EXP:" + JSON.stringify(exp))

    let isExist: boolean = false
    for (const e of exp) {
      if (e.key === key) {
        isExist = true
        if (e.value === 0) {
          e.value += 100
        } else {
          if (value) {
            e.value += value
          }
        }
      }
    }

    if (!isExist) {
      exp.push(new EXP(key, 100))
    }
    LogUtil.debug("当前的EXP:" + JSON.stringify(exp))
    PreferencesUtil.putSync('EXP', JSON.stringify(exp))
  }
}




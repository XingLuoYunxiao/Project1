import Logger from "@bundle:com.example.ictproject/default@utils/ets/utils/Logger";
import preferences from "@ohos:data.preferences";
export class PreferenceUtil {
    private static pref: preferences.Preferences;
    static async loadPreference(context, name) {
        try { // 加载preferences
            this.pref = await preferences.getPreferences(context, name);
            Logger.debug(`加载Preferences成功`);
        }
        catch (e) {
            Logger.debug(`加载Preferences失败`, JSON.stringify(e));
        }
    }
    static async putPreferenceValue(key: string, value: preferences.ValueType) {
        if (!this.pref) {
            Logger.debug(`Preferences尚未初始化！`);
            return;
        }
        try {
            // 写入数据
            await this.pref.put(key, value);
            // 刷盘
            await this.pref.flush();
            Logger.debug(`保存Preferences[${key} = ${value}]成功`);
        }
        catch (e) {
            Logger.debug(`保存Preferences[${key} = ${value}]失败`, JSON.stringify(e));
        }
    }
    static async getPreferenceValue(key: string, defaultValue: preferences.ValueType) {
        if (!this.pref) {
            Logger.debug(`Preferences尚未初始化！`);
            return;
        }
        try {
            // 读数据
            let value = await this.pref.get(key, defaultValue);
            Logger.debug(`读取Preferences[${key} = ${value}]成功`);
            return value;
        }
        catch (e) {
            Logger.debug(`读取Preferences[${key}]失败`, JSON.stringify(e));
        }
    }
}

import CommonConstants from "@bundle:com.example.ictproject/default@Login/ets/common/CommonConstants";
import type HobbyItem from '../viewmodel/HobbyItem';
class CommonUtils {
    /**
     * 日期弹窗
     */
    datePickerDialog(dateCallback: Function) {
        DatePickerDialog.show({
            // 开始时间
            start: new Date(CommonConstants.START_TIME),
            // 结束时间
            end: new Date(),
            // 当前选中时间
            selected: new Date(CommonConstants.SELECT_TIME),
            // 是否显示农历
            lunar: false,
            onDateAccept: (value: Date) => {
                let year: number = value.getFullYear();
                let month: number = value.getMonth() + CommonConstants.PLUS_ONE;
                let day: number = value.getDate();
                let birthdate: string = this.getBirthDateValue(year, month, day);
                dateCallback(birthdate);
            }
        });
    }
    /**
     * // 获取出生日期值
     *
     * @param {number} 年
     * @param {number} 月
     * @param {number} 日
     * @returns {string} 返回生日日期
     */
    getBirthDateValue(year: number, month: number, day: number): string {
        let birthdate: string = `${year}${CommonConstants.DATE_YEAR}${month}` +
            `${CommonConstants.DATE_MONTH}${day}${CommonConstants.DATE_DAY}`;
        return birthdate;
    }
    /**
     * 文本弹窗
     */
    textPickerDialog(sexArray: Resource, sexCallback: Function) {
        if (this.isEmpty(sexArray)) {
            console.error('message:', '性别是空的！');
            return;
        }
        TextPickerDialog.show({
            range: sexArray,
            canLoop: false,
            selected: 0,
            onAccept: (result: TextPickerResult) => {
                sexCallback(result.value);
            },
            onCancel: () => {
                console.info('message:', '文本选择器对话框取消');
            }
        });
    }
    /**
     * 检查对象为空
     *
     * @param {object} obj 对象
     * @return {boolean} true(empty) 是否为空
     */
    isEmpty(obj: object | string): boolean {
        return obj === undefined || obj === null || obj === '';
    }
    /**
     * 检查数组为空
     *
     * @param {Array}array 数组
     * @return {boolean} true(empty) 是否为空
     */
    isEmptyArr(array: Array<HobbyItem>): boolean {
        return this.isEmpty(array) || array.length === 0;
    }
}
let commonUtils = new CommonUtils();
export default commonUtils as CommonUtils;

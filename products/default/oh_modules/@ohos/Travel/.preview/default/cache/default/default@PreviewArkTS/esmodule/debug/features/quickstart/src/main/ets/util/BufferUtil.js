import util from '@ohos:util';
export function bufferToString(buffer) {
    let textDecoder = util.TextDecoder.create('utf-8', {
        ignoreBOM: true
    });
    let resultPut = textDecoder.decodeToString(buffer);
    return resultPut;
}
//# sourceMappingURL=BufferUtil.js.map
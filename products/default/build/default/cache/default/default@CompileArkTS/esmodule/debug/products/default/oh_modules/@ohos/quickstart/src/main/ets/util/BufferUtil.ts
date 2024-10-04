import util from "@ohos:util";
export function bufferToString(buffer: Uint8Array): string {
    let textDecoder = util.TextDecoder.create('utf-8', {
        ignoreBOM: true
    });
    let resultPut: string = textDecoder.decodeToString(buffer);
    return resultPut;
}

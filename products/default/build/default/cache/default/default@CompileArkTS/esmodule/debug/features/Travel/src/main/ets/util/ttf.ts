import font from "@ohos:font";
export function ttf(TTFname: string, TTFSrc: string) {
    font.registerFont({
        familyName: TTFname,
        familySrc: { "id": -1, "type": 30000, params: [TTFSrc], "bundleName": "com.example.ictproject", "moduleName": "default" }
    });
}

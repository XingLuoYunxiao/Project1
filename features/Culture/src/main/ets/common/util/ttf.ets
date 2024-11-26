import { font } from "@kit.ArkUI";

export function  ttf(TTFname:string,TTFSrc:string) {
  font.registerFont({
    familyName: TTFname,
    familySrc: $rawfile(TTFSrc)
  })
}
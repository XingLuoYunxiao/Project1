export function determineImg(text) {
    return text.trim().indexOf('![') !== -1 && text.trim().indexOf('](') !== -1 && text.trim().indexOf(')') !== -1 ? true : false;
}

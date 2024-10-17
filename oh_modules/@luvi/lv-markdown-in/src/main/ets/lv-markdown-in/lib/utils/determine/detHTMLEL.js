export function determineHTMLIMG(text) {
    return text.trim().indexOf('<img') !== -1 && text.trim().indexOf('src=') !== -1 ? true : false;
}
export function determineHTMLFONT(text) {
    return text.trim().indexOf('<font') !== -1 && text.trim().indexOf('font>') !== -1 ? true : false;
}

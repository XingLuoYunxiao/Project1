export function determineTable(text) {
    return text.split('|').length - 1 > 2 ? true : false;
}

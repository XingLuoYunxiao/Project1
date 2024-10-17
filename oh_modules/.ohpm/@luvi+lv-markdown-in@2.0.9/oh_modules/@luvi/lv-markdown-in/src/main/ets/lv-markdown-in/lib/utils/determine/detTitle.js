export function determineTitle(text) {
    return text.trim().slice(0, 1) === '#' ? true : false;
}

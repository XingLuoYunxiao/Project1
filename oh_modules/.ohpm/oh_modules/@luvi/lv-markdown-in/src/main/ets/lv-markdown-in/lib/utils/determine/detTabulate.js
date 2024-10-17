function g6(str) {
    const n6 = /^\d+$/;
    return n6.test(str);
}
export function determineTabulate(text, h6, i6) {
    let check = text.trim().split(".");
    let j6 = h6?.trim().split(".");
    let k6 = i6?.trim().split(".");
    if ((check.length > 1 && g6(check[0]) && j6.length > 1 && g6(j6[0])) ||
        (check.length > 1 && g6(check[0]) && k6.length > 1 && g6(k6[0]))) {
        return true;
    }
    const l6 = text.trim().slice(0, 1);
    const m6 = text.trim().slice(1, 2);
    return ((l6 === '*' && m6 !== '*') || l6 === '-' || l6 === '+') ? true : false;
}

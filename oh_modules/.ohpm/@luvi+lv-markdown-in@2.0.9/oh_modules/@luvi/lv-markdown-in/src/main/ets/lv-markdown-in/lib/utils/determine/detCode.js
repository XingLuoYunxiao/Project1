export function determineCode(text) {
    return text.trim().slice(0, 3) == '```' ? true : false;
}

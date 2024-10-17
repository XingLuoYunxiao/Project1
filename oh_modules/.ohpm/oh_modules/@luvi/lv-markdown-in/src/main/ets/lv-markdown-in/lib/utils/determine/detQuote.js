export function determineQuote(text) {
    return text.trim().slice(0, 1) === '>' ? true : false;
}

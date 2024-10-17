export function determineCheckbox(text) {
    return (text.trim().slice(0, 3) === '- [' && text.trim().indexOf(']') !== -1) ? true : false;
}

export default function handleUrlText(text) {
    return text.split(/(\[[^\]]+\]\([^\)]+\))/g);
}

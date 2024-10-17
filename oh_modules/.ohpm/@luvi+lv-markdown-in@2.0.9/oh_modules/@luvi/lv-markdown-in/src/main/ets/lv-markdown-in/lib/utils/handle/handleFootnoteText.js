export default function handleFootnoteText(text) {
    return text.split(/(\[\^[^\]]+\]\([^\)]+\))/g);
}

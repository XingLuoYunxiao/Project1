export default function handleImgText(text) {
    return text.split(/(\!\[.*?\))/g);
}

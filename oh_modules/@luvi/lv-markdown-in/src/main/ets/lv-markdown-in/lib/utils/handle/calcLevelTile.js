export default function calcLevelTile(text) {
    let size = 0;
    text.slice(0, 6).split('').forEach((item) => item == '#' ? ++size : size);
    return size;
}

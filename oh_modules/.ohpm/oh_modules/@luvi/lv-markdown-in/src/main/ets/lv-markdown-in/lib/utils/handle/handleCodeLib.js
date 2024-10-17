export default function handleCodeLib(text) {
    let p6 = (/([(\s=){}."])/gi);
    return text.split(p6);
}

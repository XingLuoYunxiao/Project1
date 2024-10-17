var LV_MD_CONTENT_TYPE;
(function (z5) {
    z5["TITLE"] = "title";
    z5["TEXT"] = "text";
    z5["QUOTE"] = "quote";
    z5["URL"] = "url";
    z5["IMG"] = "img";
    z5["LINE"] = "line";
    z5["CODE"] = "code";
    z5["TABLE"] = "table";
    z5["TABULATE"] = "tabulate";
    z5["CHECKBOX"] = "checkbox";
    z5["HTMLIMG"] = "htmlImg";
    z5["HTMLFONT"] = "htmlFont";
    z5["FOOTNOTE"] = "footNote";
})(LV_MD_CONTENT_TYPE || (LV_MD_CONTENT_TYPE = {}));
var LV_MD_DATA_TYPE;
(function (y5) {
    y5[y5["FLAG"] = 0] = "FLAG";
    y5[y5["MSG"] = 1] = "MSG";
})(LV_MD_DATA_TYPE || (LV_MD_DATA_TYPE = {}));
var LV_TEXT_TYPE;
(function (x5) {
    x5["L_BOLD"] = "lvTextBold";
    x5["L_ITALIC"] = "lvTextItalic";
    x5["L_MARK"] = "lvTextMark";
    x5["L_DEL"] = "lvTextDel";
    x5["L_PINK"] = "lvTextPink";
})(LV_TEXT_TYPE || (LV_TEXT_TYPE = {}));
const SP_TYPE = {
    SPK: "=~=SPK65LUVIMDIN=~=",
    SPL: "SPL65"
};
export { LV_MD_CONTENT_TYPE, LV_MD_DATA_TYPE, LV_TEXT_TYPE, SP_TYPE };

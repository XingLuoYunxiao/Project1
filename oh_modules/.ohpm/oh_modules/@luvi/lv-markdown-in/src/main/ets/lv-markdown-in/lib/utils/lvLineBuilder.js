export default function lvLineBuilder(parent = null) {
    (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender) => {
        Column.create();
        Column.alignItems(HorizontalAlign.Start);
        Column.width('100%');
        Column.height(1);
        Column.backgroundColor('#eee');
        Column.margin({
            top: 10, bottom: 10
        });
    }, Column);
    Column.pop();
}

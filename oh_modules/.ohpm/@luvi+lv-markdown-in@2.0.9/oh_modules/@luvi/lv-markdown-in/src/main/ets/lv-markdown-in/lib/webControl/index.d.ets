import a17 from '@ohos.web.webview';
import { LvLink } from '../domain/LvLink';
@CustomDialog
export declare struct WebControl {
    controller: CustomDialogController;
    webController: a17.WebviewController;
    @State
    mode: MixedMode;
    @State
    loading: boolean;
    @State
    nLink: LvLink;
    build(): void;
}

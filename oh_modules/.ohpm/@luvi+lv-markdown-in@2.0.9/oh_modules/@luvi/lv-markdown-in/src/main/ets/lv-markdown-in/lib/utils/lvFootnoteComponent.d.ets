import { LvLink } from '../domain/LvLink';
import { LvText } from '../domain/LvText';
import { LvFootnoteController } from './controller/lvFootnoteController';
@Component
export declare struct lvFootnoteView {
    @State
    footnoteController: LvFootnoteController;
    @State
    dialogController: CustomDialogController | null;
    @State
    nText: LvText;
    @State
    nLink: LvLink;
    openUrl(uri: string): void;
    build(): void;
}

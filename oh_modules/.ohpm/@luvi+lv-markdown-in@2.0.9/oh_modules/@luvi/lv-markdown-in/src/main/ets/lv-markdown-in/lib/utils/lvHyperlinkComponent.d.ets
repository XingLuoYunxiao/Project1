import { LvLink } from '../domain/LvLink';
@Component
export declare struct lvHyperlinkComponent {
    @Prop
    text: string;
    @Prop
    uri: string;
    @Prop
    nLink: LvLink;
    @Prop
    fontSize: number | string;
    @Prop
    fontWeight: FontWeight;
    @Prop
    dialogController: CustomDialogController | null;
    build(): void;
}
@Builder
export default function lvHyperlinkBuilder(text: string, uri: string, c12: LvLink, fontSize: number | string, fontWeight: FontWeight, d12: CustomDialogController | null): void;

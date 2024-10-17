@Component
export declare struct lvTableComponent {
    @State
    text: string;
    @State
    dialogController: CustomDialogController | null;
    build(): void;
}

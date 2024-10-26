@Component
export struct MyButton {
  @Prop Text: string = ''

  build() {
    Button(this.Text)
      .backgroundColor('#ffd0e8fc')
      .width(80)
      .height(40)
  }
}
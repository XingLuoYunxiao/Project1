@Component
export struct HighLightText {
  @Prop totalString: string
  @Prop highLightStr: string
  @State leftStr: string = ''
  @State rightStr: string = ''

  aboutToAppear(): void {
    this.updateTextParts();
  }

  build() {
    Text() {
      Span(this.leftStr)
        .fontSize($r('app.float.normal_text_size1'))
      Span(this.highLightStr)
        .fontSize($r('app.float.normal_text_size1'))
        .fontColor(Color.Red)
      Span(this.rightStr)
        .fontSize($r('app.float.normal_text_size1'))
    }
  }

  // 新增方法，用于更新左侧和右侧字符串
  private updateTextParts(): void {
    if (!this.totalString || !this.highLightStr) {
      this.leftStr = this.totalString || '';
      this.rightStr = '';
      return;
    }

    const index = this.totalString.indexOf(this.highLightStr);
    if (index !== -1) {
      this.leftStr = this.totalString.substring(0, index);
      this.rightStr = this.totalString.substring(index + this.highLightStr.length);
    } else {
      // 如果没有找到高亮字符串，则全部文本都放在左侧
      this.leftStr = this.totalString;
      this.rightStr = '';
    }
  }
}
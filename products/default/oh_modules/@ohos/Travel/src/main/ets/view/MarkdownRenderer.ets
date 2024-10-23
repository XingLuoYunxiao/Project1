import webview from '@ohos.web.webview';

@Component
export struct MarkdownRenderer {
  @State content: string = '';
  @State webHeight: number = 0;
  controller: webview.WebviewController = new webview.WebviewController();

  private getMarkdownHtml(markdown: string): string {
    return `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/styles/default.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/highlight.min.js"></script>
        <style>
          body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
          pre { background-color: #f4f4f4; padding: 1em; border-radius: 4px; }
          code { font-family: 'Courier New', Courier, monospace; }
        </style>
      </head>
      <body>
        <div id="content"></div>
        <script>
          const markdown = ${JSON.stringify(markdown)};
          document.getElementById('content').innerHTML = marked.parse(markdown);
          hljs.highlightAll();
          // 发送内容高度给 ArkTS
          const sendHeight = () => {
            window.parent.postMessage(document.body.scrollHeight, '*');
          };
          window.onload = sendHeight;
          // 监听内容变化
          const observer = new MutationObserver(sendHeight);
          observer.observe(document.body, { subtree: true, childList: true });
        </script>
      </body>
      </html>
    `;
  }

  build() {
    Column() {
      Web({ src: this.getMarkdownHtml(this.content), controller: this.controller })
        .height(this.webHeight)
        .onPageEnd(() => {
          // 页面加载完成后，注入 JavaScript 来获取内容高度
          this.controller.runJavaScript('document.body.scrollHeight;', (height) => {
            this.webHeight = Number(height);
          });
        })

    }
  }
}
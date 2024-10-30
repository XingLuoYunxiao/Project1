const sensitive:string[]=['卧槽','我操','滚','傻']

@Component
export struct AdvicePage {
  @Consume ('loginPathStack') loginPathStack: NavPathStack
  @State content:string=''
  @State wordcount:number=0
  controller: TextAreaController = new TextAreaController()
  build() {
      NavDestination(){
        Column() {
          Row(){
            Image($r('app.media.ic_back')).width(30).onClick(()=>{
              this.loginPathStack.pop()
            })
            Text('反馈')
          }.width('100%')
          TextArea({ placeholder: '请写下您的建议反馈', text: this.content ,controller: this.controller})
            .maxLength(200)
            .maxLines(10)
            .textOverflow(TextOverflow.None)
            .height(220)
            .margin({top:20})
            .onChange((value:string)=>{
              this.content=value
              //敏感词限制
              for(const sensitiv of sensitive){
                if(value.includes(sensitiv)){
                  AlertDialog.show({
                    title: '警告',
                    message: '抱歉,您的内容包含敏感词汇,建议您对相关内容进行调整,谢谢您的配合和理解！',
                    confirm: {
                      value: '确定',
                      action: () => {
                        console.info('Button-clicking callback')
                      }
                    },
                  })
                  this.content=this.content.replace(sensitiv,'')
                }
              }
              //字数统计
              this.wordcount=this.content.length
              if(this.wordcount===200){
                AlertDialog.show({
                  message: '已达最大输入字数',
                  confirm: {
                    value: '确定',
                    action: () => {
                      console.info('Button-clicking callback')
                    }
                  }
                })
              }
          })
          Row(){
            Blank()
            Text(`${this.wordcount}/200`)
          }.width('100%')
          Button('提交').onClick(()=>{
            this.content=''
            AlertDialog.show({
              message: '感谢您的建议,我们会积极配合!',
              confirm: {
                value: '确定',
                action: () => {
                  console.info('Button-clicking callback')
                }
              }
            })
          })
        }
        .margin({top:10,left:10,right:10})
        .width('100%')
      }.hideTitleBar(true)
  }
}

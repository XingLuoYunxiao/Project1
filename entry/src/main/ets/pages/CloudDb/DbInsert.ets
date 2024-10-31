import { router } from '@kit.ArkUI';
import { cloudDatabase } from '@kit.CloudFoundationKit';
import { Post } from './Post';

interface RouterParamsType {
  isEditing?: boolean
  checkBoxStatus?: boolean
  recordId?: string
  content?: string
}

@Entry
@Component
struct DbInsert {
  private params = router.getParams() as Record<string, Object>
  private isEditing: boolean = this.params.isEditing as boolean;
  private recordId: string = this.params.recordId as string;
  private contentR: string = this.params.content as string;
  private checkBoxChecked: boolean = this.params.checkBoxStatus as boolean;
  // fixed userId
  private userId = '9527';
  @State content: string = '';
  agcDataBase: cloudDatabase.DatabaseZone | undefined = undefined;

  aboutToAppear() {
    // 'Demo' is the 'cloudDBZoneName' field defined in CloudProgram/clouddb/dataentry/d_Post.json
    this.agcDataBase = cloudDatabase.zone('Demo');
  }

  onPageShow() {
    if (this.recordId?.length) {
      this.content = this.contentR;
    }
  }

  async handleUpsert() {
    if (this.content !== '') {
      let post = new Post();
      if (this.isEditing) {
        post.id = Number(this.recordId.toString());
      } else {
        post.id = Math.round(Math.random() * 100)
      }
      post.content = this.content;
      post.insertDate = new Date();
      post.userId = this.userId;

      try {
        await this.agcDataBase?.upsert(post);
        AlertDialog.show({
          title: $r('app.string.dialog_success_title'),
          message: $r('app.string.dialog_success_message'),
          cancel: () => {
            let params: RouterParamsType = { checkBoxStatus: this.checkBoxChecked }
            router.back({ url: 'pages/CloudDb/CloudDb', params });
          }
        });
        this.content = '';
      } catch (err) {
      }
    }
  }

  build() {
    Column() {
      Navigation()
        .title($r('app.string.cloudDB_label'))
        .height('50vp')
        .width('100%')
        .margin({ bottom: 10 })
        .titleMode(NavigationTitleMode.Mini)

      Column() {
        TextArea({ text: this.content })
          .height(100)
          .margin({ top: 20 })
          .backgroundColor($r('app.color.start_window_background'))
          .border({
            color: $r('app.color.body_color'),
            width: 1,
            radius: 4
          })
          .onChange((event) => {
            this.content = event;
          })

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text($r('app.string.publishButton_label'))
            .textAlign(TextAlign.Center)
            .fontSize($r('app.float.body_font_size'))
            .width('90%')
            .height(40)
        }
        .margin({ top: 10 })
        .borderRadius(4)
        .width('100%')
        .onClick(() => {
          this.handleUpsert();
        })
      }.margin({
        left: 20,
        right: 20
      })
    }.height('100%')
  }
}
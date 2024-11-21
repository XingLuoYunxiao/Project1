import { router } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { cloudDatabase } from '@kit.CloudFoundationKit';
import { Post } from './Post';

const TAG = '[CloudDBPage]';

interface RouterParamsType {
  isEditing?: boolean
  checkBoxStatus?: boolean
  recordId?: string
  content?: string
}

@Entry
@Component
struct CloudDb {
  private scroller: Scroller = new Scroller()
  @State isSelected: boolean = false;
  @State isShowButton: boolean = true;
  @State allRecords: Post[] = [];
  @State likeCount: number = 0;
  agcDataBase: cloudDatabase.DatabaseZone | undefined = undefined;
  condition: cloudDatabase.DatabaseQuery<cloudDatabase.DatabaseObject> | undefined = undefined;
  // fixed userId
  private userId = '9527';

  onPageShow() {
    this.orderByDate()
  }

  aboutToAppear() {
    // 'Demo' is the 'cloudDBZoneName' field defined in CloudProgram/clouddb/dataentry/d_Post.json
    this.agcDataBase = cloudDatabase.zone('Demo');
    this.orderByDate()
  }

  async getPostList() {
    try {
      this.condition = new cloudDatabase.DatabaseQuery(Post);
      this.condition?.orderByDesc('insertDate').limit(100, 0)
      const resultArray = await this.agcDataBase?.query(this.condition)
      this.allRecords = resultArray as Post[]
      hilog.info(0x0000, 'CloudDB', 'query success : %{public}s', JSON.stringify(resultArray));
    } catch (err) {
      hilog.error(0x0000, 'CloudDB', 'query err %{public}s', JSON.stringify(err));
    }
  }

  async orderByMostLiked() {
    try {
      this.condition = new cloudDatabase.DatabaseQuery(Post);
      this.condition?.orderByDesc('likeCount').limit(100, 0)
      const resultArray = await this.agcDataBase?.query(this.condition)
      this.allRecords = resultArray as Post[]
      hilog.info(0x0000, 'CloudDB', 'query success : %{public}s', JSON.stringify(resultArray));
    } catch (err) {
      hilog.error(0x0000, 'CloudDB', 'query err %{public}s', JSON.stringify(err));
    }
  }

  async getMyPosts(uid: string) {
    try {
      this.condition = new cloudDatabase.DatabaseQuery(Post);
      this.condition?.equalTo('userId', uid).orderByDesc('insertDate')
      const resultArray = await this.agcDataBase?.query(this.condition)
      this.allRecords = resultArray as Post[]
    } catch (err) {
    }
  }

  async getMyPostsByLike(uid: string) {
    try {
      this.condition = new cloudDatabase.DatabaseQuery(Post);
      this.condition?.equalTo('userId', uid).orderByDesc('likeCount')
      const resultArray = await this.agcDataBase?.query(this.condition)
      this.allRecords = resultArray as Post[]
    } catch (err) {
    }
  }

  async deleteRecord(post: Post) {
    try {
      const record = await this.agcDataBase?.delete(post)
      hilog.info(0x0000, 'CloudDB', 'delete success: %{public}d', record);
      this.onCheckboxToggle()
    } catch (err) {
    }
  }

  async updateLikeCount(item: Post) {
    let likes: string[] = JSON.parse(item.likes)
    let userId: string = this.userId;
    let index: number = likes.indexOf(userId);
    if (index >= 0) {
      likes = likes.filter((item: string) => item !== userId)
      item.likeCount = likes.length
      item.likes = JSON.stringify(likes)
    } else {
      likes.push(userId);
      item.likeCount = likes.length
      item.likes = JSON.stringify(likes)
    }
    try {
      await this.agcDataBase?.upsert(item)
    } catch (err) {
    }
    this.allRecords = this.allRecords.map((record: Post) => {
      if (record.id?.toString() == item.id?.toString()) {
        hilog.info(0x0000, 'CloudDB', 'record: %{public}s', JSON.stringify(record))
        record.likeCount = item.likeCount
        record.likes = item.likes
      }
      return record
    })
  }

  async orderByDate() {
    if (this.isSelected) {
      let userId: string = this.userId;
      this.getMyPosts(userId)
    } else {
      this.getPostList()
    }
  }

  async orderByLikes() {
    if (this.isSelected) {
      let userId: string = this.userId;
      this.getMyPostsByLike(userId)
    } else {
      this.orderByMostLiked();
    }
  }

  async onCheckboxToggle() {
    if (this.isSelected) {
      let userId: string = this.userId;
      this.getMyPosts(userId)
    } else {
      this.getPostList()
    }

  }

  onCancel() {
    hilog.info(0x00, TAG, 'Cancel button is clicked');
  }

  onAccept() {
    hilog.info(0x00, TAG, 'Confirm button is clicked');
  }

  existApp() {
    hilog.info(0x00, TAG, 'Click the callback in the blank area');
  }

  pad(val: number) {
    let str = val.toString();
    return str.padStart(2, '0');
  }

  getFormattedDate(date: Date) {
    return (
      [date.getFullYear(), this.pad(date.getMonth() + 1), this.pad(date.getDate())].join('-')
        +
        ' '
        +
      [this.pad(date.getHours()), this.pad(date.getMinutes()), this.pad(date.getSeconds()),].join(':')
    );
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
        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          Row() {
            Row() {
              Text($r('app.string.cloudDB_Publications')).fontSize($r('app.float.list_item_font_size')).onClick(() => {
                // order by date
                this.orderByDate();
              })
              Text('|').fontSize($r('app.float.list_item_font_size')).margin({ left: 5 })
              Text($r('app.string.cloudDB_HighestHit'))
                .fontSize($r('app.float.list_item_font_size'))
                .margin({ left: 5 })
                .onClick(() => {
                  this.orderByLikes();
                })
            }.border({ radius: 4, width: 1 }).padding(5)

            Row() {
              Checkbox()
                .width(8)
                .height(8)
                .onChange((value: boolean) => {
                  this.isSelected = value;
                  this.onCheckboxToggle();
                })
                .onAppear(() => {
                  this.onCheckboxToggle();
                })
                .select(this.isSelected)
                .visibility(Visibility.Hidden)
              Text($r('app.string.cloudDB_SeeOnly'))
                .fontSize($r('app.float.list_item_font_size'))
                .visibility(Visibility.Hidden)
            }
          }.margin({ left: 5 })

          Row() {
            Button({ type: ButtonType.Normal, stateEffect: true }) {
              Text($r('app.string.cloudDB_new_record'))
                .fontSize($r('app.float.list_item_font_size'))
                .textAlign(TextAlign.Center)
                .margin(5)
                .fontColor($r('app.color.white'))
            }
            .width(70)
            .height(24)
            .borderRadius(4)
            .onClick(() => {
              let params: RouterParamsType = {
                isEditing: false,
                checkBoxStatus: this.isSelected,
              }
              router.pushUrl({
                url: 'pages/CloudDb/DbInsert',
                params
              });
            })
          }
        }.margin({ top: 10, bottom: 10 })

        Column() {
          // eslint-disable-next-line @hw-ets-eslint/init-list-component
          List({ initialIndex: 0, scroller: this.scroller }) {
            // eslint-disable-next-line @performance/hp-arkui-load-on-demand
            ForEach(this.allRecords, (item: Post) => {
              ListItem() {
                Column() {
                  Flex({ justifyContent: FlexAlign.SpaceBetween }) {
                    Image($r('app.media.window')).width(20).height(20)
                    Text(item.insertDate ? this.getFormattedDate(new Date(item.insertDate)) : '')
                      .fontSize($r('app.float.list_item_font_size'))
                  }.margin({ bottom: 15 })

                  Row() {
                    Text(item.content)
                      .fontSize($r('app.float.list_item_font_size'))
                      .width('100%')
                      .maxLines(2)
                  }.margin({ bottom: 15 })

                  Flex({ justifyContent: FlexAlign.SpaceBetween }) {
                    if (item.userId === this.userId) {
                      Row() {
                        Image($r('app.media.ic_public_delete_filled_red'))
                          .width(20)
                          .height(20)
                          .margin({ right: 10 })
                          .onClick(() => {
                            AlertDialog.show({
                              title: $r('app.string.deleteButton_label'),
                              message: $r('app.string.popUpDesc_label'),
                              primaryButton: {
                                value: $r('app.string.deleteButton_label'),
                                action: () => {
                                  this.deleteRecord(item)
                                },
                                backgroundColor: $r('app.color.dialog_cancel_background'),
                                fontColor: $r('app.color.white')
                              },
                              secondaryButton: {
                                value: $r('app.string.cancelButton_label'),
                                action: () => {
                                  this.onCancel();
                                },
                                fontColor: $r('app.color.action_button_background')
                              },
                              autoCancel: true
                            });
                          })
                        Image($r('app.media.ic_public_edit_outline'))
                          .width(20)
                          .height(20)
                          .onClick(() => {
                            let recordId = ''
                            if (item.id !== undefined) {
                              recordId = item.id.toString()
                            }
                            let params: RouterParamsType = {
                              isEditing: true,
                              recordId: recordId,
                              content: item.content,
                              checkBoxStatus: this.isSelected,
                            }
                            router.pushUrl({
                              url: 'pages/CloudDb/DbInsert',
                              params
                            });
                          })
                      }
                    }
                    Row() {
                      Text(item.likeCount.toString()).fontSize($r('app.float.list_item_font_size'))
                      Image(item.likes?.includes(this.userId) ? $r('app.media.ic_public_thumb_sup_filled') :
                      $r('app.media.ic_public_thumb_sup'))
                        .width(20)
                        .height(20)
                        .margin({ left: 5 })
                        .onClick(() => {
                          this.updateLikeCount(item);
                        })
                    }
                  }
                }
              }
              .padding(10)
              .border({ color: $r('app.color.black'), width: 1, radius: 4 })
              .margin({ top: 10 })
            })
          }
          .height('85%')
          .width('100%')
          .scrollBar(BarState.Off)
        }

      }.alignItems(HorizontalAlign.Start).margin({
        left: 20,
        right: 20
      })
    }

  }
}
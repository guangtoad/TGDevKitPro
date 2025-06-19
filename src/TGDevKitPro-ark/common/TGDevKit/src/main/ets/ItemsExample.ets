/**
 * @file ItemsExample.ets
 * @name
 * @summary
 * @description
 * @author toad
 * @create 2025/01/15
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */
@Preview
@Component
export struct MallNavigationItemComponent {
  @State title: string = "asdasd";
  @State popupIsShow: boolean = true;

  // @State popupMenu:ELCGridItemData[] = new Array(new ELCGridItemData().);
  // popup构造器定义弹框内容
  @Builder
  popupBuilder() {
    Column() {
      Row() {
        Image($r("app.media.app_icon"))
          .width("24vp")
          .height("24vp")
        Text("1")
      }
      .onClick(() => {
      }).backgroundColor(Color.Transparent)

      Row() {
        Image($r("app.media.app_icon"))
          .width("24vp")
          .height("24vp")
        Text("1")
      }
      .onClick(() => {
      }).backgroundColor(Color.Transparent)

      Row() {
        Image($r("app.media.app_icon"))
          .width("24vp")
          .height("24vp")
        Text("1")
      }
      .onClick(() => {
      }).backgroundColor(Color.Transparent)
    }
    .backgroundColor(Color.White)
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.app_icon'))
          .width("40vp")
          .height("40vp")
          .alignSelf(ItemAlign.Start)
          .onClick(() => {

          })
        Text(this.title)
          .alignSelf(ItemAlign.Center)

        Row({ space: '4vp' }) {
          Image($r('app.media.app_icon'))
            .width("40vp")
            .height("40vp")
            .onClick(() => {

            })
          Image($r('app.media.app_icon'))
            .width("40vp")
            .height("40vp")

            .onClick(() => {
              this.popupIsShow = !this.popupIsShow;
            })
        }
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center) // 垂直居中
      .width("100%")
      .height("48vp")
    }
    .backgroundColor(Color.Gray)
    .justifyContent(FlexAlign.SpaceBetween)
    .width("100%")
    .height("100%")
  }
}
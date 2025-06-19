/**
 * @file MallNavigationItem.ets
 * @name
 * @summary 商城导航栏
 * @description
 * @author toad
 * @create 2025/01/14
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */
@Preview
@Component
export struct MallNavigationItemComponent {
  /**
   * 标题
   */
  @State title: string = "";
  /**
   * 下拉菜单显示状态
   */
  @State popupIsShow: boolean = true;

  /**
   * popup构造器定义弹框内容
   */
  @Builder
  popupBuilder() {
    Column({ space: "8vp" }) {
      // ForEach(this.popupMenu, (item: ELCListViewItemData) => {
      Row({ space: "8vp" }) {
        Image($r('app.media.app_icon'))
          .width("24vp")
          .height("24vp")
        Text("adfsdfsdf")
          .fontSize("12vp")
          .margin({ left: 0, right: 0 })
      }
      .padding({ left: "2vp", right: '2vp' })
      .onClick(() => {
        // this.popupIsShow = false;
        // item.onAction?.(item);
      }).backgroundColor(Color.Transparent)

      Row({ space: "2vp" }) {
        Image($r('app.media.app_icon'))
          .width("24vp")
          .height("24vp")
        Text("adfsdfsdf")
          .margin({ left: 0, right: 0 })
      }
      .padding({ left: "2vp", right: '2vp' })
      .onClick(() => {
        // this.popupIsShow = false;
        // item.onAction?.(item);
      }).backgroundColor(Color.Transparent)

      Row({ space: "2vp" }) {
        Image($r('app.media.app_icon'))
          .width("24vp")
          .height("24vp")
        Text("adfsdfsdf")
          .margin({ left: 0, right: 0 })
      }
      .padding({ left: "2vp", right: '2vp' })
      .onClick(() => {
        // this.popupIsShow = false;
        // item.onAction?.(item);
      }).backgroundColor(Color.Transparent)

      // })
    }
    .backgroundColor(Color.White)
    .padding({
      top: "8vp",
      bottom: "8vp",
      left: "8vp",
      right: "8vp",
    })
  }

  /**
   * 画面构建
   */
  build() {
    Column() {
      RelativeContainer() {

        // 信息按钮
        Image($r('app.media.app_icon'))
          .width("22vp")
          .height("21vp")
          .margin({ left: "17vp" })
          .alignRules({
            start: { anchor: '__container__', align: HorizontalAlign.Start },
            center: { anchor: '__container__', align: VerticalAlign.Center }
          })
          .onClick(() => {

          })
        // 标题
        Text(this.title)
          .fontSize("20vp")
          .alignRules({
            middle: { anchor: '__container__', align: HorizontalAlign.Center },
            center: { anchor: '__container__', align: VerticalAlign.Center }
          })

        Row({ space: '17vp' }) {
          Image($r('app.media.app_icon'))
            .width("22vp")
            .height("21vp")
            .onClick(() => {

            })
          Image($r('app.media.app_icon'))
            .width("22vp")
            .height("21vp")
            .bindPopup(this.popupIsShow, {
              builder: this.popupBuilder(),
              placement: Placement.Bottom,
              radius: "3vp",
              shadow: { radius: 0 },
              backgroundBlurStyle: BlurStyle.NONE,
              enableArrow: false,
              arrowOffset: "12vp",
              offset: { x: 0, y: "12vp" },
            })
            .onClick(() => {
              this.popupIsShow = !this.popupIsShow;
            })
        }
        .margin({ right: "17vp" })
        .alignRules({
          end: { anchor: '__container__', align: HorizontalAlign.End },
          center: { anchor: '__container__', align: VerticalAlign.Center }
        })
      }
      .width("100%")
      .height("44vp")
      .backgroundColor(Color.White)
    }
    .backgroundColor(Color.Gray)
    .width("100%")
    .height("100%")
  }
}
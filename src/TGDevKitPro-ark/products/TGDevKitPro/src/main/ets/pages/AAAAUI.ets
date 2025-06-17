/**
 * @file AAAAUI.ets
 * @name
 * @summary
 * @description
 * @author toad
 * @create 2025/02/12
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */
@Preview
@Component
export struct ServiceActivityHeaderComponent {
  // controller?: ServiceActivityHeaderController;
  @State selectIndex: number = 0
  onChange?: (index: number) => void;
  @State titles: string[] = ["asd", "asd", "asd"];

  build() {
    Column() {
      Row() {
        ForEach(this.titles, (title: string, row: number) => {
          Column() {
            Text(title)
            // if (row == this.selectIndex) {
            Divider()
              .width(`100%`)
              .height("1vp")
              .backgroundColor(Color.Black)
              .visibility(row == this.selectIndex ? Visibility.Visible : Visibility.Hidden);
            // }
            // else{

            // }
          }
          .width(`${100 / this.titles.length}%`)
          .onClick(() => {
            this.selectIndex = row;
          });
        });
      }
    }
    .width("100%")
    .height("100%")
    .backgroundColor(Color.Gray)
  }
}
/**
 * @file AAAA.ets.ets
 * @name
 * @summary
 * @description
 * @author toad
 * @create 2025/02/11
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */


@Preview
@Component
export struct AAAA {
  @State list: string[] = ["asd", "asd", "bb"];
  style:SubTabBarStyle = SubTabBarStyle.of('pink')
    .selectedMode(SelectedMode.BOARD)
    .board({ borderRadius: "48vp" })
    .indicator({
      color: Color.Blue, //下划线颜色
      selectedColor: Color.Blue,
      height: "2vp", //下划线高度
      width:"24vp",
      marginTop: "8vp"
    })
  // .labelStyle({
  //   font: { size: "16vp" },
  //   selectedColor: Color.Black,
  //   unselectedColor: Color.Gray
  // })
  build() {
    Tabs() {
      TabContent() {
        Column()
          .width("100%")
          .height("100%")
      }
      .tabBar(this.style
      )
      TabContent() {
        Column()
          .width("100%")
          .height("100%")
      }
      .tabBar(this.style
      )

    }
    // .barHeight("49vp")
    // .barWidth("100%")
    .width("100%")
    .height("100%")
  }
}
/**
 * @file tabs.ets
 * @name
 * @summary
 * @description
 * @author toad
 * @create 2025/02/13
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */

@Preview
@Component
struct TabsTest {
  @State barHeight: Length = "56vp"
  @State subBarHeight: Length = "30vp"
  @State indicatorWidth: Length = "162vp";
  @State barWidth:Length = "90%";
  // @State dis


  createBarStyle(str: string) {
    return SubTabBarStyle.of(str)
      .indicator({
        color: "#262626", //下划线颜色
        height: "2vp", //下划线高度
        selectedColor: "#262626",
        marginTop: "16vp",
        width: this.indicatorWidth, //下划线宽度
      })

      .labelStyle({
        font: { size: "16vp" },
        selectedColor: "#262626",
        unselectedColor: "#707070"
      })
  }

  createSubBarStyle(str: string) {
    return SubTabBarStyle
      .of(str)
      .indicator({
        color: "#3674BA", //下划线颜色
        height: "2vp", //下划线高度
        borderRadius: "26vp", //下划线圆角半径
        // marginTop: "0vp" //下划线与文字间距
        width: 10000, //下划线宽度
      })
      .selectedMode(SelectedMode.BOARD)
      .board({ borderRadius: "26vp" })
      .labelStyle({
        // overflow?: TextOverflow;
        // maxLines?: number;
        // minFontSize?: number | ResourceStr;
        // maxFontSize?: number | ResourceStr;
        // heightAdaptivePolicy?: TextHeightAdaptivePolicy;
        // font?: Font;
        selectedColor: "#FFFFFF",
        unselectedColor: "#1A1A1A"
      })
      .padding({
        left: 6,
        right: 6,
        top: 0,
        bottom: 0
      })
  }
  build() {
    Column() {
      Tabs() {
        TabContent() {
          Tabs() {
            TabContent() {
              // Stack() {
              Text("asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd00asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd00asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd00")
                //   Column() {
              //     Image($r("app.media.no_information"))
              //       .width("150vp")
              //       .height("150vp")
              //     Text("没有")
              //   }
              // }
              .width("100%")
              .height("100%")
            }
            .padding({top:"26vp"})
            .tabBar(
              this.createSubBarStyle(`子标题`)
            )

            TabContent() {
              Text("page1")
            }
            .tabBar(
              this.createSubBarStyle(`子标题`)
            )

            TabContent() {
              Text("page1")
            }
            .tabBar(
              this.createSubBarStyle(`子标题`)
            )
          }
          .barHeight(this.subBarHeight)
          .barWidth(this.barWidth)
          // .barBackgroundColor(Color.Green)
          // .barPosition({})
          // .width("calc(100% - 16vp - 16vp)")
          .height("100%")
        }
        .tabBar(
          this.createBarStyle(`主要标题`)
        )
        .padding({ top: "20vp" })
        .width("100%")
        .height("100%")

        TabContent() {
          Tabs() {
            TabContent() {
              Stack() {
                Column() {
                  Image($r("app.media.no_information"))
                    .width("150vp")
                    .height("150vp")
                  Text("没有")
                }
              }
              .width("100%")
              .height("100%")
            }
            .tabBar(
              this.createSubBarStyle(`子标题`)
            )

            TabContent() {
              Text("page1")
            }
            .tabBar(
              this.createSubBarStyle(`子标题`)
            )

            TabContent() {
              Text("page1")
            }
            .tabBar(
              this.createSubBarStyle(`子标题`)
            )
          }
          .barHeight(this.subBarHeight)
          .width("100%")
          .height("100%")
        }
        .tabBar(
          this.createBarStyle(`主要标题`)
        )
        .padding({ top: "20vp" })
        .width("100%")
        .height("100%")
      }
      .barBackgroundColor(Color.Red)
      .barHeight(this.barHeight)
      // .barWidth("90%")
      .barWidth(this.barWidth)
      .width("100%")
      .height("100%")
    }
  }
}
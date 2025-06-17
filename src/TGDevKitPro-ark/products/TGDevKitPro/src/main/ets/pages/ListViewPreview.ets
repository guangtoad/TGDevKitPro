/**
 * @file ListView.ets
 * @name
 * @summary
 * @description
 * @author toad
 * @create 2025/02/24
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */
import { ELCDividerComponent } from "./ELCDividerComponent"

@Preview
@Component
export struct ListViewPreview {
  @State ts: string[][] = [["1", "2", "3"], ["1", "2", "3"]]
  @State dividerHeight: Length = "0.3vp"

  @Builder
  headerBuilder() {
    Column().width("100%").height("24vp")
  }

  build() {
    Column() {
      List() {
        ForEach(this.ts, (g: string[]) => {
          ListItemGroup({ header: this.headerBuilder() }) {
            ForEach(g, (item: string, index: number) => {
              if (0 == index) {
                ListItem() {
                  ELCDividerComponent({});
                }
                .id(`EAAAA_${index}`)
              }
              else if (index > 0) {
                ListItem() {
                  ELCDividerComponent({ lineLeft: 12, lineRight: 4 })
                    .width("100%")
                }
                .backgroundColor(Color.Transparent)
                .width("100%")

              }
              ListItem() {
                Text(item).width("100%")
              }
              .backgroundColor(Color.White)

              if (index == (g.length - 1)) {
                ListItem() {
                  ELCDividerComponent({});
                }
              }
            })
          }

          // .borderWidth("1vp")
        })
      }
      .backgroundColor(Color.Transparent)
    }
    // .backgroundColor(Color.Gray)
    .width("100%")
    .height("100%")
  }
}
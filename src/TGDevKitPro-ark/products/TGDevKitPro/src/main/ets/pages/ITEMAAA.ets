/**
 * @file ITEMAAA.ets
 * @name
 * @summary
 * @description
 * @author toad
 * @create 2025/02/12
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */
@Preview
@Component
export struct ITEMAAA {
  build() {
    Column() {
      Column() {
        Flex({
          justifyContent: FlexAlign.SpaceBetween,
          alignItems: ItemAlign.Center
        }) {
          Column({ space: "18vp" }) {
            Text("title")
              .textAlign(TextAlign.Start)
              .fontSize("21vp")
              .width("100")
            Column({ space: "8vp" }) {
              Text("有效期")
                .textAlign(TextAlign.Start)
                .fontSize("16vp")
                .width("100")
              Text("经销商")
                .textAlign(TextAlign.Start)
                .fontSize("16vp")
                .width("100")
              Text("车型 车牌")
                .textAlign(TextAlign.Start)
                .fontSize("16vp")
                .width("100")
            }
            .width("100")
          }
          Column() {
            Text("2")
              .textAlign(TextAlign.Center)
              .fontSize("36vp")
            Text("剩余次数")
              .textAlign(TextAlign.Center)
              .fontSize("16vp")
          }
        }
        .backgroundColor(Color.White)
        .width("100%")
        .borderRadius("3vp")
        .shadow({
          radius: 2,
          color: Color.Gray,
          offsetX: 0,
          offsetY: 1
        })
        .padding({
          left: "18vp",
          right: "18vp",
          top: "20vp",
          bottom: "20vp"
        })
      }
      .padding({
        left: "18vp",
        right: "18vp",
        top: "5vp",
        bottom: "5vp"
      })
    }
    .backgroundColor(Color.White)
    .width("100%")
    .height("100%")
  }
}
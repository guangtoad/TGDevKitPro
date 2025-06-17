/**
 * @file ServiceActivityItemComponent.ets
 * @name
 * @summary
 * @description
 * @author toad
 * @create 2025/02/11
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */

import { ServiceActivityItemData } from "./ServiceActivityData"

@Preview
@Component
export struct ServiceActivityItemComponent {
  @State data: ServiceActivityItemData = new ServiceActivityItemData()
    .setTitle("title titletitle titletitle titletitle titletitle titletitle titletitle titletitle titletitle title")
    .setCarName("car name")
    .setDate("20240501")
    .setDescription("Description Description Description Description Description Description Description Description");
  @State isShow: boolean = true;

  onDescriptionShow() {
    this.isShow = !this.isShow;
  }

  build() {
    Column() {
      Row() {
        Column() {
          Text("asd")
            .fontSize("16vp")
          Divider().width("100%")
            .height("1vp")
            .backgroundColor(Color.Black)

        }
        .width("25%")

        Column() {
          Text("asd")
        }
        .width("25%")

        Column() {
          Text("asd")
        }
        .width("25%")

        Column() {
          Text("asd")
        }
        .width("25%")
      }
      .width("100%")
      .height("46vp")

      Stack() {
        Column() {
          Row({ space: "8vp" }) {
            Image($r('app.media.service_activity_icon'))
              .margin({ top: "3vp" })
              .width("18vp")
              .height("18vp")
            Column() {
              Text(this.data.title)
                .fontSize("18vp")
                .textAlign(TextAlign.Start)
                .width("100%");
              Text(`有效期 ${this.data.date}`)
                .fontSize("12vp")
                .textAlign(TextAlign.Start)
                .fontColor("#707070")
                .margin({ top: "12vp" })
                .height("24vp")
                .width("100%");
              Flex({
                justifyContent: FlexAlign.SpaceBetween,
              }) {
                Text(`${this.data.carName} `)
                  .fontColor("#707070")
                  .fontSize("12vp")

                Row({ space: "4vp" }) {
                  Text("使用规则")
                    .fontColor("#707070")
                    .fontSize("12vp")
                  Image(this.isShow ? $r('app.media.service_activity_icon_down') :
                  $r('app.media.service_activity_icon_up'))
                    .width("16vp")
                    .height("16vp")
                }
                .onClick(() => {
                  this.onDescriptionShow();
                })
                .width("92vp")
              }
              .width("100%")
            }
          }
          .alignItems(VerticalAlign.Top)

          if (this.isShow) {
            Divider()
              .width("100%")
              .height("0.3vp")
              .backgroundColor("#707070")
              .margin({ top: "12vp" })

            Text(this.data.description)
              .fontSize("12vp")
              .fontColor("#707070")
              .margin({ top: "12vp" })
          }
        }
        .width("100%")
        .backgroundColor(Color.White)
        .padding({
          left: "18vp",
          right: "18vp",
          top: "17vp",
          bottom: "17vp"
        })
      }
      .padding({
        left: "18vp",
        right: "18vp",
        top: "5vp",
        bottom: "5vp"
      })

      Column()
        .width("100%")
        .height("20vp")
        .backgroundColor(Color.Green)
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#C5C5C5")
  }
}
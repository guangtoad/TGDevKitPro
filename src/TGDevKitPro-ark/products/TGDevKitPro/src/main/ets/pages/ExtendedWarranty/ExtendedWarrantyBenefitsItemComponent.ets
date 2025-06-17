/**
 * @file ExtendedWarrantyBenefitsItemComponent.ets
 * @name
 * @summary
 * @description
 * @author toad
 * @create 2025/02/12
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */


import { ExtendedWarrantyBenefitsItemData } from "./ExtendedWarrantyBenefitsItemData"

@Preview
@Component
export struct ExtendedWarrantyBenefitsItemComponent {
  @State itemData: ExtendedWarrantyBenefitsItemData = new ExtendedWarrantyBenefitsItemData().setEffectStatus("1")
    .setPackageName("asdasd");
  titleColor: ResourceColor = "#262626";

  getOpacity(): number | Resource {
    if ("0" == this.itemData.EffectStatus || "1" == this.itemData.EffectStatus) {
      return 1;
    }
    else {
      return 0.3;
    }
  }

  build() {
    Column() {
      Flex({
        justifyContent: FlexAlign.SpaceBetween,
        alignItems: ItemAlign.Center
      }) {
        Column({ space: "18vp" }) {
          Text(this.itemData.PackageName)
            .textAlign(TextAlign.Start)
            .fontSize("21vp")
            .fontColor("#262626")
            .width("100")
            .opacity(this.getOpacity())
          Column({ space: "8vp" }) {
            Text(`有效期 ${this.itemData.StartDate}-${this.itemData.ExpiringDate}`)
              .textAlign(TextAlign.Start)
              .fontSize("16vp")
              .fontColor("#707070")
              .width("100")
              .opacity(this.getOpacity())
            Text(`经销商 ${this.itemData.DealerName}`)
              .textAlign(TextAlign.Start)
              .fontSize("16vp")
              .fontColor("#707070")
              .width("100")
              .opacity(this.getOpacity())
            Text(`${this.itemData.CarName} ${this.itemData.CarRegno}`)
              .textAlign(TextAlign.Start)
              .fontSize("16vp")
              .fontColor("#707070")
              .width("100")
              .opacity(this.getOpacity())
          }
        }

        Column() {
          Text(`${this.itemData.RemainingTimes}`)
            .textAlign(TextAlign.Center)
            .fontSize("36vp")
            .opacity(this.getOpacity())
          Text("剩余次数")
            .textAlign(TextAlign.Center)
            .fontSize("16vp")
            .opacity(this.getOpacity())
        }
      }
      .backgroundColor(Color.White)
      .width("100%")
      .borderRadius("3vp")
      .padding({
        top: "20vp",
        left: "18vp",
        right: "18vp",
        bottom: "20vp"
      })
      .shadow({
        radius: 2,
        color: Color.Gray,
        offsetX: 0,
        offsetY: 1
      })
    }
    .padding({
      left: "18vp",
      right: "18vp",
      top: "5vp",
      bottom: "5vp"
    })
    .backgroundColor(Color.Transparent)
  }
}
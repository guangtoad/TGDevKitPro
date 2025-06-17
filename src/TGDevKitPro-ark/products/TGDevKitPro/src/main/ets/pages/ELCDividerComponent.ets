/**
 * @file ELCDividerComponent.ets
 * @name
 * @summary
 * @description
 * @author toad
 * @create 2025/02/24
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */


@Component
export struct ELCDividerComponent {
  @State lienHeight: number = px2vp(1);
  @State lineColor: ResourceColor = Color.Gray;
  @State lienWidth: number = 1;
  @State lineLeft: number = 0;
  @State lineRight: number = 0;
  @State endPointX: number = 0;

  build() {
    Column() {
      Line()
        .width("100%")
        .height(this.lienHeight)
        .strokeWidth(this.lienHeight)
        .startPoint([this.lineLeft, this.lienHeight > 0 ? (this.lienHeight / 2) : 0])
        .endPoint([this.endPointX, this.lienHeight > 0 ? (this.lienHeight / 2) : 0])
        .stroke(this.lineColor)

    }
    .backgroundColor(Color.Transparent)
    .height(this.lienHeight)
    .onAreaChange((_: Area, newValue: Area) => {
      this.endPointX = Number(newValue.width) - this.lineRight;
      // - this.lineLeft - this.lineRight;
    })
    .height(this.lienHeight)
  }
}
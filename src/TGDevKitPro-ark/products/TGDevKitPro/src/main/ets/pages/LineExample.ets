/**
 * @file LineExample.ets
 * @name
 * @summary
 * @description
 * @author toad
 * @create 2025/02/24
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */


@Component
struct ELCDivider {
  @State lienHeight: number = px2vp(1);
  @State lineColor: ResourceColor = Color.Red;
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
        .startPoint([this.lineRight, this.lienHeight > 0 ? (this.lienHeight / 2) : 0])
        .endPoint([this.endPointX, this.lienHeight > 0 ? (this.lienHeight / 2) : 0])
        .stroke(this.lineColor)
    }
    .onAreaChange((_: Area, newValue: Area) => {
      this.endPointX = Number(newValue.width) - this.lineLeft;


      // - this.linePaddingLeft - this.linePaddingRight
    })
  }
}

// xxx.ets
@Preview
@Component
struct LineExample {
  @State lienHeight: number = 0.3;
  @State color: ResourceColor = Color.Gray;

  build() {
    Column({ space: 10 }) {
      Column() {
        // ELCListDivider()
      }
      .height("24vp")

      Column(){
        Column() {
          ELCDivider({ lineLeft: 0 ,lineRight:24})
        }
        .height("24vp")
        .width("50%")
        .backgroundColor(Color.Green)
      }
      .width("100%")
      .height("42")

      // 线条绘制的起止点坐标均是相对于Line组件本身绘制区域的坐标
      Column() {
        Line()
          .width("100%")
          .height(this.lienHeight)
          .strokeWidth(this.lienHeight)
          .startPoint([24, this.lienHeight > 0 ? (this.lienHeight / 2) : 0])
          .endPoint([9999, this.lienHeight > 0 ? (this.lienHeight / 2) : 0])
          .stroke(this.color)
        // .backgroundColor('#F5F5F5')
      }
      .height(this.lienHeight)
      .width("100%")
      .backgroundColor(Color.Transparent)

    }
    .backgroundColor(Color.Gray)
    .width("100%")
    .height("100%")
  }
}

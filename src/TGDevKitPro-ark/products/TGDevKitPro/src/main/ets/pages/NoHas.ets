/**
 * @file NoHas.ets
 * @name
 * @summary
 * @description
 * @author toad
 * @create 2025/02/13
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */
@Preview
@Component
struct NoHas {
  build() {
    Stack() {
      Column(){
        Image($r("app.media.no_information"))
          .width("150vp")
          .height("150vp")
        Text("没有")
      }
    }
    .width("100%")
    .height("100%")

  }
}
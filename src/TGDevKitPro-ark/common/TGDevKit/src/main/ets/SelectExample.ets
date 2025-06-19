// xxx.ets


@Entry
@Component
struct SelectExample {
  @State text: string = "TTTTT"
  @State index: number = -1
  @State arrowPosition: ArrowPosition = ArrowPosition.END
  build() {
    Column() {
     Row(){
       Select([{ value: 'aaa', icon: $r("app.media.app_icon") },
         { value: 'bbb', icon: $r("app.media.app_icon") },
         { value: 'ccc', icon: $r("app.media.app_icon") },
         { value: 'ddd', icon: $r("app.media.app_icon") }])
         .selected(this.index)
         .value(this.text)
         .font({ size: 16, weight: 500 })
         .fontColor('#182431')
         // .selectedOptionFont({ size: 16, weight: 400 })
         // .optionFont({ size: 16, weight: 400 })
         // .arrowPosition(this.arrowPosition)
         // .menuAlign(MenuAlignType.START, {dx:0, dy:0})
         .optionWidth(200)
         .optionHeight(300)
         .divider( null )
         .onSelect((index:number, text?: string | undefined)=>{
           console.info('Select:' + index)
           this.index = index;
           // if(text){
           //   this.text = text;
           // }
         })
     }
     .width('100%')
    }.width('100%')
  }
}

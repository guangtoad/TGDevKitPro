/**
 * @file SelectTitleBarExample.ets
 * @name
 * @summary
 * @description
 * @author toad
 * @create 2025/01/15
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */



import { SelectTitleBar, promptAction, SelectTitleBarMenuItem } from '@kit.ArkUI'

@Preview
@Component
struct SelectTitleBarExample {
  // 定义右侧菜单项目列表
  private menuItems: Array<SelectTitleBarMenuItem> =
    [
      {
        // 菜单图片资源
        value: $r('sys.media.ohos_save_button_filled'),
        // 启用图片
        isEnabled: true,
        // 点击菜单时触发事件
        action: () => promptAction.showToast({ message: 'show toast index 1' }),
      },
      {
        value: $r('sys.media.ohos_ic_public_copy'),
        isEnabled: true,
        action: () => promptAction.showToast({ message: 'show toast index 2' }),
      },
      {
        value: $r('sys.media.ohos_ic_public_edit'),
        isEnabled: true,
        action: () => promptAction.showToast({ message: 'show toast index 3' }),
      },
      {
        value: $r('sys.media.ohos_ic_public_remove'),
        isEnabled: true,
        action: () => promptAction.showToast({ message: 'show toast index 4' }),
      },
    ]

  build() {
    Row() {
      Column() {
        Divider().height(2).color(0xCCCCCC)
        SelectTitleBar({
          // 定义下拉列表选项
          options: [
            { value: '所有照片' },
            { value: '本地（设备）' },
            { value: '本地本地本地本地本地（储存卡）' }
          ],
          // 初始选择第一个下拉选项
          selected: 0,
          // 选中时触发函数
          onSelected: (index) => promptAction.showToast({ message: 'page index ' + index }),
          // 隐藏左侧返回箭头
          hidesBackButton: true,
        })
        Divider().height(2).color(0xCCCCCC)
        SelectTitleBar({
          options: [
            { value: '所有照片' },
            { value: '本地（设备）' },
            { value: '本地本地本地本地本地（储存卡）' },
          ],
          selected: 0,
          onSelected: (index) => promptAction.showToast({ message: 'page index ' + index }),
          hidesBackButton: false,
        })
        Divider().height(2).color(0xCCCCCC)
        SelectTitleBar({
          options: [
            { value: '所有照片' },
            { value: '本地（设备）' },
            { value: '本地本地本地本地本地（储存卡）' },
          ],
          selected: 1,
          onSelected: (index) => promptAction.showToast({ message: 'page index ' + index }),
          subtitle: 'example@example.com',
        })
        Divider().height(2).color(0xCCCCCC)
        SelectTitleBar({
          options: [
            { value: '所有照片' },
            { value: '本地（设备）' },
            { value: '本地本地本地本地本地（储存卡）' },
          ],
          selected: 1,
          onSelected: (index) => promptAction.showToast({ message: 'page index ' + index }),
          subtitle: 'example@example.com',
          menuItems: [{ isEnabled: true, value: $r('sys.media.ohos_save_button_filled'),
            action: () => promptAction.showToast({ message: 'show toast index 1' }),
          }],
        })
        Divider().height(2).color(0xCCCCCC)
        SelectTitleBar({
          options: [
            { value: '所有照片' },
            { value: '本地（设备）' },
            { value: '本地本地本地本地本地（储存卡）' },
          ],
          selected: 0,
          onSelected: (index) => promptAction.showToast({ message: 'page index ' + index }),
          subtitle: 'example@example.com',
          menuItems: this.menuItems,
          badgeValue: 99,
          hidesBackButton: true,
        })
        Divider().height(2).color(0xCCCCCC)
      }.width('100%')
    }.height('100%')
  }
}

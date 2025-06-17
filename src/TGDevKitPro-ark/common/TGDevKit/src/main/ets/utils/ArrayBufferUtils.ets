/**
 * @file ArrayBufferUtils.ets
 * @name
 * @summary
 * @description
 * @author toad
 * @create 2025/01/14
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */
class ArrayBufferUtils {
  private buffer: ArrayBuffer;
  private dataView: DataView;

  constructor(capacity: number = 1024) {
    this.buffer = new ArrayBuffer(capacity);
    this.dataView = new DataView(this.buffer);
  }

  // 追加数据
  append(data: Uint8Array): void {
    const newBuffer = new ArrayBuffer(this.buffer.byteLength + data.byteLength);
    const newView = new Uint8Array(newBuffer);

    newView.set(new Uint8Array(this.buffer));
    newView.set(data, this.buffer.byteLength);

    this.buffer = newBuffer;
    this.dataView = new DataView(this.buffer);
  }

  // KMP算法实现查找
  containsArrayBuffer(targetBuffer: ArrayBuffer): boolean {
    const view = new Uint8Array(this.buffer);
    const targetView = new Uint8Array(targetBuffer);

    if (targetView.length === 0) {
      return true;
    }

    // 计算部分匹配表（前缀表）
    const lps = this.computeLPSArray(targetView);

    let i = 0; // 主数组索引
    let j = 0; // 目标数组索引

    while (i < view.length) {
      if (view[i] === targetView[j]) {
        i++;
        j++;
      }

      if (j === targetView.length) {
        return true; // 找到匹配
      } else if (i < view.length && view[i] !== targetView[j]) {
        if (j !== 0) {
          j = lps[j - 1];
        } else {
          i++;
        }
      }
    }
    return false;
  }

  // 计算部分匹配表（前缀表）
  private computeLPSArray(pattern: Uint8Array): number[] {
    const lps = new Array(pattern.length).fill(0);
    let length = 0;
    let i = 1;

    while (i < pattern.length) {
      if (pattern[i] === pattern[length]) {
        length++;
        lps[i] = length;
        i++;
      } else {
        if (length !== 0) {
          length = lps[length - 1];
        } else {
          lps[i] = 0;
          i++;
        }
      }
    }
    return lps;
  }

  // 移除指定范围的数据
  remove(start: number, length: number): void {
    if (start + length > this.buffer.byteLength) {
      throw new Error('Remove range exceeds buffer size');
    }

    const newSize = this.buffer.byteLength - length;
    const newBuffer = new ArrayBuffer(newSize);
    const newView = new Uint8Array(newBuffer);

    newView.set(new Uint8Array(this.buffer, 0, start));
    newView.set(new Uint8Array(this.buffer, start + length), start);

    this.buffer = newBuffer;
    this.dataView = new DataView(this.buffer);
  }

  // 获取当前缓冲区大小
  getSize(): number {
    return this.buffer.byteLength;
  }

  // 获取缓冲区数据
  getData(): Uint8Array {
    return new Uint8Array(this.buffer);
  }
}
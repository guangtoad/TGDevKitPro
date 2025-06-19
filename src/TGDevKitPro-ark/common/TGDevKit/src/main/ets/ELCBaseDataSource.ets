/**
 * @file ELCBaseDataSource.ets
 * @name
 * @summary elc base数据源
 * @description
 * @author toad
 * @create 2025/01/13
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */

/**
 * ELC Base数据源
 */
export class ELCBaseDataSource<T> implements IDataSource {
  /**
   * 数据监听者
   */
  private listeners: DataChangeListener[] = [];
  /**
   * 数据列表
   */
  public dataArray: T[] = [];

  /**
   * 添加数据
   * @param data
   */
  public pushData(data: T): void {
    this.dataArray.push(data);
    this.notifyDataAdd(this.dataArray.length - 1);
  }

  /**
   * 获取数据长度
   * @returns
   */
  public totalCount(): number {
    return this.dataArray.length;
  }

  /**
   * 获取数据
   * @param index
   * @returns
   */
  public getData(index: number): T {
    return this.dataArray[index];
  }

  /**
   * 该方法为框架侧调用，为LazyForEach组件向其数据源处添加listener监听
   * @param listener
   */
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      console.info('add listener');
      this.listeners.push(listener);
    }
  }

  /**
   * 该方法为框架侧调用，为对应的LazyForEach组件在数据源处去除listener监听
   * @param listener
   */
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      console.info('remove listener');
      this.listeners.splice(pos, 1);
    }
  }

  /**
   * 通知LazyForEach组件需要重载所有子组件
   */
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

  /**
   * 通知LazyForEach组件需要在index对应索引处添加子组件
   * @param index
   */
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
      // 写法2：listener.onDatasetChange([{type: DataOperationType.ADD, index: index}]);
    })
  }

  /**
   * 通知LazyForEach组件在index对应索引处数据有变化，需要重建该子组件
   * @param index
   */
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
      // 写法2：listener.onDatasetChange([{type: DataOperationType.CHANGE, index: index}]);
    })
  }

  /**
   * 通知LazyForEach组件需要在index对应索引处删除该子组件
   * @param index
   */
  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index);
      // 写法2：listener.onDatasetChange([{type: DataOperationType.DELETE, index: index}]);
    })
  }

  /**
   * 通知LazyForEach组件将from索引和to索引处的子组件进行交换
   * @param from
   * @param to
   */
  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to);
      // 写法2：listener.onDatasetChange(
      // [{type: DataOperationType.EXCHANGE, index: {start: from, end: to}}]);
    })
  }

  notifyDatasetChange(operations: DataOperation[]): void {
    this.listeners.forEach(listener => {
      listener.onDatasetChange(operations);
    })
  }
  dataDelete(index: number) {
    this.dataArray.splice(index, 1)
    this.listeners.forEach((listener => {
      listener.onDataDelete(index);
    }))
  }

  public clearData() {
    for (let index = this.dataArray.length; index > -1; index--) {
     this.dataDelete(index);
    }
  }
}

export class ELCBaseGroupDataSource<T> extends ELCBaseDataSource<ELCBaseDataSource<T>> {
  getDataWithIndexPath(section: number, row: number) {
    return this.getData(section)?.getData(row)
  }
}

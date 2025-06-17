/**
 * @file ServiceActivityData.ets
 * @name
 * @summary
 * @description
 * @author toad
 * @create 2025/02/11
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */


@Observed
export class ServiceActivityItemData {
  title: string = "";
  date: string = "";
  carName: string = "";
  carModel: string = "";
  description: string = "";

  setCarModel(carModel: string) {
    this.carModel = carModel;
    return this;
  }

  setTitle(title: string) {
    this.title = title;
    return this;
  }

  setDate(date: string) {
    this.date = date;
    return this;
  }

  setCarName(carName: string) {
    this.carName = carName;
    return this;
  }

  setDescription(description: string) {
    this.description = description;
    return this;
  }
}
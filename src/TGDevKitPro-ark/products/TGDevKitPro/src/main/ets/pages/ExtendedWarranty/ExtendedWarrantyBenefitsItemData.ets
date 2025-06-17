/**
 * @file ExtendedWarrantyBenefitsItemData.ets
 * @name
 * @summary
 * @description
 * @author toad
 * @create 2025/02/12
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */


@Observed
export class ExtendedWarrantyBenefitsItemData {
  Vin: string = "";
  CarName: string = "";
  CarRegno: string = "";
  /** DealerCode 属性 */
  DealerCode: string = "";
  /** DealerName 属性 */
  DealerName: string = "";
  /** EffectStatus 属性 */
  EffectStatus: string = "";
  /** StartDate 属性 */
  StartDate: string = "";
  /** ExpiringDate 属性 */
  ExpiringDate: string = "";
  /** RemainingTimes 属性 */
  RemainingTimes: string = "";
  /** PackageName 属性 */
  PackageName: string = "";

  setPackageName(PackageName: string) {
    this.PackageName = PackageName;
    return this;
  }

  setCarRegon(carRegon: string) {
    this.CarRegno = carRegon;
    return this;
  }

  setVin(vin: string) {
    this.Vin = vin;
    return this;
  }

  setDate(date: string) {
    this.StartDate = date;
    return this;
  }

  setCarName(carName: string) {
    this.CarName = carName;
    return this;
  }

  setEffectStatus(EffectStatus: string) {
    this.EffectStatus = EffectStatus;
    return this;
  }
}
/**
 * @file ELCRoute.ets
 * @name
 * @summary
 * @description
 * @author toad
 * @create 2024/10/22
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */

export declare function ELCRoute(param: ELCRouteParam): ObjectConstructor;

export interface ELCRouteParam {
  /**
   * 名称
   */
  name: string,
  pageName:string,
  description?: string,
  extra?: string,
  needLogin?: boolean,
  singleton?: boolean,
  animator?: string,
  interceptors?: string[],
  dialog?: boolean
}

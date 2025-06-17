/**
 * @file HTTPSSEClient.ets
 * @name
 * @summary
 * @description
 * @author toad
 * @create 2024/12/27
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */

// 引入包名
import http from '@ohos.net.http';
import { BusinessError } from '@ohos.base'

export class HTTPSSEClient {
  onOpen?: () => void;
  onEvent?: (idEvent: string, type: string, data: string) => void;
  onClosed?: () => void;
  onFailure?: () => void;
  // 每一个httpRequest对应一个HTTP请求任务，不可复用
  httpRequest = http.createHttp();

  public setOnOpen(onOpen: () => void) {
    this.onOpen = onOpen;
    return this;
  }

  public setOnEvent(onEvent: (idEvent: string, type: string, data: string) => void) {
    this.onEvent = onEvent;
    return this;
  }

  public setOnClosed(onClosed: () => void) {
    this.onClosed = onClosed;
    return this;
  }

  public setOnFailure(onFailure?: () => void) {
    this.onFailure = onFailure;
    return this;
  }

  requestOff() {
    // 取消订阅HTTP响应头事件
    this.httpRequest.off('headersReceive');
    // 取消订阅HTTP流式响应数据接收事件
    this.httpRequest.off('dataReceive');
    // 取消订阅HTTP流式响应数据接收进度事件
    this.httpRequest.off('dataReceiveProgress');
    // 取消订阅HTTP流式响应数据接收完毕事件
    this.httpRequest.off('dataEnd');
    // 当该请求使用完毕时，调用destroy方法主动销毁
    this.httpRequest.destroy();
  }

  public request() {
    // 用于订阅HTTP响应头事件
    this.httpRequest.on('headersReceive', (header: Object) => {
      console.info('header: ' + JSON.stringify(header));
    });
    let uint8Array: Uint8Array = new Uint8Array();

    // let byte = new ByteArray();
    // 用于订阅HTTP流式响应数据接收事件
    let res: Uint8Array = new Uint8Array();

    let offset = 0;
    // res.findIndex()
    this.httpRequest.on('dataReceive', (data: ArrayBuffer) => {
      let temp = new Uint8Array(data);
      res.set(temp, offset);
      offset = temp.length;
      // res。
      // res += data;
      console.info('res: ' + res);
    });
    // 用于订阅HTTP流式响应数据接收完毕事件
    this.httpRequest.on('dataEnd', () => {
      console.info('No more data in response, data receive end');
    });

    // 用于订阅HTTP流式响应数据接收进度事件
    class Data {
      receiveSize: number = 0;
      totalSize: number = 0;
    }

    this.httpRequest.on('dataReceiveProgress', (data: Data) => {
      console.log("dataReceiveProgress receiveSize:" + data.receiveSize + ", totalSize:" + data.totalSize);
    });

    let streamInfo: http.HttpRequestOptions = {
      method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
      // 开发者根据自身业务需要添加header字段
      header: {
        "X-Smartgbook":
        "ver=2.72;Device=OpenHarmony HUAWEI Mate 60;Serial=c689ee72-f6f8-107d-c4d7-0b82313e47d0;Tel=00000000000;sysver=OpenHarmony 5.0.1.115;lang=zh-Hans-CN;appver=3.75",
        "Authorization": "APPCODE xxxxxxxxxxxxxxxxxxxxxxx",
        "Content-Type": "application/json",
        "AccessToken": "2164eab59df8d6ee10baddb5bc813103642e4932ac8b33a6c688f368e0e922e0",
        "Accept": "text/event-stream"
      },
      // 当使用POST请求时此字段用于传递内容
      extraData: "Ed5OM13txsx4+V/lSCVVFbLqpKWznfimLG5iATx/WapSaU6DX1SuzICWRTTSUBlKv2WajFs7AwfsJYy6c8K/VajytQ7+7nnqpXYFP9zPOQu//BQwGpA6z/H24BPluqnXJgFwR+pA1cKS4DqNI7KFnH2mauzFztmxKVWMUD8ojocm63kXXqhp8Yq9CS+JBWf4",
      expectDataType: http.HttpDataType.ARRAY_BUFFER, // 可选，指定返回数据的类型
      usingCache: true, // 可选，默认为true
      priority: 1, // 可选，默认为1
      connectTimeout: 60000, // 可选，默认为60000ms
      readTimeout: 60000, // 可选，默认为60000ms。若传输的数据较大，需要较长的时间，建议增大该参数以保证数据传输正常终止
      usingProtocol: http.HttpProtocol.HTTP1_1 // 可选，协议类型默认值由系统自动指定
    }

    let uri = "http://192.168.1.130:8083/elcaip/aiTeacher/sendMsg";
    this.httpRequest.requestInStream(uri,
      streamInfo, (err: BusinessError, data: number) => {
        console.error('error:' + JSON.stringify(err));
        console.info('ResponseCode :' + JSON.stringify(data));
      }
    );
  }
}
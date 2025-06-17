/**
 * @file TestClient.ets
 * @name
 * @summary
 * @description
 * @author toad
 * @create 2025/01/14
 * @copyright 版权所有(c) 2011 NUL 保留所有权利。
 */
import promptAction from '@ohos.promptAction';
import EventSource from '@ohos/eventsource';

@Component
struct asdasd {
  @State es: null | EventSource = null;
  @State url: string = "http://localhost:8080/sse";

  eventListener = (e: Record<"data", string>) => {
    // this.simpleList.push(e.data);
  }

  asdasd() {

    // 创建连接
    this.es = new EventSource(this.url)

    // 开启监听
    this.es.addEventListener("server-time", this.eventListener);

    // 取消监听
    this.es.removeEventListener("server-time", this.eventListener);

    // 断开连接
    this.es.close();

    // 错误监听
    this.es.onFailure((e: Record<"message", string>) => {
      // 得到错误消息，对错误消息做处理
    })
  }

  build() {
    Column() {

    }
  }
}

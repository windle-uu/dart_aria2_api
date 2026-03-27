<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# flutter_aria2_api

---

参考[Aria2RPC](https://aria2.github.io/manual/en/html/aria2c.html#rpc-interface)，使用Dart实现的JSON-RPC接口api

## 用法

---

1. 创建客户端（http或websocket）

```dart
final client = Aria2HttpClient(
	host: host,
	port: port,
	path: path,
	secret: secret,
	func: Aria2HttpFunction.post,
);
```

2. 调用

```dart
final response = await client.addUri([downloadLink], option);
```

3. 获取返回值

```dart
final gid = response.getOrNull()?.result.getOrNull()?.value;
```

更多用法请参考test中的代码

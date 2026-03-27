import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aria2_api/src/enum.dart';
import 'package:aria2_api/src/response.dart';
import 'package:aria2_api/src/result.dart';
import 'package:aria2_api/src/struct.dart';
import 'package:http/http.dart' as http;
import 'package:result_dart/result_dart.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

const _uuid = Uuid();

typedef AsyncIntegerResult = AsyncResult<Aria2Response<Aria2IntegerResult>>;
typedef AsyncListResult<T extends Aria2Result> =
    AsyncResult<Aria2ListResponse<T>>;
typedef AsyncObjectResult<T extends Aria2ObjectResult> =
    AsyncResult<Aria2Response<T>>;
typedef AsyncStringResult = AsyncResult<Aria2Response<Aria2StringResult>>;

sealed class Aria2Client {
  /// {@macro aria2_api.add_metalink}
  AsyncListResult<Aria2StringResult> addMetalink(
    String metalink, [
    Aria2InputFileOption? option,
    int? position,
  ]) async {
    assert(() {
      if (position != null) return position >= 0;
      return true;
    }());
    final content = base64.encode(utf8.encode(metalink));
    final method = Aria2Method(
      Aria2MethodName.addMetalink,
      Aria2ParameterBuilder.normal([
        content,
        ?(option?.parametrized),
        ?position,
      ]),
    );
    return (await call(
      method,
    )).map((json) => Aria2ListResponse.fromJson(method, json));
  }

  /// {@macro aria2_api.add_torrent}
  AsyncStringResult addTorrent(
    String torrent, [
    List<String>? uris,
    Aria2InputFileOption? option,
    int? position,
  ]) async {
    assert(() {
      if (position != null) return position >= 0;
      return true;
    }());
    final content = base64.encode(utf8.encode(torrent));
    final method = Aria2Method(
      Aria2MethodName.addTorrent,
      Aria2ParameterBuilder.normal([
        content,
        ?uris,
        ?(option?.parametrized),
        ?position,
      ]),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.add_uri}
  AsyncStringResult addUri(
    List<String> uris, [
    Aria2InputFileOption? option,
    int? position,
  ]) async {
    assert(() {
      if (position != null) return position >= 0;
      return true;
    }());
    final method = Aria2Method(
      Aria2MethodName.addUri,
      Aria2ParameterBuilder.normal([uris, ?(option?.parametrized), ?position]),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  AsyncResult<Aria2BatchCallResponse> batchCall(List<Aria2Method> methods);

  AsyncResult<Map<String, dynamic>> call(Aria2Method method);

  /// {@macro aria2_api.change_global_option}
  AsyncStringResult changeGlobalOption(Aria2OptionObject option) async {
    final method = Aria2Method(
      Aria2MethodName.changeGlobalOption,
      Aria2ParameterBuilder.normal([option.parametrized]),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.change_option}
  AsyncStringResult changeOption(String gid, Aria2OptionObject option) async {
    final method = Aria2Method(
      Aria2MethodName.changeOption,
      Aria2ParameterBuilder.normal([gid, option.parametrized]),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.change_position}
  AsyncIntegerResult changePosition(
    String gid,
    int pos,
    Aria2PositionSymbol how,
  ) async {
    final method = Aria2Method(
      Aria2MethodName.changePosition,
      Aria2ParameterBuilder.normal([gid, pos, how.alias]),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.change_uri}
  AsyncListResult<Aria2IntegerResult> changeUri(
    String gid,
    int fileIndex,
    List<String> delUris,
    List<String> addUris, [
    int? position,
  ]) async {
    final method = Aria2Method(
      Aria2MethodName.changeUri,
      Aria2ParameterBuilder.normal([
        gid,
        fileIndex,
        delUris,
        addUris,
        ?position,
      ]),
    );
    return (await call(
      method,
    )).map((json) => Aria2ListResponse.fromJson(method, json));
  }

  // It should only be overridden when a long-lived connection needs to be created.
  FutureOr<void> disconnect({int? code, String? reason}) {}

  /// {@macro aria2_api.force_pause}
  AsyncStringResult forcePause(String gid) async {
    final method = Aria2Method(
      Aria2MethodName.forcePause,
      Aria2ParameterBuilder.normal([gid]),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.force_pause_all}
  AsyncStringResult forcePauseAll() async {
    final method = Aria2Method(
      Aria2MethodName.forcePauseAll,
      Aria2ParameterBuilder.empty(),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.force_remove}
  AsyncStringResult forceRemove(String gid) async {
    final method = Aria2Method(
      Aria2MethodName.forceRemove,
      Aria2ParameterBuilder.normal([gid]),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.force_shutdown}
  AsyncStringResult forceShutdown() async {
    final method = Aria2Method(
      Aria2MethodName.forceShutdown,
      Aria2ParameterBuilder.empty(),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.get_files}
  AsyncListResult<Aria2DownloadingFileObject> getFiles(String gid) async {
    final method = Aria2Method(
      Aria2MethodName.getFiles,
      Aria2ParameterBuilder.normal([gid]),
    );
    return (await call(
      method,
    )).map((json) => Aria2ListResponse.fromJson(method, json));
  }

  /// {@macro aria2_api.get_global_option}
  AsyncObjectResult<Aria2OptionObject> getGlobalOption() async {
    final method = Aria2Method(
      Aria2MethodName.getGlobalOption,
      Aria2ParameterBuilder.empty(),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.get_global_stat}
  AsyncObjectResult<Aria2GlobalStatObject> getGlobalStat() async {
    final method = Aria2Method(
      Aria2MethodName.getGlobalStat,
      Aria2ParameterBuilder.empty(),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.get_option}
  AsyncObjectResult<Aria2OptionObject> getOption(String gid) async {
    final method = Aria2Method(
      Aria2MethodName.getOption,
      Aria2ParameterBuilder.normal([gid]),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.get_peers}
  AsyncListResult<Aria2DownloadingPeerObject> getPeers(String gid) async {
    final method = Aria2Method(
      Aria2MethodName.getPeers,
      Aria2ParameterBuilder.normal([gid]),
    );
    return (await call(
      method,
    )).map((json) => Aria2ListResponse.fromJson(method, json));
  }

  /// {@macro aria2_api.get_servers}
  AsyncListResult<Aria2LinkedServerObject> getServers(String gid) async {
    final method = Aria2Method(
      Aria2MethodName.getServers,
      Aria2ParameterBuilder.normal([gid]),
    );
    return (await call(
      method,
    )).map((json) => Aria2ListResponse.fromJson(method, json));
  }

  /// {@macro aria2_api.get_session_info}
  AsyncObjectResult<Aria2SessionInfoObject> getSessionInfo() async {
    final method = Aria2Method(
      Aria2MethodName.getSessionInfo,
      Aria2ParameterBuilder.empty(),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.get_uris}
  AsyncListResult<Aria2DownloadingUriObject> getUris(String gid) async {
    final method = Aria2Method(
      Aria2MethodName.getUris,
      Aria2ParameterBuilder.normal([gid]),
    );
    return (await call(
      method,
    )).map((json) => Aria2ListResponse.fromJson(method, json));
  }

  /// {@macro aria2_api.get_version}
  AsyncObjectResult<Aria2VersionObject> getVersion() async {
    final method = Aria2Method(
      Aria2MethodName.getVersion,
      Aria2ParameterBuilder.empty(),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.list_methods}
  AsyncListResult<Aria2StringResult> listMethods() async {
    final method = Aria2Method(
      Aria2MethodName.listMethods,
      Aria2ParameterBuilder.empty(),
    );
    return (await call(
      method,
    )).map((json) => Aria2ListResponse.fromJson(method, json));
  }

  /// {@macro aria2_api.list_notifications}
  AsyncListResult<Aria2StringResult> listNotifications() async {
    final method = Aria2Method(
      Aria2MethodName.listNotifications,
      Aria2ParameterBuilder.empty(),
    );
    return (await call(
      method,
    )).map((json) => Aria2ListResponse.fromJson(method, json));
  }

  /// {@macro aria2_api.multicall}
  AsyncResult<Aria2MultiCallResponse> multicall(List<Aria2Method> methods);

  /// {@macro aria2_api.pause}
  AsyncStringResult pause(String gid) async {
    final method = Aria2Method(
      Aria2MethodName.pause,
      Aria2ParameterBuilder.normal([gid]),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.pause_all}
  AsyncStringResult pauseAll() async {
    final method = Aria2Method(
      Aria2MethodName.pauseAll,
      Aria2ParameterBuilder.empty(),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.purge_download_result}
  AsyncStringResult purgeDownloadResult() async {
    final method = Aria2Method(
      Aria2MethodName.purgeDownloadResult,
      Aria2ParameterBuilder.empty(),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.remove}
  AsyncStringResult remove(String gid) async {
    final method = Aria2Method(
      Aria2MethodName.remove,
      Aria2ParameterBuilder.normal([gid]),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.remove_download_result}
  AsyncStringResult removeDownloadResult(String gid) async {
    final method = Aria2Method(
      Aria2MethodName.removeDownloadResult,
      Aria2ParameterBuilder.normal([gid]),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.save_session}
  AsyncStringResult saveSession() async {
    final method = Aria2Method(
      Aria2MethodName.saveSession,
      Aria2ParameterBuilder.empty(),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.shutdown}
  AsyncStringResult shutdown() async {
    final method = Aria2Method(
      Aria2MethodName.shutdown,
      Aria2ParameterBuilder.empty(),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.tell_active}
  AsyncListResult<Aria2DownloadingStatusObject> tellActive([
    List<String>? keys,
  ]) async {
    final method = Aria2Method(
      Aria2MethodName.tellActive,
      Aria2ParameterBuilder.normal([?keys]),
    );
    return (await call(
      method,
    )).map((json) => Aria2ListResponse.fromJson(method, json));
  }

  /// {@macro aria2_api.tell_status}
  AsyncObjectResult<Aria2DownloadingStatusObject> tellStatus(
    String gid, [
    List<String>? keys,
  ]) async {
    final method = Aria2Method(
      Aria2MethodName.tellStatus,
      Aria2ParameterBuilder.normal([gid, ?keys]),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.tell_stopped}
  AsyncListResult<Aria2DownloadingStatusObject> tellStopped(
    int offset,
    int number, [
    List<String>? keys,
  ]) async {
    final method = Aria2Method(
      Aria2MethodName.tellStopped,
      Aria2ParameterBuilder.normal([offset, number, ?keys]),
    );
    return (await call(
      method,
    )).map((json) => Aria2ListResponse.fromJson(method, json));
  }

  /// {@macro aria2_api.tell_waiting}
  AsyncListResult<Aria2DownloadingStatusObject> tellWaiting(
    int offset,
    int number, [
    List<String>? keys,
  ]) async {
    final method = Aria2Method(
      Aria2MethodName.tellWaiting,
      Aria2ParameterBuilder.normal([offset, number, ?keys]),
    );
    return (await call(
      method,
    )).map((json) => Aria2ListResponse.fromJson(method, json));
  }

  /// {@macro aria2_api.unpause}
  AsyncStringResult unpause(String gid) async {
    final method = Aria2Method(
      Aria2MethodName.unpause,
      Aria2ParameterBuilder.normal([gid]),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }

  /// {@macro aria2_api.unpause_all}
  AsyncStringResult unpauseAll() async {
    final method = Aria2Method(
      Aria2MethodName.unpauseAll,
      Aria2ParameterBuilder.empty(),
    );
    return (await call(
      method,
    )).map((json) => Aria2Response.fromJson(method, json));
  }
}

class Aria2HttpClient extends Aria2Client {
  final Uri _uri;
  final _client = http.Client();
  final Aria2HttpFunction func;
  final String? secret;

  Aria2HttpClient({
    required String host,
    int? port,
    String? path,
    bool ssl = false,
    required this.func,
    this.secret,
  }) : _uri = Uri(
         scheme: ssl ? 'https' : 'http',
         host: host,
         port: port,
         path: path,
       );

  @override
  AsyncResult<Aria2BatchCallResponse> batchCall(
    List<Aria2Method> methods,
  ) async {
    final pending = <String, Aria2Method>{};
    final requests = <Map<String, dynamic>>[];
    for (final method in methods) {
      final id = _uuid.v4();
      pending[id] = method;
      requests.add(_buildRequest(id, method));
    }

    try {
      final http.Response httpResponse;
      switch (func) {
        case Aria2HttpFunction.get:
          httpResponse = await _client.get(
            _uri.replace(query: jsonEncode(requests)),
          );
          break;
        case Aria2HttpFunction.post:
          httpResponse = await _client.post(_uri, body: jsonEncode(requests));
          break;
      }
      final json = jsonDecode(httpResponse.body);
      final methodMap = <Aria2Method, Map<String, dynamic>>{};
      for (final i in json) {
        final id = i['id'];
        final method = pending.remove(id);
        if (method != null) methodMap[method] = i;
      }
      return Aria2BatchCallResponse.fromMethodMap(methodMap).toSuccess();
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<Map<String, dynamic>> call(Aria2Method method) async {
    final id = _uuid.v4();
    final request = _buildRequest(id, method);

    try {
      final http.Response httpResponse;
      switch (func) {
        case Aria2HttpFunction.get:
          httpResponse = await _client.get(
            _uri.replace(queryParameters: request),
          );
          break;
        case Aria2HttpFunction.post:
          httpResponse = await _client.post(_uri, body: jsonEncode(request));
          break;
      }
      final json = jsonDecode(httpResponse.body);
      return Success(json);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<Aria2MultiCallResponse> multicall(
    List<Aria2Method> methods,
  ) async {
    final id = _uuid.v4();
    final method = Aria2Method(
      Aria2MethodName.multicall,
      Aria2ParameterBuilder.multicall(methods),
    );
    final request = _buildRequest(id, method);

    try {
      final http.Response httpResponse;
      switch (func) {
        case Aria2HttpFunction.get:
          httpResponse = await _client.get(
            _uri.replace(queryParameters: request),
          );
          break;
        case Aria2HttpFunction.post:
          httpResponse = await _client.post(_uri, body: jsonEncode(request));
          break;
      }
      final json = jsonDecode(httpResponse.body);
      final response = Aria2MultiCallResponse.fromJson(method, json);
      return response.toSuccess();
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Map<String, dynamic> _buildRequest(String id, Aria2Method method) {
    final params = method.methodName.noRequireSecret
        ? method.params.buildParamList()
        : method.params.buildParamList(secret);
    switch (func) {
      case Aria2HttpFunction.get:
        return {
          'id': id,
          'method': method.methodName.alias,
          'params': base64Encode(utf8.encode(jsonEncode(params))),
        };
      case Aria2HttpFunction.post:
        return {
          'jsonrpc': '2.0',
          'id': id,
          'method': method.methodName.alias,
          'params': params,
        };
    }
  }
}

class Aria2WebSocketClient extends Aria2Client {
  final Uri _uri;
  final StreamController<Aria2Notification> _notificationController;
  bool _isChannelInitialized = false;
  late final WebSocketChannel _channel;
  Exception? _lastException;
  final String? secret;
  final _pending = <String, _Aria2WebSocketPacket>{};

  Aria2WebSocketClient({
    required String host,
    int? port,
    String? path,
    bool ssl = false,
    this.secret,
    bool broadcastNotification = true,
  }) : _uri = Uri(
         scheme: ssl ? 'wss' : 'ws',
         host: host,
         port: port,
         path: path,
       ),
       _notificationController = broadcastNotification
           ? StreamController.broadcast()
           : StreamController();

  Stream<Aria2Notification> get notification => _notificationController.stream;

  @override
  AsyncResult<Aria2BatchCallResponse> batchCall(
    List<Aria2Method> methods,
  ) async {
    try {
      _buildChannel();
      await _channel.ready;
    } on Exception catch (e) {
      _updateLastException(e);
      return Failure(e);
    }
    if (_lastException != null) return Failure(_lastException!);

    final futures = <Future<Map<String, dynamic>>>[];
    final requests = <Map<String, dynamic>>[];

    for (final method in methods) {
      final id = _uuid.v4();
      final completer = Completer<Map<String, dynamic>>();
      _pending[id] = _Aria2WebSocketPacket(method, completer);
      futures.add(completer.future);
      requests.add(_buildRequest(id, method));
    }
    _channel.sink.add(jsonEncode(requests));
    try {
      final raw = await Future.wait(futures);
      return Aria2BatchCallResponse.fromMethodMap(
        Map.fromIterables(methods, raw),
      ).toSuccess();
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<Map<String, dynamic>> call(Aria2Method method) async {
    try {
      _buildChannel();
      await _channel.ready;
    } on Exception catch (e) {
      _updateLastException(e);
      return Failure(e);
    }
    if (_lastException != null) return Failure(_lastException!);

    final id = _uuid.v4();
    final completer = Completer<Map<String, dynamic>>();
    _pending[id] = _Aria2WebSocketPacket(method, completer);
    final request = _buildRequest(id, method);
    _channel.sink.add(jsonEncode(request));
    try {
      final json = await completer.future;
      return Success(json);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  FutureOr<void> disconnect({int? code, String? reason}) async {
    if (_isChannelInitialized) {
      await _channel.sink.close(code, reason);
    }
    if (!_notificationController.isClosed) {
      await _notificationController.close();
    }
    _cleanUpPending(
      WebSocketChannelException.from(const SocketException.closed()),
    );
  }

  @override
  AsyncResult<Aria2MultiCallResponse> multicall(
    List<Aria2Method> methods,
  ) async {
    try {
      _buildChannel();
      await _channel.ready;
    } on Exception catch (e) {
      _updateLastException(e);
      return Failure(e);
    }
    if (_lastException != null) return Failure(_lastException!);

    final id = _uuid.v4();
    final completer = Completer<Map<String, dynamic>>();
    final method = Aria2Method(
      Aria2MethodName.multicall,
      Aria2ParameterBuilder.multicall(methods),
    );
    _pending[id] = _Aria2WebSocketPacket(method, completer);
    final request = _buildRequest(id, method);
    _channel.sink.add(jsonEncode(request));
    try {
      return Aria2MultiCallResponse.fromJson(
        method,
        (await completer.future),
      ).toSuccess();
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  void _buildChannel() {
    if (!_isChannelInitialized) {
      _channel = WebSocketChannel.connect(_uri);
      _isChannelInitialized = true;
      _channel.stream.listen(
        (rawJson) {
          final json = jsonDecode(rawJson);
          if (json is List) {
            // batch call
            for (final i in json) {
              if (i is Map<String, dynamic>) {
                _handleCall(i);
              }
            }
          } else if (json is Map<String, dynamic>) {
            _handleCall(json);
          }
        },
        onError: (o) {
          _updateLastException(o);
          _cleanUpPending(o);
        },
        onDone: () => _cleanUpPending(
          WebSocketChannelException.from(const SocketException.closed()),
        ),
      );
    }
  }

  Map<String, dynamic> _buildRequest(String id, Aria2Method method) {
    final params = method.methodName.noRequireSecret
        ? method.params.buildParamList()
        : method.params.buildParamList(secret);
    return {
      'jsonrpc': '2.0',
      'id': id,
      'method': method.methodName.alias,
      'params': params,
    };
  }

  void _cleanUpPending(Exception e) {
    for (final packet in _pending.values) {
      if (!packet.isCompleted) packet.completeError(e);
    }
    _pending.clear();
  }

  void _handleCall(Map<String, dynamic> json) {
    if (json.containsKey('id')) {
      final packet = _pending.remove(json['id']);
      if (packet != null) packet.complete(json);
    } else if (json.containsKey('method')) {
      _notificationController.add(Aria2Notification.fromJson(json));
    }
  }

  void _updateLastException(Exception e) {
    if (_lastException != e) _lastException = e;
  }
}

class _Aria2WebSocketPacket<T> {
  final Aria2Method method;
  final Completer<T> _completer;

  const _Aria2WebSocketPacket(this.method, this._completer);

  Future<T> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;

  void complete([FutureOr<T>? value]) => _completer.complete(value);

  void completeError(Object error, [StackTrace? stackTrace]) =>
      _completer.completeError(error, stackTrace);
}

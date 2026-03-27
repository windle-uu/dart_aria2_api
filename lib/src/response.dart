import 'package:aria2_api/src/enum.dart';
import 'package:aria2_api/src/error.dart';
import 'package:aria2_api/src/helper.dart';
import 'package:aria2_api/src/result.dart';
import 'package:aria2_api/src/struct.dart';
import 'package:result_dart/result_dart.dart';

class Aria2BatchCallResponse {
  final List<Aria2ResponseBase> responses;

  const Aria2BatchCallResponse(this.responses);

  factory Aria2BatchCallResponse.fromMethodMap(
    Map<Aria2Method, Map<String, dynamic>> map,
  ) {
    final responses = <Aria2ResponseBase>[];
    for (final i in map.entries) {
      if (i.value['result'] is List) {
        responses.add(Aria2ListResponse.fromJson(i.key, i.value));
      } else {
        responses.add(Aria2Response.fromJson(i.key, i.value));
      }
    }
    return Aria2BatchCallResponse(responses);
  }
}

class Aria2MultiCallResponse {
  final String id;
  final ResultDart<List<ResultDart<List, Aria2Error>>, Aria2Error> result;

  List<ResultDart<List, Aria2Error>>? get responses => result.getOrNull();

  const Aria2MultiCallResponse({required this.id, required this.result});

  factory Aria2MultiCallResponse.fromJson(
    Aria2Method method,
    Map<String, dynamic> json,
  ) {
    final id = json['id']?.toString();
    if (id == null) {
      throw const FormatException('Missing "id" field in JSON');
    }

    return switch (json) {
      {'result': final resultData} => _buildResponse(method, id, resultData),
      {'error': final errorData} => Aria2MultiCallResponse(
        id: id,
        result: Aria2Error.fromJson(errorData).toFailure(),
      ),
      _ => throw FormatException('Invalid Aria2 response structure', json),
    };
  }

  static Aria2MultiCallResponse _buildResponse(
    Aria2Method method,
    String id,
    List data,
  ) {
    dynamic buildInner(Aria2Method method, dynamic inner) {
      switch (inner) {
        case List i:
          final result = <Aria2Result>[];
          for (final e in i) {
            final handle = Aria2Result.build(method, e);
            result.add(handle);
          }
          return result;
        case _:
          final handle = Aria2Result.build(method, inner);
          return handle;
      }
    }

    final params = method.params.value as List<Aria2Method>;
    final map = Map.fromIterables(params, data);
    final result = <ResultDart<List, Aria2Error>>[];
    for (final i in map.entries) {
      final key = i.key;
      final value = i.value;
      if (value is Map<String, dynamic>) {
        result.add(Aria2Error.fromJson(value).toFailure());
      } else if (value is List) {
        result.add(
          value.map((inner) => buildInner(key, inner)).toList().toSuccess(),
        );
      } else {
        throw FormatException('Invalid Aria2 response structure', value);
      }
    }

    return Aria2MultiCallResponse(id: id, result: result.toSuccess());
  }
}

sealed class Aria2ResponseBase<T extends Object> {
  const Aria2ResponseBase();

  ResultDart<T, Aria2Error> get result;
}

class Aria2Response<T extends Aria2Result> extends Aria2ResponseBase<T> {
  final String id;
  @override
  final ResultDart<T, Aria2Error> result;

  const Aria2Response({required this.id, required this.result});

  factory Aria2Response.fromJson(
    Aria2Method method,
    Map<String, dynamic> json,
  ) {
    final id = json['id']?.toString();
    if (id == null) {
      throw const FormatException('Missing "id" field in JSON');
    }

    return switch (json) {
      {'result': final resultData} => _buildResponse<T>(method, id, resultData),
      {'error': final errorData} => Aria2Response(
        id: id,
        result: Aria2Error.fromJson(errorData).toFailure(),
      ),
      _ => throw FormatException('Invalid Aria2 response structure', json),
    };
  }

  static Aria2Response<T> _buildResponse<T extends Aria2Result>(
    Aria2Method method,
    String id,
    dynamic data,
  ) {
    final builtData = Aria2Result.build(method, data);

    if (builtData is T) {
      return Aria2Response(id: id, result: builtData.toSuccess());
    }

    throw Exception(
      'Type mismatch: Expected $T, but got ${builtData.runtimeType}.',
    );
  }
}

class Aria2ListResponse<T extends Aria2Result>
    extends Aria2ResponseBase<List<T>> {
  final String id;
  @override
  final ResultDart<List<T>, Aria2Error> result;

  const Aria2ListResponse({required this.id, required this.result});

  factory Aria2ListResponse.fromJson(
    Aria2Method method,
    Map<String, dynamic> json,
  ) {
    final id = json['id']?.toString();
    if (id == null) {
      throw const FormatException('Missing "id" field in JSON');
    }

    return switch (json) {
      {'result': final resultData} => _buildResponse<T>(method, id, resultData),
      {'error': final errorData} => Aria2ListResponse(
        id: id,
        result: Aria2Error.fromJson(errorData).toFailure(),
      ),
      _ => throw FormatException('Invalid Aria2 response structure', json),
    };
  }

  static Aria2ListResponse<T> _buildResponse<T extends Aria2Result>(
    Aria2Method method,
    String id,
    List data,
  ) {
    final builtData = <T>[];
    for (final i in data) {
      final result = Aria2Result.build(method, i);
      assert(
        result is T,
        'Type mismatch: Expected $T, but got ${builtData.runtimeType}.',
      );
      builtData.add(result as T);
    }

    return Aria2ListResponse(id: id, result: builtData.cast<T>().toSuccess());
  }
}

class Aria2Notification {
  final String jsonrpc;
  final Aria2NotificationName method;
  final Aria2NotificationList data;

  const Aria2Notification({
    required this.jsonrpc,
    required this.method,
    required this.data,
  });

  factory Aria2Notification.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('method') && json.containsKey('params')) {
      return Aria2Notification(
        jsonrpc: json['jsonrpc'] ?? '2.0',
        method: Aria2NotificationName.values.byAlias(json['method']),
        data: Aria2NotificationList.build(json['params']),
      );
    }

    throw FormatException('Wrong json data.', json);
  }

  @override
  String toString() {
    return (StringBuffer('$runtimeType(')
          ..writeAll([
            'jsonrpc: $jsonrpc',
            'method: $method',
            'data: $data',
          ], ', ')
          ..write(')'))
        .toString();
  }
}

class Aria2NotificationList {
  final List<Aria2NotificationObject> value;

  const Aria2NotificationList(this.value);

  factory Aria2NotificationList.build(List json) {
    return Aria2NotificationList(
      json.map((e) => Aria2NotificationObject.fromJson(e)).toList(),
    );
  }

  @override
  String toString() {
    return value.toString();
  }
}

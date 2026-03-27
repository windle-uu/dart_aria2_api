import 'package:aria2_api/src/_internal.dart';
import 'package:aria2_api/src/error.dart';
import 'package:aria2_api/src/result.dart';
import 'package:result_dart/result_dart.dart';

extension Aria2BatchCallHelper on ResultDart<Object, Aria2Error> {
  List<T>? castListOrNull<T extends Aria2Result>() {
    final result = getOrNull();
    if (result != null && result is List) {
      return result.cast<T>();
    }
    return null;
  }

  T? castOrNull<T extends Aria2Result>() {
    final result = getOrNull();
    return switch (result) {
      T t => t,
      _ => null,
    };
  }
}

extension Aria2MultiCallHelper on ResultDart<List, Aria2Error> {
  List<T>? castListOrNull<T extends Object>() {
    final result = getOrNull()?.first;
    if (result != null && result is List) {
      return result.cast<T>();
    }
    return null;
  }

  T? castOrNull<T extends Object>() {
    final result = getOrNull()?.first;
    return switch (result) {
      T t => t,
      _ => null,
    };
  }
}

extension EnumByAlias<T extends AliasEnumMixin> on Iterable<T> {
  T byAlias(String alias) {
    for (final value in this) {
      if (value.alias == alias) return value;
    }
    throw ArgumentError.value(alias, "alias", "No enum value with that alias.");
  }
}

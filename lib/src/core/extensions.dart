import 'dart:async';
import 'dart:developer';

import 'types.dart';

Func<T, T> logData<T>(String tag) => (t) {
      log('[logData] $tag: $t');
      return t;
    };

extension ListExt<T> on List<T> {
  List<U> mapList<U>(Func<T, U> apply) => //
      this.map(apply).toList();
}

extension IterableExt<T> on Iterable<T> {
  List<U> mapList<U>(Func<T, U> apply) => //
      this.map(apply).toList();
}

extension MapExt<T> on Map<String, T> {
  Map<String, T> copyWith(String key, T data) => //
      {...this, key: data};
}

extension FutureExt<T> on Future<T> {
  Future<U> thenDo<U>(Supplier<FutureOr<U>> doNext) => //
      this.then((_) => doNext());
}

extension FutureNullableExt<T> on Future<T?> {
  Future<T> thenUnwrap(Supplier<T> def) => //
      this.then((_) => _ ?? def());
}

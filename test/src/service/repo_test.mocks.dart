// Mocks generated by Mockito 5.1.0 from annotations
// in mydex/test/src/service/repo_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i11;

import 'package:dio/dio.dart' as _i8;
import 'package:dio/src/adapter.dart' as _i3;
import 'package:dio/src/cancel_token.dart' as _i12;
import 'package:dio/src/dio_mixin.dart' as _i5;
import 'package:dio/src/options.dart' as _i2;
import 'package:dio/src/response.dart' as _i6;
import 'package:dio/src/transformer.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mydex/src/model/pokemon/pair.dart' as _i10;
import 'package:mydex/src/model/pokemon/pokemon.dart' as _i9;
import 'package:mydex/src/model/user.dart' as _i7;
import 'package:mydex/src/service/repo.dart' as _i13;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeBaseOptions_0 extends _i1.Fake implements _i2.BaseOptions {}

class _FakeHttpClientAdapter_1 extends _i1.Fake
    implements _i3.HttpClientAdapter {}

class _FakeTransformer_2 extends _i1.Fake implements _i4.Transformer {}

class _FakeInterceptors_3 extends _i1.Fake implements _i5.Interceptors {}

class _FakeResponse_4<T> extends _i1.Fake implements _i6.Response<T> {}

class _FakeUser_5 extends _i1.Fake implements _i7.User {}

class _FakeDio_6 extends _i1.Fake implements _i8.Dio {}

class _FakePokemonLocal_7 extends _i1.Fake implements _i9.PokemonLocal {}

class _FakePokemon_8 extends _i1.Fake implements _i9.Pokemon {}

class _FakePairLocal_9 extends _i1.Fake implements _i10.PairLocal {}

class _FakePair_10 extends _i1.Fake implements _i10.Pair {}

/// A class which mocks [Dio].
///
/// See the documentation for Mockito's code generation for more information.
class MockDio extends _i1.Mock implements _i8.Dio {
  MockDio() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.BaseOptions get options =>
      (super.noSuchMethod(Invocation.getter(#options),
          returnValue: _FakeBaseOptions_0()) as _i2.BaseOptions);
  @override
  set options(_i2.BaseOptions? _options) =>
      super.noSuchMethod(Invocation.setter(#options, _options),
          returnValueForMissingStub: null);
  @override
  _i3.HttpClientAdapter get httpClientAdapter =>
      (super.noSuchMethod(Invocation.getter(#httpClientAdapter),
          returnValue: _FakeHttpClientAdapter_1()) as _i3.HttpClientAdapter);
  @override
  set httpClientAdapter(_i3.HttpClientAdapter? _httpClientAdapter) => super
      .noSuchMethod(Invocation.setter(#httpClientAdapter, _httpClientAdapter),
          returnValueForMissingStub: null);
  @override
  _i4.Transformer get transformer =>
      (super.noSuchMethod(Invocation.getter(#transformer),
          returnValue: _FakeTransformer_2()) as _i4.Transformer);
  @override
  set transformer(_i4.Transformer? _transformer) =>
      super.noSuchMethod(Invocation.setter(#transformer, _transformer),
          returnValueForMissingStub: null);
  @override
  _i5.Interceptors get interceptors =>
      (super.noSuchMethod(Invocation.getter(#interceptors),
          returnValue: _FakeInterceptors_3()) as _i5.Interceptors);
  @override
  void close({bool? force = false}) =>
      super.noSuchMethod(Invocation.method(#close, [], {#force: force}),
          returnValueForMissingStub: null);
  @override
  _i11.Future<_i6.Response<T>> get<T>(String? path,
          {Map<String, dynamic>? queryParameters,
          _i2.Options? options,
          _i12.CancelToken? cancelToken,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#get, [
                path
              ], {
                #queryParameters: queryParameters,
                #options: options,
                #cancelToken: cancelToken,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i11.Future<_i6.Response<T>>);
  @override
  _i11.Future<_i6.Response<T>> getUri<T>(Uri? uri,
          {_i2.Options? options,
          _i12.CancelToken? cancelToken,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#getUri, [
                uri
              ], {
                #options: options,
                #cancelToken: cancelToken,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i11.Future<_i6.Response<T>>);
  @override
  _i11.Future<_i6.Response<T>> post<T>(String? path,
          {dynamic data,
          Map<String, dynamic>? queryParameters,
          _i2.Options? options,
          _i12.CancelToken? cancelToken,
          _i2.ProgressCallback? onSendProgress,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [
                path
              ], {
                #data: data,
                #queryParameters: queryParameters,
                #options: options,
                #cancelToken: cancelToken,
                #onSendProgress: onSendProgress,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i11.Future<_i6.Response<T>>);
  @override
  _i11.Future<_i6.Response<T>> postUri<T>(Uri? uri,
          {dynamic data,
          _i2.Options? options,
          _i12.CancelToken? cancelToken,
          _i2.ProgressCallback? onSendProgress,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#postUri, [
                uri
              ], {
                #data: data,
                #options: options,
                #cancelToken: cancelToken,
                #onSendProgress: onSendProgress,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i11.Future<_i6.Response<T>>);
  @override
  _i11.Future<_i6.Response<T>> put<T>(String? path,
          {dynamic data,
          Map<String, dynamic>? queryParameters,
          _i2.Options? options,
          _i12.CancelToken? cancelToken,
          _i2.ProgressCallback? onSendProgress,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [
                path
              ], {
                #data: data,
                #queryParameters: queryParameters,
                #options: options,
                #cancelToken: cancelToken,
                #onSendProgress: onSendProgress,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i11.Future<_i6.Response<T>>);
  @override
  _i11.Future<_i6.Response<T>> putUri<T>(Uri? uri,
          {dynamic data,
          _i2.Options? options,
          _i12.CancelToken? cancelToken,
          _i2.ProgressCallback? onSendProgress,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#putUri, [
                uri
              ], {
                #data: data,
                #options: options,
                #cancelToken: cancelToken,
                #onSendProgress: onSendProgress,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i11.Future<_i6.Response<T>>);
  @override
  _i11.Future<_i6.Response<T>> head<T>(String? path,
          {dynamic data,
          Map<String, dynamic>? queryParameters,
          _i2.Options? options,
          _i12.CancelToken? cancelToken}) =>
      (super.noSuchMethod(
              Invocation.method(#head, [
                path
              ], {
                #data: data,
                #queryParameters: queryParameters,
                #options: options,
                #cancelToken: cancelToken
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i11.Future<_i6.Response<T>>);
  @override
  _i11.Future<_i6.Response<T>> headUri<T>(Uri? uri,
          {dynamic data,
          _i2.Options? options,
          _i12.CancelToken? cancelToken}) =>
      (super.noSuchMethod(
              Invocation.method(#headUri, [uri],
                  {#data: data, #options: options, #cancelToken: cancelToken}),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i11.Future<_i6.Response<T>>);
  @override
  _i11.Future<_i6.Response<T>> delete<T>(String? path,
          {dynamic data,
          Map<String, dynamic>? queryParameters,
          _i2.Options? options,
          _i12.CancelToken? cancelToken}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [
                path
              ], {
                #data: data,
                #queryParameters: queryParameters,
                #options: options,
                #cancelToken: cancelToken
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i11.Future<_i6.Response<T>>);
  @override
  _i11.Future<_i6.Response<T>> deleteUri<T>(Uri? uri,
          {dynamic data,
          _i2.Options? options,
          _i12.CancelToken? cancelToken}) =>
      (super.noSuchMethod(
              Invocation.method(#deleteUri, [uri],
                  {#data: data, #options: options, #cancelToken: cancelToken}),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i11.Future<_i6.Response<T>>);
  @override
  _i11.Future<_i6.Response<T>> patch<T>(String? path,
          {dynamic data,
          Map<String, dynamic>? queryParameters,
          _i2.Options? options,
          _i12.CancelToken? cancelToken,
          _i2.ProgressCallback? onSendProgress,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [
                path
              ], {
                #data: data,
                #queryParameters: queryParameters,
                #options: options,
                #cancelToken: cancelToken,
                #onSendProgress: onSendProgress,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i11.Future<_i6.Response<T>>);
  @override
  _i11.Future<_i6.Response<T>> patchUri<T>(Uri? uri,
          {dynamic data,
          _i2.Options? options,
          _i12.CancelToken? cancelToken,
          _i2.ProgressCallback? onSendProgress,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#patchUri, [
                uri
              ], {
                #data: data,
                #options: options,
                #cancelToken: cancelToken,
                #onSendProgress: onSendProgress,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i11.Future<_i6.Response<T>>);
  @override
  void lock() => super.noSuchMethod(Invocation.method(#lock, []),
      returnValueForMissingStub: null);
  @override
  void unlock() => super.noSuchMethod(Invocation.method(#unlock, []),
      returnValueForMissingStub: null);
  @override
  void clear() => super.noSuchMethod(Invocation.method(#clear, []),
      returnValueForMissingStub: null);
  @override
  _i11.Future<_i6.Response<dynamic>> download(String? urlPath, dynamic savePath,
          {_i2.ProgressCallback? onReceiveProgress,
          Map<String, dynamic>? queryParameters,
          _i12.CancelToken? cancelToken,
          bool? deleteOnError = true,
          String? lengthHeader = r'content-length',
          dynamic data,
          _i2.Options? options}) =>
      (super.noSuchMethod(
              Invocation.method(#download, [
                urlPath,
                savePath
              ], {
                #onReceiveProgress: onReceiveProgress,
                #queryParameters: queryParameters,
                #cancelToken: cancelToken,
                #deleteOnError: deleteOnError,
                #lengthHeader: lengthHeader,
                #data: data,
                #options: options
              }),
              returnValue: Future<_i6.Response<dynamic>>.value(
                  _FakeResponse_4<dynamic>()))
          as _i11.Future<_i6.Response<dynamic>>);
  @override
  _i11.Future<_i6.Response<dynamic>> downloadUri(Uri? uri, dynamic savePath,
          {_i2.ProgressCallback? onReceiveProgress,
          _i12.CancelToken? cancelToken,
          bool? deleteOnError = true,
          String? lengthHeader = r'content-length',
          dynamic data,
          _i2.Options? options}) =>
      (super.noSuchMethod(
              Invocation.method(#downloadUri, [
                uri,
                savePath
              ], {
                #onReceiveProgress: onReceiveProgress,
                #cancelToken: cancelToken,
                #deleteOnError: deleteOnError,
                #lengthHeader: lengthHeader,
                #data: data,
                #options: options
              }),
              returnValue: Future<_i6.Response<dynamic>>.value(
                  _FakeResponse_4<dynamic>()))
          as _i11.Future<_i6.Response<dynamic>>);
  @override
  _i11.Future<_i6.Response<T>> request<T>(String? path,
          {dynamic data,
          Map<String, dynamic>? queryParameters,
          _i12.CancelToken? cancelToken,
          _i2.Options? options,
          _i2.ProgressCallback? onSendProgress,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#request, [
                path
              ], {
                #data: data,
                #queryParameters: queryParameters,
                #cancelToken: cancelToken,
                #options: options,
                #onSendProgress: onSendProgress,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i11.Future<_i6.Response<T>>);
  @override
  _i11.Future<_i6.Response<T>> requestUri<T>(Uri? uri,
          {dynamic data,
          _i12.CancelToken? cancelToken,
          _i2.Options? options,
          _i2.ProgressCallback? onSendProgress,
          _i2.ProgressCallback? onReceiveProgress}) =>
      (super.noSuchMethod(
              Invocation.method(#requestUri, [
                uri
              ], {
                #data: data,
                #cancelToken: cancelToken,
                #options: options,
                #onSendProgress: onSendProgress,
                #onReceiveProgress: onReceiveProgress
              }),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i11.Future<_i6.Response<T>>);
  @override
  _i11.Future<_i6.Response<T>> fetch<T>(_i2.RequestOptions? requestOptions) =>
      (super.noSuchMethod(Invocation.method(#fetch, [requestOptions]),
              returnValue: Future<_i6.Response<T>>.value(_FakeResponse_4<T>()))
          as _i11.Future<_i6.Response<T>>);
}

/// A class which mocks [BaseLocal].
///
/// See the documentation for Mockito's code generation for more information.
class MockBaseLocal<T> extends _i1.Mock implements _i13.BaseLocal<T> {
  MockBaseLocal() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i11.Future<void> onInsert(List<T>? items) => (super.noSuchMethod(
      Invocation.method(#onInsert, [items]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i11.Future<void>);
  @override
  _i11.Future<void> onUpdate(List<T>? items) => (super.noSuchMethod(
      Invocation.method(#onUpdate, [items]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i11.Future<void>);
  @override
  _i11.Future<void> onDelete(List<T>? items) => (super.noSuchMethod(
      Invocation.method(#onDelete, [items]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i11.Future<void>);
}

/// A class which mocks [IUserRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockIUserRepo extends _i1.Mock implements _i7.IUserRepo {
  MockIUserRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i11.Future<void> doInsert(String? name, String? email, String? password) =>
      (super.noSuchMethod(Invocation.method(#doInsert, [name, email, password]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i11.Future<void>);
  @override
  _i11.Future<List<_i7.User>> doGetAll() =>
      (super.noSuchMethod(Invocation.method(#doGetAll, []),
              returnValue: Future<List<_i7.User>>.value(<_i7.User>[]))
          as _i11.Future<List<_i7.User>>);
  @override
  _i11.Future<_i7.User> doGet(int? id) =>
      (super.noSuchMethod(Invocation.method(#doGet, [id]),
              returnValue: Future<_i7.User>.value(_FakeUser_5()))
          as _i11.Future<_i7.User>);
  @override
  _i11.Future<_i7.User> doGetByEmail(String? email) =>
      (super.noSuchMethod(Invocation.method(#doGetByEmail, [email]),
              returnValue: Future<_i7.User>.value(_FakeUser_5()))
          as _i11.Future<_i7.User>);
}

/// A class which mocks [PokemonRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockPokemonRepo extends _i1.Mock implements _i9.PokemonRepo {
  MockPokemonRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Dio get remote =>
      (super.noSuchMethod(Invocation.getter(#remote), returnValue: _FakeDio_6())
          as _i8.Dio);
  @override
  _i9.PokemonLocal get local => (super.noSuchMethod(Invocation.getter(#local),
      returnValue: _FakePokemonLocal_7()) as _i9.PokemonLocal);
  @override
  _i11.Future<_i9.Pokemon> doGet(String? query) =>
      (super.noSuchMethod(Invocation.method(#doGet, [query]),
              returnValue: Future<_i9.Pokemon>.value(_FakePokemon_8()))
          as _i11.Future<_i9.Pokemon>);
  @override
  _i11.Future<List<_i9.Pokemon>> doGetAll() =>
      (super.noSuchMethod(Invocation.method(#doGetAll, []),
              returnValue: Future<List<_i9.Pokemon>>.value(<_i9.Pokemon>[]))
          as _i11.Future<List<_i9.Pokemon>>);
  @override
  _i11.Future<dynamic> doInsert(List<_i9.Pokemon>? xs) =>
      (super.noSuchMethod(Invocation.method(#doInsert, [xs]),
          returnValue: Future<dynamic>.value()) as _i11.Future<dynamic>);
  @override
  _i11.Future<_i9.Pokemon> doCache(_i9.Pokemon? x) =>
      (super.noSuchMethod(Invocation.method(#doCache, [x]),
              returnValue: Future<_i9.Pokemon>.value(_FakePokemon_8()))
          as _i11.Future<_i9.Pokemon>);
  @override
  _i11.Future<List<_i9.Pokemon>> doCacheAll(List<_i9.Pokemon>? xs) =>
      (super.noSuchMethod(Invocation.method(#doCacheAll, [xs]),
              returnValue: Future<List<_i9.Pokemon>>.value(<_i9.Pokemon>[]))
          as _i11.Future<List<_i9.Pokemon>>);
}

/// A class which mocks [PairRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockPairRepo extends _i1.Mock implements _i10.PairRepo {
  MockPairRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Dio get remote =>
      (super.noSuchMethod(Invocation.getter(#remote), returnValue: _FakeDio_6())
          as _i8.Dio);
  @override
  _i10.PairLocal get local => (super.noSuchMethod(Invocation.getter(#local),
      returnValue: _FakePairLocal_9()) as _i10.PairLocal);
  @override
  _i11.Future<_i10.Pair> doGet(String? query) =>
      (super.noSuchMethod(Invocation.method(#doGet, [query]),
              returnValue: Future<_i10.Pair>.value(_FakePair_10()))
          as _i11.Future<_i10.Pair>);
  @override
  _i11.Future<List<_i10.Pair>> doGetAll() =>
      (super.noSuchMethod(Invocation.method(#doGetAll, []),
              returnValue: Future<List<_i10.Pair>>.value(<_i10.Pair>[]))
          as _i11.Future<List<_i10.Pair>>);
  @override
  _i11.Future<dynamic> doInsert(List<_i10.Pair>? xs) =>
      (super.noSuchMethod(Invocation.method(#doInsert, [xs]),
          returnValue: Future<dynamic>.value()) as _i11.Future<dynamic>);
  @override
  _i11.Future<_i10.Pair> doCache(_i10.Pair? x) =>
      (super.noSuchMethod(Invocation.method(#doCache, [x]),
              returnValue: Future<_i10.Pair>.value(_FakePair_10()))
          as _i11.Future<_i10.Pair>);
  @override
  _i11.Future<List<_i10.Pair>> doCacheAll(List<_i10.Pair>? xs) =>
      (super.noSuchMethod(Invocation.method(#doCacheAll, [xs]),
              returnValue: Future<List<_i10.Pair>>.value(<_i10.Pair>[]))
          as _i11.Future<List<_i10.Pair>>);
}

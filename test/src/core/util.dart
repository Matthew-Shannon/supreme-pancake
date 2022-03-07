import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydex/src/core/types.dart';
import 'package:mydex/src/core/view.dart';
import 'package:mydex/src/model/state.dart';
import 'package:mydex/src/service/repo.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging%202.dart';
import 'package:redux_thunk/redux_thunk.dart';

class FakeContext extends Fake implements BuildContext {}

void expectAllExist(List<String> xs) => xs.forEach((x) => expect(find.text(x), findsOneWidget));
void expectKeysNotExist(List<String> xs) => xs.forEach((x) => expect(find.byKey(Key(x)), findsNothing));
void expectKeysExist(List<String> xs) => xs.forEach((x) => expect(find.byKey(Key(x)), findsOneWidget));

extension WhenExpectationEx on When {
  void thenCall<T>() => thenAnswer((_) => Future.value());
  void thenReply<T>(T t) => thenAnswer((_) => Future.value(t));
}

Widget testApp(Supplier<Widget> onReady) => //
    ScreenUtilInit(builder: () => onReady().app());

MyDexStore setupStore(List<Reducer<MyDexState>> reducers) => //
    Store(combineReducers(reducers), initialState: const MyDexState(), middleware: [
      LoggingMiddleware.printer(),
      thunkMiddleware,
    ]);

Response<JSON> remoteResponse(JSON data) => Response(data: data, requestOptions: RequestOptions(path: ''));

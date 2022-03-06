import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydex/src/core/types.dart';
import 'package:mydex/src/core/view.dart';
import 'package:mydex/src/model/state.dart';
import 'package:redux/redux.dart';

class FakeContext extends Fake implements BuildContext {}

void expectAllExist(List<String> items) => //
    items.map(find.text).forEach((_) => expect(_, findsOneWidget));

extension WhenExpectationEx on When {
  void thenAnswerVoidFuture<T>() => thenAnswer((_) => Future.value());
  void thenAnswerFuture<T>(T t) => thenAnswer((_) => Future.value(t));
}

Widget testApp(Supplier<Widget> onReady) => //
    ScreenUtilInit(builder: () => onReady().app());

MyDexStore setupStore(BiFunc<MyDexState, dynamic, MyDexState> onApply) => //
    Store(onApply, initialState: const MyDexState());

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/core/di.dart';
import 'package:mydex/src/core/view.dart';
import 'package:mydex/src/model/state.dart';
import 'package:mydex/src/service/nav.dart';
import 'package:mydex/src/service/prefs.dart';
import 'package:mydex/src/view/auth/features/login.dart';

import '../../../core/mock.dart';
import '../../../core/util.dart';

void main() {
  group('login', () {
    late LoginMiddleware middleware;
    late MyDexStore store;
    late IPrefs prefs;
    late LoginVM vm;

    setUp(() {
      prefs = MockPrefs();
      when(() => prefs.setAuth(any())).thenCall();
      when(() => prefs.setId(any())).thenCall();

      var userRepo = MockUserRepo();
      when(() => userRepo.doGet(any())).thenReply(mockUser);

      middleware = LoginMiddleware(prefs, userRepo);
      store = setupStore([MyDexReducer.authSelector]);
      vm = LoginVM.fromStore(store, middleware);
    });

    group('middleware', () {
      test('validateEmail', () {
        expect(middleware.validateEmail('', ''), Const.emailBlankTxt);
        expect(middleware.validateEmail('a', ''), Const.emailInvalidTxt);
        expect(middleware.validateEmail('a@', ''), Const.emailNotFound);
        expect(middleware.validateEmail('a@', 'a@'), null);
      });

      test('validatePassword', () {
        expect(middleware.validatePassword('', ''), Const.passwordBlankTxt);
        expect(middleware.validatePassword('a', 'b'), Const.passwordIncorrect);
        expect(middleware.validatePassword('a', 'a'), null);
      });

      test('onSubmitFailPath', () async {
        await middleware.onLoginSubmit()(store);
        verifyNever(() => prefs.setAuth(any()));
        verifyNever(() => prefs.setId(any()));
      });

      test('onSubmitHappyPath', () async {
        store.dispatchAll(const [
          LoginAction.emailTextChanged('b@'),
          LoginAction.passwordTextChanged('c'),
          LoginAction.errorsChanged('email', null),
          LoginAction.errorsChanged('password', null),
        ]);
        await middleware.onLoginSubmit()(store);
        verify(() => prefs.setAuth(any())).called(1);
        verify(() => prefs.setId(any())).called(1);
      });
    });

    group('view', () {
      testWidgets('registerBtn', (tester) async {
        var onBack = false;
        await tester.pumpWidget(testApp(() => LoginView.buttonsView(vm, () => onBack = true)));
        await tester.tap(find.text(Const.registerBtn));
        expectAllExist([Const.registerBtn]);
        expect(onBack, isTrue);
      });

      testWidgets('submitBtn', (tester) async {
        var onBack = false;
        await tester.pumpWidget(testApp(() => LoginView.buttonsView(vm, () => onBack = true)));
        await tester.tap(find.text(Const.submitBtn));
        expectAllExist([Const.submitBtn]);
        expect(onBack, isFalse);
      });

      testWidgets('fields', (tester) async {
        await tester.pumpWidget(testApp(() => LoginView.fieldsView(vm).material()));
        await tester.enterText(find.byType(TextField).at(0), 'b@');
        await tester.enterText(find.byType(TextField).at(1), 'c');

        var state = store.state.authState.loginState;
        expect(state.emailText, equals('b@'));
        expect(state.passwordText, equals('c'));
        expectAllExist([Const.emailLabel, Const.passwordLabel]);
      });

      testWidgets('build', (tester) async {
        registerFallbackValue(FakeContext());
        var nav = MockNav();
        when(() => nav.goTo(any(), any())).thenReturn(() => const Text(''));
        DI.instance.registerLazySingleton<LoginMiddleware>(() => middleware);
        DI.instance.registerLazySingleton<INav>(() => nav);
        await tester.pumpWidget(testApp(LoginView.new).storeProvider(store));
        expectAllExist([Const.registerBtn, Const.submitBtn, Const.loginTitle, Const.emailLabel, Const.passwordLabel]);
        await DI.instance.reset();
      });
    });
  });
}
//

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/core/di.dart';
import 'package:mydex/src/core/view.dart';
import 'package:mydex/src/model/state.dart';
import 'package:mydex/src/model/user.dart';
import 'package:mydex/src/service/nav.dart';
import 'package:mydex/src/view/auth/features/login.dart';

import '../../../core/util.dart';
import '../../../service/nav_test.dart';
import '../../../service/prefs_test.dart';
import '../../../service/repo_test.dart';

void main() {
  middlewareTests();
  viewTests();
}

void middlewareTests() {
  late LoginMiddleware middleware;
  late MockUserRepo userRepo;
  late MyDexStore store;
  late MockPrefs prefs;

  group('LoginMiddleware', () {
    setUp(() {
      prefs = MockPrefs();
      userRepo = MockUserRepo();
      middleware = LoginMiddleware(prefs, userRepo);
      store = setupStore(
        (_, c) => _.copyWith(
            authState: _.authState.copyWith(
          loginState: LoginReducer.reduce(_.authState.loginState, c),
        )),
      );
    });

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
      when(() => prefs.setAuth(any())).thenAnswerVoidFuture();
      when(() => prefs.setId(any())).thenAnswerVoidFuture();
      when(() => userRepo.doGetByEmail(any())).thenAnswerFuture(const User(id: 1, name: 'a', email: 'b@', password: 'c'));
      await middleware.onLoginSubmit()(store);
      verifyNever(() => prefs.setAuth(any()));
      verifyNever(() => prefs.setId(any()));
    });

    test('onSubmitHappyPath', () async {
      when(() => prefs.setAuth(any())).thenAnswerVoidFuture();
      when(() => prefs.setId(any())).thenAnswerVoidFuture();
      when(() => userRepo.doGetByEmail(any())).thenAnswerFuture(const User(id: 1, name: 'a', email: 'b@', password: 'c'));

      store.dispatch(const LoginAction.emailTextChanged('b@'));
      store.dispatch(const LoginAction.emailErrorChanged(null));
      store.dispatch(const LoginAction.passwordTextChanged('c'));
      store.dispatch(const LoginAction.passwordErrorChanged(null));
      await middleware.onLoginSubmit()(store);
      verify(() => prefs.setAuth(any())).called(1);
      verify(() => prefs.setId(any())).called(1);
    });
  });
}

void viewTests() {
  late MyDexStore store;
  late MockNav nav;
  late LoginVM vm;

  group('LoginView', () {
    setUp(() {
      registerFallbackValue(FakeContext());
      var prefs = MockPrefs();
      var userRepo = MockUserRepo();
      var middleware = LoginMiddleware(prefs, userRepo);
      store = setupStore(
        (_, c) => _.copyWith(
            authState: _.authState.copyWith(
          loginState: LoginReducer.reduce(_.authState.loginState, c),
        )),
      );
      vm = LoginVM.fromStore(store, middleware);
      nav = MockNav();

      DI.instance
        ..registerLazySingleton<LoginMiddleware>(() => middleware)
        ..registerLazySingleton<INav>(() => nav);
    });

    tearDown(() async => DI.instance.reset());

    testWidgets('registerBtn', (tester) async {
      var registerClicked = false;
      await tester.pumpWidget(testApp(() => LoginView.buttonsView(vm, () => registerClicked = true)));
      expect(find.text(Const.registerBtn), findsOneWidget);
      await tester.tap(find.text(Const.registerBtn));
      await tester.pump();
      expect(registerClicked, isTrue);
    });

    testWidgets('submitBtn', (tester) async {
      await tester.pumpWidget(testApp(() => LoginView.buttonsView(vm, () {})));
      expect(find.text(Const.submitBtn), findsOneWidget);
      await tester.tap(find.text(Const.submitBtn));
      await tester.pump();
    });

    testWidgets('fields', (tester) async {
      await tester.pumpWidget(testApp(() => LoginView.fieldsView(vm).material()));
      expect(find.text(Const.emailLabel), findsOneWidget);
      expect(find.text(Const.passwordLabel), findsOneWidget);
    });

    testWidgets('build', (tester) async {
      when(() => nav.goTo(any(), any())).thenReturn(() => const Text(''));
      await tester.pumpWidget(testApp(LoginView.new).storeProvider(store));
      expectAllExist([
        Const.registerBtn,
        Const.submitBtn,
        Const.loginTitle,
        Const.emailLabel,
        Const.passwordLabel,
      ]);
      await tester.enterText(find.byType(TextField).at(0), 'b@');
      await tester.enterText(find.byType(TextField).at(1), 'ac');
    });
  });
}

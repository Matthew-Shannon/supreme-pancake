import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/core/di.dart';
import 'package:mydex/src/core/view.dart';
import 'package:mydex/src/model/state.dart';
import 'package:mydex/src/model/user.dart';
import 'package:mydex/src/service/nav.dart';
import 'package:mydex/src/view/auth/features/register.dart';

import '../../../core/mock.dart';
import '../../../core/util.dart';

void main() {
  group('Register', () {
    late RegisterMiddleware middleware;
    late UserRepo userRepo;
    late MyDexStore store;
    late RegisterVM vm;

    setUp(() {
      userRepo = MockUserRepo();
      when(() => userRepo.doInsert(any())).thenCall();
      when(() => userRepo.doGet(any())).thenReply(mockUser);

      middleware = RegisterMiddleware(userRepo);
      store = setupStore([MyDexReducer.authSelector]);

      vm = RegisterVM.fromStore(store, middleware);
    });

    group('middleware', () {
      group('RegisterMiddleware', () {
        test('validateName', () {
          expect(middleware.validateName(''), Const.nameIsBlankTxt);
          expect(middleware.validateName('a'), null);
        });
        test('validateEmail', () {
          expect(middleware.validateEmail('', ''), Const.emailBlankTxt);
          expect(middleware.validateEmail('a', ''), Const.emailInvalidTxt);
          expect(middleware.validateEmail('a@', 'a@'), Const.emailAlreadyExistTxt);
          expect(middleware.validateEmail('a@', ''), null);
        });

        test('validatePassword', () {
          expect(middleware.validatePassword(''), Const.passwordBlankTxt);
          expect(middleware.validatePassword('a'), null);
        });

        test('onSubmitFailPath', () async {
          var wasCalled = false;
          await middleware.onRegisterSubmit(() => wasCalled = true)(store);
          verifyNever(() => userRepo.doInsert(any()));
          expect(wasCalled, isFalse);
        });

        test('onSubmitHappyPath', () async {
          store.dispatchAll(const [
            RegisterAction.nameTextChanged('a'),
            RegisterAction.emailTextChanged('b@'),
            RegisterAction.passwordTextChanged('c'),
            RegisterAction.errorsChanged('name', null),
            RegisterAction.errorsChanged('email', null),
            RegisterAction.errorsChanged('password', null),
          ]);
          var wasCalled = false;
          when(() => userRepo.doGet(any())).thenReply(const User());
          await middleware.onRegisterSubmit(() => wasCalled = true)(store);
          verify(() => userRepo.doInsert(any())).called(1);
          expect(wasCalled, isTrue);
        });
      });
    });

    group('view', () {
      testWidgets('loginBtn', (tester) async {
        var onBack = false;
        await tester.pumpWidget(testApp(() => RegisterView.buttonsView(vm, () => onBack = true)));
        await tester.tap(find.text(Const.loginBtn));
        expect(onBack, isTrue);
        expectAllExist([Const.loginBtn]);
      });

      testWidgets('submitBtn', (tester) async {
        var onBack = false;
        var vm = RegisterVM.fromStore(store, middleware);
        await tester.pumpWidget(testApp(() => RegisterView.buttonsView(vm, () => onBack = true)));
        await tester.tap(find.text(Const.submitBtn));
        expect(onBack, isFalse);
        expectAllExist([Const.submitBtn]);
      });

      testWidgets('fields', (tester) async {
        await tester.pumpWidget(testApp(() => RegisterView.fieldsView(vm).material()));
        await tester.enterText(find.byType(TextField).at(0), 'a');
        await tester.enterText(find.byType(TextField).at(1), 'b@');
        await tester.enterText(find.byType(TextField).at(2), 'c');

        var state = store.state.authState.registerState;
        expect(state.nameText, equals('a'));
        expect(state.emailText, equals('b@'));
        expect(state.passwordText, equals('c'));
        expectAllExist([Const.nameLabel, Const.emailLabel, Const.passwordLabel]);
      });

      testWidgets('build', (tester) async {
        registerFallbackValue(FakeContext());
        var nav = MockNav();
        when(() => nav.goBack(any())).thenReturn(() {});
        DI.instance.registerLazySingleton<RegisterMiddleware>(() => middleware);
        DI.instance.registerLazySingleton<INav>(() => nav);
        await tester.pumpWidget(testApp(RegisterView.new).storeProvider(store));
        expectAllExist([Const.loginBtn, Const.submitBtn, Const.registerTitle, Const.nameLabel, Const.emailLabel, Const.passwordLabel]);
        await DI.instance.reset();
      }, skip: false);
    });
  });
}

import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/core/di.dart';
import 'package:mydex/src/model/model.dart';
import 'package:mydex/src/service/service.dart';
import 'package:mydex/src/view/auth/features/register.dart';

import '../../../core/mock.dart';
import '../../../core/util.dart';

void main() {
  group('Register', () {
    late RegisterStore store;
    late UserRepo userRepo;

    setUp(() {
      registerFallbackValue(FakeUser());
      userRepo = MockUserRepo();
      when(() => userRepo.doInsert(any())).thenCall();
      when(() => userRepo.doGet()).thenReply(some(mockUser));
      store = RegisterStore(userRepo);
    });

    group('store', () {
      group('RegisterMiddleware', () {
        test('validateName', () {
          expect(store.validateName(''), some(Const.nameBlankTxt));
          expect(store.validateName('a'), none());
        });
        test('validateEmail', () {
          expect(store.validateEmail('', ''), some(Const.emailBlankTxt));
          expect(store.validateEmail('a', ''), some(Const.emailInvalidTxt));
          expect(store.validateEmail('a@', 'a@'), some(Const.emailAlreadyExistTxt));
          expect(store.validateEmail('a@', ''), none());
        });

        test('validatePassword', () {
          expect(store.validatePassword(''), some(Const.passwordBlankTxt));
          expect(store.validatePassword('a'), none());
        });

        test('onSubmitFailPath', () async {
          var wasCalled = false;
          await store.onRegisterSubmit(() => wasCalled = true);
          verifyNever(() => userRepo.doInsert(any()));
          expect(wasCalled, isFalse);
          expect(store.errors.value[Const.nameLabel], some(Const.nameBlankTxt));
          expect(store.errors.value[Const.emailLabel], some(Const.emailBlankTxt));
          expect(store.errors.value[Const.passwordLabel], some(Const.passwordBlankTxt));
        });

        test('onSubmitHappyPath', () async {
          store.nameChanged('a');
          store.emailChanged('b@');
          store.passwordChanged('c');
          var wasCalled = false;
          when(() => userRepo.doGet()).thenReply(none<User>());
          await store.onRegisterSubmit(() => wasCalled = true);
          verify(() => userRepo.doInsert(any())).called(1);
          expect(wasCalled, isTrue);
          expect(store.errors.value[Const.nameLabel], none());
          expect(store.errors.value[Const.emailLabel], none());
          expect(store.errors.value[Const.passwordLabel], none());
        });
      });
    });

    group('view', () {
      testWidgets('loginBtn', (tester) async {
        var onBack = false;
        var view = RegisterView.buttonsView(store, () => onBack = true);
        await tester.inflate(view);
        await tester.tap(find.text(Const.loginBtn));
        expect(onBack, isTrue);
        expectAllExist([Const.loginBtn]);
      });

      testWidgets('submitBtn', (tester) async {
        var onBack = false;
        var view = RegisterView.buttonsView(store, () => onBack = true);
        await tester.inflate(view);
        await tester.tap(find.text(Const.submitBtn));
        expect(onBack, isFalse);
        expectAllExist([Const.submitBtn]);
      });

      testWidgets('fields', (tester) async {
        var view = () => RegisterView.fieldsView(store);
        await tester.inflateWithScaling(view);
        await tester.enterText(find.byType(TextField).at(0), 'a');
        await tester.enterText(find.byType(TextField).at(1), 'b@');
        await tester.enterText(find.byType(TextField).at(2), 'c');

        expect(store.name.value, equals('a'));
        expect(store.email.value, equals('b@'));
        expect(store.password.value, equals('c'));
        expectAllExist([Const.nameLabel, Const.emailLabel, Const.passwordLabel]);
      });

      testWidgets('build', (tester) async {
        registerFallbackValue(FakeContext());
        var nav = MockNav();
        when(() => nav.goBack(any())).thenReturn(() {});
        DI.instance.registerLazySingleton<RegisterStore>(() => store);
        DI.instance.registerLazySingleton<INav>(() => nav);
        await tester.inflateWithScaling(RegisterView.new);
        expectAllExist([Const.loginBtn, Const.submitBtn, Const.registerTitle, Const.nameLabel, Const.emailLabel, Const.passwordLabel]);
        await DI.instance.reset();
      });
    });
  });
}

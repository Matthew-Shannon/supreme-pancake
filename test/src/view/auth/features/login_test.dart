import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/core/di.dart';
import 'package:mydex/src/service/service.dart';
import 'package:mydex/src/view/auth/auth.dart';
import 'package:mydex/src/view/auth/features/login.dart';

import '../../../core/mock.dart';
import '../../../core/util.dart';

void main() {
  group('login', () {
    late LoginStore store;
    late IPrefs prefs;

    setUp(() {
      prefs = MockPrefs();
      when(() => prefs.setAuth(any())).thenCall();
      var userRepo = MockUserRepo();
      when(() => userRepo.doGet()).thenReply(some(mockUser));
      var authStore = AuthStore();
      store = LoginStore(prefs, userRepo, authStore);
    });

    group('store', () {
      test('validateEmail', () {
        expect(store.validateEmail('', ''), some(Const.emailBlankTxt));
        expect(store.validateEmail('a', ''), some(Const.emailInvalidTxt));
        expect(store.validateEmail('a@', ''), some(Const.emailNotFound));
        expect(store.validateEmail('a@', 'a@'), none());
      });

      test('validatePassword', () {
        expect(store.validatePassword('', ''), some(Const.passwordBlankTxt));
        expect(store.validatePassword('a', 'b'), some(Const.passwordIncorrect));
        expect(store.validatePassword('a', 'a'), none());
      });

      test('onSubmitFailPath', () async {
        await store.onLoginSubmit();
        verifyNever(() => prefs.setAuth(any()));
        expect(store.errors.value[Const.emailLabel], some(Const.emailBlankTxt));
        expect(store.errors.value[Const.passwordLabel], some(Const.passwordBlankTxt));
      });

      test('onSubmitHappyPath', () async {
        store.emailChanged('b@');
        store.passwordChanged('c');
        await store.onLoginSubmit();
        verify(() => prefs.setAuth(any())).called(1);
        expect(store.errors.value[Const.emailLabel], none());
        expect(store.errors.value[Const.passwordLabel], none());
      });
    });

    group('view', () {
      testWidgets('registerBtn', (tester) async {
        var onBack = false;
        var view = LoginView.buttonsView(store, () => onBack = true);
        await tester.inflate(view);
        expectAllExist([Const.registerBtn]);
        await tester.tap(find.text(Const.registerBtn));
        expect(onBack, isTrue);
      });

      testWidgets('submitBtn', (tester) async {
        var onBack = false;
        var view = LoginView.buttonsView(store, () => onBack = true);
        await tester.inflate(view);
        expectAllExist([Const.submitBtn]);
        await tester.tap(find.text(Const.submitBtn));
        expect(onBack, isFalse);
      });

      testWidgets('fields', (tester) async {
        var view = () => LoginView.fieldsView(store);
        await tester.inflateWithScaling(view);
        await tester.enterText(find.byType(TextField).at(0), 'b@');
        await tester.enterText(find.byType(TextField).at(1), 'c');

        expect(store.email.value, equals('b@'));
        expect(store.password.value, equals('c'));
        expectAllExist([Const.emailLabel, Const.passwordLabel]);
      });

      testWidgets('build', (tester) async {
        registerFallbackValue(FakeContext());
        var nav = MockNav();
        when(() => nav.goTo(any(), any())).thenReturn(() => const Text(''));
        DI.instance.registerLazySingleton<LoginStore>(() => store);
        DI.instance.registerLazySingleton<INav>(() => nav);
        await tester.inflateWithScaling(LoginView.new);
        expectAllExist([Const.registerBtn, Const.submitBtn, Const.loginTitle, Const.emailLabel, Const.passwordLabel]);
        await DI.instance.reset();
      });
    });
  });
}
//

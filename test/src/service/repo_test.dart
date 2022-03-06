import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mydex/src/model/pokemon/pair.dart';
import 'package:mydex/src/model/pokemon/pokemon.dart';
import 'package:mydex/src/model/user.dart';
import 'package:mydex/src/service/repo.dart';

import '../core/util.dart';

class MockBaseLocal<String> extends Mock implements BaseLocal<String> {}

class MockUserRepo extends Mock implements UserRepo {}

class MockPokemonRepo extends Mock implements PokemonRepo {}

class MockPairRepo extends Mock implements PairRepo {}

void main() {
  tests();
}

void tests() {
  late MockBaseLocal<String> local;
  late TestRepo repo;

  group('Repo', () {
    setUp(() {
      local = MockBaseLocal<String>();
      repo = TestRepo(local);
    });

    test('doInsert', () async {
      when(() => local.onInsert(any())).thenAnswerVoidFuture();
      await repo.doInsert(['foo']);
      verify(() => local.onInsert(['foo'])).called(1);
    });

    test('doCache', () async {
      when(() => local.onDelete(any())).thenAnswerVoidFuture();
      when(() => local.onInsert(any())).thenAnswerVoidFuture();
      await repo.doCache('foo');
      verify(() => local.onDelete(['foo'])).called(1);
      verify(() => local.onInsert(['foo'])).called(1);
    });

    test('doCacheAll', () async {
      when(() => local.onDelete(any())).thenAnswerVoidFuture();
      when(() => local.onInsert(any())).thenAnswerVoidFuture();
      await repo.doCacheAll(['foo', 'bar']);
      verify(() => local.onDelete(['foo', 'bar'])).called(1);
      verify(() => local.onInsert(['foo', 'bar'])).called(1);
    });
  });
}

class TestRepo extends BaseRepo<String> {
  TestRepo(BaseLocal<String> local) : super(local);

  @override
  Future<String> doGet(String query) => throw UnimplementedError();

  @override
  Future<List<String>> doGetAll() => throw UnimplementedError();
}

import 'package:mydex/src/model/pokemon/resource.dart';

import '../core/mock.dart';
import '../core/util.dart';

void main() {
  group('NamedRes', () {
    group('model', () {
      test('equals', () {
        expect(const NamedApiResource() == const NamedApiResource(), isTrue);
        expect(NamedApiResource == const NamedApiResource(name: 'c', url: 'd'), isFalse);
      });

      test('json', () {
        expect(NamedApiResource.fromJson(const NamedApiResource().toJson()) == const NamedApiResource(), isTrue);
        expect(NamedApiResource.fromJson(mockNamedRes.toJson()) == const NamedApiResource(name: 'c', url: 'd'), isFalse);
        expect(ApiResource.fromJson(const ApiResource().toJson()) == const ApiResource(), isTrue);
        expect(NamedApiResourceList.fromJson(const NamedApiResourceList().toJson()) == const NamedApiResourceList(), isTrue);
        expect(ApiResourceList.fromJson(const ApiResourceList().toJson()) == const ApiResourceList(), isTrue);
      });
    });

    group('vm', () {
      test('render', () {
        var vm = const NamedApiResourceVM(mockNamedRes);
        expect(vm.title, equals('a (1'));
      });
    });
  });
}

import '../../service/service.dart';
import '../util.dart';

part 'resource.freezed.dart';
part 'resource.g.dart';

class NamedApiResourceVM {
  final NamedApiResource res;
  const NamedApiResourceVM(this.res);

  String get id => '${res.id()}';
  String get title => res.name + ' ($id';
}

abstract class ResourceSummary {
  String get url;
  int id() => urlToId(url);
  String category() => urlToCategory(url);
}

abstract class ResourceSummaryList<T extends ResourceSummary> {
  int get count;
  String? get next;
  String? get previous;
  List<T> get results;
}

@freezed
class ApiResource with _$ApiResource, ResourceSummary {
  const factory ApiResource({
    @Default('') String url,
  }) = _ApiResource;
  const ApiResource._();
  factory ApiResource.fromJson(JSON json) => _$ApiResourceFromJson(json);
}

@freezed
class NamedApiResource with _$NamedApiResource, ResourceSummary {
  const factory NamedApiResource({
    @Default('') String name,
    @Default('') String url,
  }) = _NamedApiResource;
  const NamedApiResource._();
  factory NamedApiResource.fromJson(JSON json) => _$NamedApiResourceFromJson(json);
}

@freezed
class ApiResourceList with _$ApiResourceList, ResourceSummaryList<ApiResource> {
  const factory ApiResourceList({
    @Default(0) int count,
    @Default(null) String? next,
    @Default(null) String? previous,
    @Default([]) List<ApiResource> results,
  }) = _ApiResourceList;
  factory ApiResourceList.fromJson(JSON json) => _$ApiResourceListFromJson(json);
}

@freezed
class NamedApiResourceList with _$NamedApiResourceList, ResourceSummaryList<NamedApiResource> {
  const factory NamedApiResourceList({
    @Default('') String name,
    @Default(0) int count,
    @Default(null) String? next,
    @Default(null) String? previous,
    @Default([]) List<NamedApiResource> results,
  }) = _NamedApiResourceList;
  factory NamedApiResourceList.fromJson(JSON json) => _$NamedApiResourceListFromJson(json);
}

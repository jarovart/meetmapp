import 'package:freezed_annotation/freezed_annotation.dart';

part 'paged_result.freezed.dart';

@freezed
abstract class PagedResult<T> with _$PagedResult<T> {
  const factory PagedResult({required List<T> items, required bool hasMore}) =
      _PagedResult<T>;
}

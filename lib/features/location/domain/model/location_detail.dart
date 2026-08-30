import 'package:casttime/features/location/domain/model/app_image.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_detail.freezed.dart';

@freezed
abstract class LocationDetail with _$LocationDetail {
  const factory LocationDetail({
    required Location location,
    required List<AppImage> images,
  }) = _LocationDetail;
}

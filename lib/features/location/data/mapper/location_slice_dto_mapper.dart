import 'package:casttime/core/result/paged_result.dart';
import 'package:casttime/features/location/data/dto/response/location_slice_response_dto.dart';
import 'package:casttime/features/location/data/mapper/location_dto_mapper.dart';
import 'package:casttime/features/location/domain/model/location.dart';

extension LocationSliceDtoMapper on LocationSliceResponseDTO {
  PagedResult<Location> toDomain() {
    return PagedResult(
      items: content.map((dto) => dto.toDomain()).toList(),
      hasMore: !last,
    );
  }
}

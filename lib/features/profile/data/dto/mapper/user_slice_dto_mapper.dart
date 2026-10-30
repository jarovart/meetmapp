import 'package:casttime/core/result/paged_result.dart';
import 'package:casttime/features/profile/data/dto/mapper/profile_dto_mapper.dart';
import 'package:casttime/features/profile/data/dto/response/user_slice_response_dto.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';

extension UserSliceDtoMapper on UserSliceResponseDTO {
  PagedResult<UserProfile> toDomain() => PagedResult(
    items: content.map((dto) => dto.toDomain()).toList(),
    hasMore: !last,
  );
}

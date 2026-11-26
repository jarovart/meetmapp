import 'package:casttime/features/profile/domain/model/profile_image_change.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_update.freezed.dart';

@freezed
abstract class ProfileUpdate with _$ProfileUpdate {
  const factory ProfileUpdate({
    required String firstName,
    required String lastName,
    required String aboutMe,
    required ProfileImageChange imageChange,
  }) = _ProfileUpdate;
}

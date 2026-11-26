import 'dart:typed_data';

import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/features/profile/domain/model/profile_image_change.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_edit_state.freezed.dart';

sealed class ProfileAvatarSource {
  const ProfileAvatarSource();
}

class AvatarFromMemory extends ProfileAvatarSource {
  const AvatarFromMemory(this.bytes);
  final Uint8List bytes;
}

class AvatarFromNetwork extends ProfileAvatarSource {
  const AvatarFromNetwork(this.url);
  final String url;
}

class AvatarNone extends ProfileAvatarSource {
  const AvatarNone();
}

@freezed
abstract class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState({
    UserProfile? original,
    @Default(LoadStatus.initial) LoadStatus status,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String aboutMe,
    @Default(KeepImage()) ProfileImageChange imageChange,
    @Default(false) bool isProcessingImage,
    @Default(false) bool isSaving,
    @Default(false) bool isSaved,
    AppFailure? failure,
  }) = _ProfileEditState;

  const ProfileEditState._();

  bool get isBusy => isSaving || isProcessingImage;

  ProfileAvatarSource get avatarSource {
    switch (imageChange) {
      case ReplaceImage(:final bytes):
        return AvatarFromMemory(bytes);
      case RemoveImage():
        return const AvatarNone();
      case KeepImage():
        final url = original?.profileImage?.imageUrl;
        return (url == null || url.isEmpty)
            ? const AvatarNone()
            : AvatarFromNetwork(url);
    }
  }
}

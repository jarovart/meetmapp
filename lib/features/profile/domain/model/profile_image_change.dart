import 'dart:typed_data';

sealed class ProfileImageChange {
  const ProfileImageChange();
}

class KeepImage extends ProfileImageChange {
  const KeepImage();
}

class ReplaceImage extends ProfileImageChange {
  const ReplaceImage(this.bytes);
  final Uint8List bytes;
}

class RemoveImage extends ProfileImageChange {
  const RemoveImage();
}

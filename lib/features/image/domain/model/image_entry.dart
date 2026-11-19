import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_entry.freezed.dart';

@freezed
sealed class ImageEntry with _$ImageEntry {
  const factory ImageEntry.existing({
    required int id,
    required Uint8List bytes,
  }) = ExistingImage;

  const factory ImageEntry.added({required Uint8List bytes}) = AddedImage;

  const ImageEntry._();

  Uint8List get data => switch (this) {
    ExistingImage(:final bytes) => bytes,
    AddedImage(:final bytes) => bytes,
  };
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_image.freezed.dart';

@freezed
abstract class AppImage with _$AppImage {
  const factory AppImage({required int id, required String imageUrl}) =
      _AppImage;
}

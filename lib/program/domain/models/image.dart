import 'package:freezed_annotation/freezed_annotation.dart';

part 'image.freezed.dart';

@freezed
class Image with _$Image {
  final int id;
  final String imageUrl;

  Image({required this.id, required this.imageUrl});
}

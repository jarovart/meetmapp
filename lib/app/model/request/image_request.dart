import 'dart:typed_data';

class ImageRequest {
  final int? id;
  final Uint8List bytes;
  final bool isNew;
  final String clientKey;
  final int sortIndex;

  ImageRequest.existing({
    required this.id,
    required this.bytes,
    required this.sortIndex,
  }) : isNew = false,
       clientKey = 'existing_$id';

  ImageRequest.newImage({required this.bytes, required this.sortIndex})
    : id = null,
      isNew = true,
      clientKey = 'new_${DateTime.now().microsecondsSinceEpoch}';

  Map<String, dynamic> toOrderMap() {
    return {'id': id, 'clientKey': clientKey, 'isNew': isNew};
  }

  ImageRequest copyWithSortIndex(int index) {
    if (isNew) {
      return ImageRequest.newImage(bytes: bytes, sortIndex: index);
    }

    return ImageRequest.existing(id: id, bytes: bytes, sortIndex: index);
  }
}

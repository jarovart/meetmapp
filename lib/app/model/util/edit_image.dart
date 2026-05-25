import 'dart:typed_data';

class EditableLocationImage {
  final int? id;
  final Uint8List bytes;
  final bool isNew;

  EditableLocationImage({
    required this.id,
    required this.bytes,
    required this.isNew,
  });
}

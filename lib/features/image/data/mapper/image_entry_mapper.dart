import 'dart:convert';

import 'package:casttime/features/image/data/dto/image_entry_request_dto.dart';
import 'package:casttime/features/image/domain/model/image_entry.dart';

/*extension ImageEntryMapper on ImageEntry {
  ImageEntryRequestDTO toRequestDTO({required int sortIndex}) {
    return switch (this) {
      ExistingImage(:final id) => ImageEntryRequestDTO(
        id: id,
        sortIndex: sortIndex,
      ),
      AddedImage(:final bytes) => ImageEntryRequestDTO(
        base64Data: base64Encode(bytes),
        sortIndex: sortIndex,
      ),
    };
  }
}*/

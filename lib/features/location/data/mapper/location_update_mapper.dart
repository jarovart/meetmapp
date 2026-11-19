import 'package:casttime/features/image/data/dto/image_entry_request_dto.dart';
import 'package:casttime/features/image/domain/model/image_entry.dart';
import 'package:casttime/features/location/data/dto/request/update_location_request_dto.dart';
import 'package:casttime/features/location/domain/model/location_update.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

extension LocationUpdateMapper on LocationUpdate {
  ({UpdateLocationRequestDTO data, List<MultipartFile> files}) toRequestDTO() {
    final files = <MultipartFile>[];
    final entries = <ImageEntryRequestDTO>[];

    for (var i = 0; i < images.length; i++) {
      switch (images[i]) {
        case ExistingImage(:final id):
          entries.add(ImageEntryRequestDTO(id: id, isNew: false, sortIndex: i));
        case AddedImage(:final bytes):
          entries.add(ImageEntryRequestDTO(isNew: true, sortIndex: i));
          files.add(
            MultipartFile.fromBytes(
              bytes,
              filename: 'image_$i.jpg',
              contentType: MediaType('image', 'jpeg'),
            ),
          );
      }
    }

    return (
      data: UpdateLocationRequestDTO(
        id: id,
        title: title,
        description: description,
        address: address,
        latitude: position.latitude,
        longitude: position.longitude,
        startDateTime: startDateTime,
        endDateTime: endDateTime,
        imageRequests: entries,
      ),
      files: files,
    );
  }
}

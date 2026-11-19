import 'package:casttime/features/image/data/dto/image_entry_request_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_location_request_dto.g.dart';

@JsonSerializable()
class UpdateLocationRequestDTO {
  const UpdateLocationRequestDTO({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.startDateTime,
    required this.endDateTime,
    required this.imageRequests,
  });

  final int id;
  final String title;
  final String description;
  final String address;
  final double latitude;
  final double longitude;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final List<ImageEntryRequestDTO> imageRequests;

  factory UpdateLocationRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$UpdateLocationRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateLocationRequestDTOToJson(this);
}

import 'package:casttime/features/location/data/dto/request/create_location_request_dto.dart';
import 'package:casttime/features/location/domain/model/location_draft.dart';

extension LocationDraftToRequestMapper on LocationDraft {
  CreateLocationRequestDTO toCreateRequest() {
    return CreateLocationRequestDTO(
      title: title,
      description: description,
      address: address,
      creationDateTime: DateTime.now(),
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      latitude: position.latitude,
      longitude: position.longitude,
      createdUsername: createdUsername,
    );
  }
}

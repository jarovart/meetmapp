import 'package:casttime/features/info/data/dto/status_response_dto.dart';
import 'package:casttime/features/info/domain/model/app_status.dart';

extension StatusDtoMapper on StatusResponseDTO {
  AppStatus toDomain() => AppStatus(
    serverVersion: serverVersion,
    serverOnline: serverOnline,
    databaseOnline: dataBaseOnline,
  );
}

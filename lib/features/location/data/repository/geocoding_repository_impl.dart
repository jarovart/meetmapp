// data/repository/geocoding_repository_impl.dart
import 'package:casttime/core/failure/api_failure_mapper.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/location/data/api/geocoding_api.dart';
import 'package:casttime/features/location/data/dto/response/nominatim_response_dto.dart';
import 'package:casttime/features/location/domain/repositoryinterface/geocoding_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@LazySingleton(as: GeocodingRepository)
class GeocodingRepositoryImpl implements GeocodingRepository {
  const GeocodingRepositoryImpl(this._api, this._failureMapper);

  final GeocodingApi _api;
  final ApiFailureMapper _failureMapper;

  @override
  Future<AppResult<String?>> reverseGeocode(LatLng position) async {
    try {
      final dto = await _api.reverseGeocode(
        position.latitude,
        position.longitude,
      );
      return Success(_formatAddress(dto));
    } catch (error, stackTrace) {
      return Failure(_failureMapper.map(error, stackTrace));
    }
  }

  String? _formatAddress(NominatimResponseDTO dto) {
    final address = dto.address;
    if (address == null) return dto.displayName;

    final street = [
      address.road,
      address.houseNumber,
    ].whereType<String>().join(' ');
    final place = address.city ?? address.town ?? address.village;
    final cityLine = [address.postcode, place].whereType<String>().join(' ');

    final parts = [
      street,
      cityLine,
      address.country,
    ].where((p) => p != null && p.isNotEmpty).toList();

    return parts.isEmpty ? dto.displayName : parts.join(', ');
  }
}

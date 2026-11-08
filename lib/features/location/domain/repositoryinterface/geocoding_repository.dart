import 'package:casttime/core/result/app_result.dart';
import 'package:latlong2/latlong.dart';

abstract interface class GeocodingRepository {
  Future<AppResult<String?>> reverseGeocode(LatLng position);
}

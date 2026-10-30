import 'package:casttime/features/profile/domain/model/location_list_type.dart';
import 'package:casttime/features/profile/domain/service/user_profile_service.dart';
import 'package:casttime/features/profile/presentation/cubit/location_list_cubit.dart';
import 'package:injectable/injectable.dart';

@injectable
class LikedLocationsCubit extends LocationListCubit {
  LikedLocationsCubit(UserProfileService service, @factoryParam String username)
    : super(service, username, LocationListType.liked);
}

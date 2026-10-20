import 'package:casttime/app/presentation/cubit/profile_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ProfileSectionCubit extends Cubit<ProfileSection> {
  ProfileSectionCubit() : super(ProfileSection.overview);

  void select(ProfileSection section) => emit(section);
  void reset() => emit(ProfileSection.overview);
}

import 'package:casttime/features/auth/domain/repository/auth_repository.dart';
import 'package:casttime/features/auth/domain/service/auth_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthService)
class AuthServiceImpl implements AuthService {
  final AuthRepository repository;

  AuthServiceImpl(this.repository);
}

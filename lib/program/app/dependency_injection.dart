import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'dependency_injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> setupDependencies() async => await getIt.init();

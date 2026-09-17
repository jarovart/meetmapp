import 'package:injectable/injectable.dart';

@LazySingleton()
class SheetSizeMemory {
  double lastSize = 0.8;
}

// app/navigation/edit_bar/edit_bar_cubit.dart
import 'package:casttime/app/navigation/handler/edit_bar_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EditBarCubit extends Cubit<EditBarHandler?> {
  EditBarCubit() : super(null);

  void register(EditBarHandler handler) => emit(handler);

  void unregister(String ownerId) {
    if (state?.ownerId == ownerId) emit(null);
  }
}

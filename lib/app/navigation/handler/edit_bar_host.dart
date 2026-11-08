import 'package:casttime/app/navigation/handler/edit_bar_handler.dart';
import 'package:casttime/app/presentation/cubit/edit_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin EditBarHost<T extends StatefulWidget> on State<T> {
  String get editBarOwnerId;

  VoidCallback get onEditBarCancel;
  VoidCallback get onEditBarReset;
  VoidCallback get onEditBarSave;

  bool get canSave => true;
  bool get canReset => true;
  bool get isBusy => false;

  void publishEditBar() {
    if (!mounted) return;
    context.read<EditBarCubit>().register(
      EditBarHandler(
        ownerId: editBarOwnerId,
        onCancel: onEditBarCancel,
        onReset: onEditBarReset,
        onSave: onEditBarSave,
        canSave: canSave,
        canReset: canReset,
        isBusy: isBusy,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => publishEditBar());
  }

  @override
  void dispose() {
    context.read<EditBarCubit>().unregister(editBarOwnerId);
    super.dispose();
  }
}

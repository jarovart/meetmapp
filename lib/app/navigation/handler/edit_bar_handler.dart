// app/navigation/edit_bar/edit_bar_handler.dart
import 'package:flutter/foundation.dart';

@immutable
class EditBarHandler {
  const EditBarHandler({
    required this.ownerId,
    required this.onCancel,
    required this.onReset,
    required this.onSave,
    this.canSave = true,
    this.canReset = true,
    this.isBusy = false,
  });

  /// Identifiziert die registrierende Seite (z.B. 'location-create').
  final String ownerId;

  final VoidCallback onCancel;
  final VoidCallback onReset;
  final VoidCallback onSave;

  final bool canSave;
  final bool canReset;
  final bool isBusy;

  EditBarHandler copyWith({bool? canSave, bool? canReset, bool? isBusy}) {
    return EditBarHandler(
      ownerId: ownerId,
      onCancel: onCancel,
      onReset: onReset,
      onSave: onSave,
      canSave: canSave ?? this.canSave,
      canReset: canReset ?? this.canReset,
      isBusy: isBusy ?? this.isBusy,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is EditBarHandler &&
      other.ownerId == ownerId &&
      other.canSave == canSave &&
      other.canReset == canReset &&
      other.isBusy == isBusy;

  @override
  int get hashCode => Object.hash(ownerId, canSave, canReset, isBusy);
}

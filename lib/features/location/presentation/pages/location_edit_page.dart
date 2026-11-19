import 'package:casttime/app/config/app_config.dart';
import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/localization/app_failure_localization.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/navigation/handler/edit_bar_handler.dart';
import 'package:casttime/app/navigation/handler/edit_bar_host.dart';
import 'package:casttime/app/navigation/widgets/back_bar.dart';
import 'package:casttime/app/navigation/widgets/dock_container.dart';
import 'package:casttime/app/navigation/widgets/edit_bar_row.dart';
import 'package:casttime/app/presentation/banner/appbanner_cubit.dart';
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/permissions/photo_permission.dart';
import 'package:casttime/features/image/domain/model/image_entry.dart';
import 'package:casttime/features/location/presentation/bloc/location_edit_bloc.dart';
import 'package:casttime/features/location/presentation/bloc/location_edit_event.dart';
import 'package:casttime/features/location/presentation/bloc/location_edit_state.dart';
import 'package:casttime/features/location/presentation/pages/widget/location_position_picker_widget.dart';
import 'package:casttime/features/setting/presentation/page/widget/edit_row.dart';
import 'package:casttime/features/setting/presentation/page/widget/info_card.dart';
import 'package:casttime/features/setting/presentation/page/widget/info_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationEditPage extends StatelessWidget {
  const LocationEditPage({super.key, required this.locationId});

  final int locationId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<LocationEditBloc>(param1: locationId)
            ..add(LocationEditStarted()),
      child: const _LocationEditView(),
    );
  }
}

class _LocationEditView extends StatefulWidget {
  const _LocationEditView();

  @override
  State<_LocationEditView> createState() => _LocationEditViewState();
}

class _LocationEditViewState extends State<_LocationEditView> with EditBarHost {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _picker = ImagePicker();

  @override
  String get editBarOwnerId => 'location-edit';

  @override
  bool get isBusy => context.read<LocationEditBloc>().state.isBusy;

  @override
  VoidCallback get onEditBarCancel =>
      () => context.pop(false);

  @override
  VoidCallback get onEditBarReset => _resetForm;

  @override
  VoidCallback get onEditBarSave => _submit;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descriptionCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  void _syncControllers(LocationEditState state) {
    if (_titleCtrl.text != state.title) _titleCtrl.text = state.title;
    if (_descriptionCtrl.text != state.description) {
      _descriptionCtrl.text = state.description;
    }
    if (_addressCtrl.text != state.address) _addressCtrl.text = state.address;
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    context.read<LocationEditBloc>().add(LocationEditReset());
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<LocationEditBloc>().add(LocationEditSubmitted());
  }

  Future<void> _pickImage() async {
    final hasPermission = await RequestPhotoPermission.requestPhotoPermission();
    if (!mounted) return;

    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.noPhotoPermission),
          action: SnackBarAction(
            label: context.l10n.settings,
            onPressed: openAppSettings,
          ),
        ),
      );
      return;
    }

    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1280,
      imageQuality: 80,
    );
    if (picked == null || !mounted) return;

    final bytes = await picked.readAsBytes();
    if (!mounted) return;

    context.read<LocationEditBloc>().add(LocationEditImageAdded(bytes));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocConsumer<LocationEditBloc, LocationEditState>(
      listenWhen: (p, c) =>
          p.status != c.status ||
          p.isBusy != c.isBusy ||
          p.isSaved != c.isSaved ||
          p.failure != c.failure,
      listener: (context, state) {
        _syncControllers(state);
        publishEditBar();

        if (state.failure != null) {
          context.read<AppBannerCubit>().showFailure(state.failure!);
        }
        if (state.isSaved) {
          context.pop(true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          body: _EditBody(
            state: state,
            formKey: _formKey,
            titleCtrl: _titleCtrl,
            descriptionCtrl: _descriptionCtrl,
            addressCtrl: _addressCtrl,
            onPickImage: _pickImage,
          ),
          bottomNavigationBar: DockContainer(
            child: EditBarRow(
              handler: EditBarHandler(
                ownerId: 'location-edit',
                onCancel: () => context.pop(false),
                onReset: _resetForm,
                onSave: _submit,
                isBusy: state.isBusy,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EditBody extends StatelessWidget {
  const _EditBody({
    required this.state,
    required this.formKey,
    required this.titleCtrl,
    required this.descriptionCtrl,
    required this.addressCtrl,
    required this.onPickImage,
  });

  final LocationEditState state;
  final GlobalKey<FormState> formKey;
  final TextEditingController titleCtrl;
  final TextEditingController descriptionCtrl;
  final TextEditingController addressCtrl;
  final VoidCallback onPickImage;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (state.status == LoadStatus.loading && state.original == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == LoadStatus.failure && state.original == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.failure?.localizedMessage(l10n) ??
                    l10n.locationCouldNotBeLoaded,
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () =>
                    context.read<LocationEditBloc>().add(LocationEditStarted()),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        AppConfig.maxNavigationDockBarHeight,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConfig.maxAppWidth),

          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InfoCard(
                  child: Column(
                    children: [
                      EditRow(
                        icon: Icons.title_outlined,
                        child: TextFormField(
                          controller: titleCtrl,
                          enabled: !state.isBusy,
                          decoration: InputDecoration(labelText: l10n.title),
                          onChanged: (v) => context
                              .read<LocationEditBloc>()
                              .add(LocationEditTitleChanged(v)),
                          validator: (v) => (v == null || v.isEmpty)
                              ? l10n.titleNotEmpty
                              : null,
                        ),
                      ),
                      const Divider(height: 24),
                      EditRow(
                        icon: Icons.description_outlined,
                        child: TextFormField(
                          controller: descriptionCtrl,
                          enabled: !state.isBusy,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: l10n.description,
                          ),
                          onChanged: (v) => context
                              .read<LocationEditBloc>()
                              .add(LocationEditDescriptionChanged(v)),
                          validator: (v) => (v == null || v.isEmpty)
                              ? l10n.missingDescription
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                InfoCard(
                  child: Column(
                    children: [
                      InfoRow(
                        icon: Icons.event_available_outlined,
                        label: l10n.chooseStartdate,
                        value: _format(context, state.startDateTime),
                        onTap: state.isBusy
                            ? null
                            : () => _pickDateTime(
                                context,
                                state.startDateTime,
                                (dt) => context.read<LocationEditBloc>().add(
                                  LocationEditStartDateChanged(dt),
                                ),
                              ),
                      ),
                      const Divider(height: 24),
                      InfoRow(
                        icon: Icons.event_busy_outlined,
                        label: l10n.chooseEnddate,
                        value: _format(context, state.endDateTime),
                        onTap: state.isBusy
                            ? null
                            : () => _pickDateTime(
                                context,
                                state.endDateTime,
                                (dt) => context.read<LocationEditBloc>().add(
                                  LocationEditEndDateChanged(dt),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                InfoCard(
                  child: EditRow(
                    icon: Icons.location_on_outlined,
                    child: TextFormField(
                      controller: addressCtrl,
                      enabled: !state.isBusy,
                      decoration: InputDecoration(
                        labelText: l10n.address,
                        suffixIcon: IconButton(
                          tooltip: l10n.resetAddress,
                          icon: const Icon(Icons.undo),
                          onPressed: () {
                            final original = state.original?.address ?? '';
                            addressCtrl.text = original;
                            context.read<LocationEditBloc>().add(
                              LocationEditAddressChanged(original),
                            );
                          },
                        ),
                      ),
                      onChanged: (v) => context.read<LocationEditBloc>().add(
                        LocationEditAddressChanged(v),
                      ),
                      validator: (v) =>
                          (v == null || v.isEmpty) ? l10n.missingAddress : null,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                PositionPicker(
                  position: state.position,
                  enabled: !state.isBusy,
                  onChanged: (position) => context.read<LocationEditBloc>().add(
                    LocationEditPositionChanged(position),
                  ),
                ),
                const SizedBox(height: 16),
                InfoCard(
                  title: l10n.images,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 12),
                      _EditImageList(
                        images: state.images,
                        enabled: !state.isBusy,
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: state.isBusy ? null : onPickImage,
                        icon: state.isProcessingImage
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.add_a_photo),
                        label: Text(l10n.addImage),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _format(BuildContext context, DateTime? dt) =>
      dt == null ? '—' : DateFormat('dd.MM.yyyy HH:mm').format(dt);

  Future<void> _pickDateTime(
    BuildContext context,
    DateTime? initial,
    ValueChanged<DateTime> onSelected,
  ) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initial ?? now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 5),
    );
    if (date == null || !context.mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial ?? now),
    );
    if (time == null) return;

    onSelected(
      DateTime(date.year, date.month, date.day, time.hour, time.minute),
    );
  }
}

class _EditImageList extends StatelessWidget {
  const _EditImageList({required this.images, required this.enabled});

  final List<ImageEntry> images;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (images.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          l10n.noImagesYet,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      buildDefaultDragHandles: enabled,
      itemCount: images.length,
      onReorderItem: (oldIndex, newIndex) => context
          .read<LocationEditBloc>()
          .add(LocationEditImagesReordered(oldIndex, newIndex)),
      itemBuilder: (context, index) {
        final entry = images[index];

        return Card(
          key: ValueKey(entry),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                entry.data,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(l10n.imageNumber(index + 1)),
            subtitle: index == 0 ? Text(l10n.thumbnail) : null,
            trailing: IconButton(
              tooltip: l10n.removeImage,
              icon: Icon(
                Icons.delete_outline,
                color: Theme.of(context).colorScheme.error,
              ),
              onPressed: enabled
                  ? () => context.read<LocationEditBloc>().add(
                      LocationEditImageRemoved(index),
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }
}

import 'dart:typed_data';

import 'package:casttime/app/config/app_config.dart';
import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/localization/app_failure_localization.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/navigation/handler/edit_bar_host.dart';
import 'package:casttime/app/navigation/util/route_config.dart';
import 'package:casttime/app/presentation/banner/appbanner_cubit.dart';
import 'package:casttime/features/location/presentation/bloc/location_create_bloc.dart';
import 'package:casttime/features/location/presentation/bloc/location_create_event.dart';
import 'package:casttime/features/location/presentation/bloc/location_create_state.dart';
import 'package:casttime/features/location/presentation/pages/widget/location_position_picker_widget.dart';
import 'package:casttime/features/map/presentation/bloc/map_bloc.dart';
import 'package:casttime/features/map/presentation/bloc/map_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class LocationCreatePage extends StatelessWidget {
  const LocationCreatePage({super.key, this.position});

  final LatLng? position;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LocationCreateBloc>(param1: position),
      child: const _LocationCreateView(),
    );
  }
}

class _LocationCreateView extends StatefulWidget {
  const _LocationCreateView();

  @override
  State<_LocationCreateView> createState() => _LocationCreateViewState();
}

class _LocationCreateViewState extends State<_LocationCreateView>
    with EditBarHost {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _picker = ImagePicker();

  @override
  String get editBarOwnerId => 'location-create';

  @override
  VoidCallback get onEditBarCancel =>
      () => context.go(RouteConfig.mapUrl);

  @override
  VoidCallback get onEditBarSave => _submit;

  @override
  VoidCallback get onEditBarReset => _resetForm;

  @override
  bool get isBusy {
    final state = context.read<LocationCreateBloc>().state;
    return state.isBusy || state.isProcessingImage;
  }

  @override
  void initState() {
    super.initState();
    context.read<LocationCreateBloc>().add(LocationCreateStarted());
    _addressCtrl.text =
        context.read<LocationCreateBloc>().state.initialAddress ?? '';
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descriptionCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1280,
      imageQuality: 80,
    );
    if (picked == null || !mounted) return;

    final bytes = await picked.readAsBytes();
    if (!mounted) return;

    context.read<LocationCreateBloc>().add(LocationImageAdded(bytes));
  }

  void _resetForm() {
    _titleCtrl.clear();
    _descriptionCtrl.clear();
    _addressCtrl.text =
        context.read<LocationCreateBloc>().state.initialAddress ?? '';
    _formKey.currentState?.reset();
    context.read<LocationCreateBloc>().add(LocationCreateReset());
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<LocationCreateBloc>().add(
      LocationCreateSubmitted(
        title: _titleCtrl.text,
        description: _descriptionCtrl.text,
        address: _addressCtrl.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocConsumer<LocationCreateBloc, LocationCreateState>(
      listenWhen: (p, c) =>
          p.step != c.step ||
          p.isProcessingImage != c.isProcessingImage ||
          p.failure != c.failure ||
          p.address != c.address,
      listener: (context, state) {
        if (state.failure != null) {
          context.read<AppBannerCubit>().showFailure(state.failure!);
        }
        if (state.address != _addressCtrl.text) {
          _addressCtrl.text = state.address;
        }
        debugPrint('step=${state.step} failure=${state.failure}');
        publishEditBar();
        if (state.step == CreateStep.done && state.createdLocation != null) {
          _resetForm();
          context.read<MapBloc>().add(
            MapLocationSelected(
              state.createdLocation!,
              zoom: 5,
              newCreatedLocation: true,
            ),
          );
          context.go(RouteConfig.mapUrl);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                AppConfig.maxNavigationDockBarHeight,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppConfig.maxAppWidth,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            l10n.createLocation,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _titleCtrl,
                          enabled: !state.isBusy,
                          decoration: InputDecoration(
                            labelText: l10n.enterTitle,
                            border: const OutlineInputBorder(),
                          ),
                          validator: (v) => (v == null || v.isEmpty)
                              ? l10n.titleNotEmpty
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionCtrl,
                          enabled: !state.isBusy,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: l10n.enterDescription,
                            border: const OutlineInputBorder(),
                          ),
                          validator: (v) => (v == null || v.isEmpty)
                              ? l10n.missingDescription
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _addressCtrl,
                          enabled: !state.isBusy,
                          decoration: InputDecoration(
                            labelText: l10n.enterAddress,
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              tooltip: l10n.resetAddress,
                              icon: const Icon(Icons.undo),
                              onPressed: () => _addressCtrl.text =
                                  state.initialAddress ?? '',
                            ),
                          ),
                          validator: (v) => (v == null || v.isEmpty)
                              ? l10n.missingAddress
                              : null,
                        ),
                        const SizedBox(height: 16),
                        _DateRow(
                          label: state.startDateTime == null
                              ? l10n.noChosedStartdate
                              : l10n.displayStartdate(
                                  _format(state.startDateTime!),
                                ),
                          buttonLabel: l10n.chooseStartdate,
                          enabled: !state.isBusy,
                          onPick: () => _pickDateTime(
                            state.startDateTime,
                            (dt) => context.read<LocationCreateBloc>().add(
                              LocationStartDateChanged(dt),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _DateRow(
                          label: state.endDateTime == null
                              ? l10n.noChosedEnddate
                              : l10n.displayEnddate(
                                  _format(state.endDateTime!),
                                ),
                          buttonLabel: l10n.chooseEnddate,
                          enabled: !state.isBusy,
                          onPick: () => _pickDateTime(
                            state.endDateTime,
                            (dt) => context.read<LocationCreateBloc>().add(
                              LocationEndDateChanged(dt),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (state.failure != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              state.failure!.localizedMessage(l10n),
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        Text(
                          l10n.images,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        _ImageList(
                          images: state.images,
                          enabled: !state.isBusy,
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          onPressed: (state.isBusy || state.isProcessingImage)
                              ? null
                              : _pickImage,
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
                        const SizedBox(height: 16),
                        PositionPicker(position: state.position, enabled: true),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _format(DateTime dt) => DateFormat('dd.MM.yyyy HH:mm').format(dt);

  Future<void> _pickDateTime(
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
    if (date == null || !mounted) return;

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

class _PositionBox extends StatelessWidget {
  const _PositionBox({required this.position});

  final LatLng position;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: colors.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => _copyToClipboard(context),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(Icons.place_outlined, color: colors.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.positionWithCoordinates(
                    position.latitude,
                    position.longitude,
                  ),
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              Icon(Icons.copy, size: 18, color: colors.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _copyToClipboard(BuildContext context) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);

    await Clipboard.setData(
      ClipboardData(text: '${position.latitude}, ${position.longitude}'),
    );

    messenger.showSnackBar(SnackBar(content: Text(l10n.positionCopied)));
  }
}

class _DateRow extends StatelessWidget {
  const _DateRow({
    required this.label,
    required this.buttonLabel,
    required this.enabled,
    required this.onPick,
  });

  final String label;
  final String buttonLabel;
  final bool enabled;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: enabled ? onPick : null,
          child: Text(buttonLabel),
        ),
      ],
    );
  }
}

class _ImageList extends StatelessWidget {
  const _ImageList({required this.images, required this.enabled});

  final List<Uint8List> images;
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
          .read<LocationCreateBloc>()
          .add(LocationImagesReordered(oldIndex, newIndex)),
      itemBuilder: (context, index) {
        return Card(
          key: ValueKey(images[index]),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                images[index],
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
                  ? () => context.read<LocationCreateBloc>().add(
                      LocationImageRemoved(index),
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }
}

import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/localization/app_failure_localization.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/features/location/domain/model/location_filter.dart';
import 'package:casttime/features/location/presentation/bloc/locationlist_bloc.dart';
import 'package:casttime/features/location/presentation/bloc/locationlist_event.dart';
import 'package:casttime/features/location/presentation/bloc/place_suggestion_cubit.dart';
import 'package:casttime/features/location/presentation/bloc/place_suggestion_state.dart';
import 'package:casttime/features/location/presentation/pages/widget/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class LocationFilterDialog extends StatefulWidget {
  const LocationFilterDialog({super.key});

  static Future<void> show(BuildContext context) {
    final searchBloc = context.read<LocationSearchBloc>();
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: searchBloc),
          BlocProvider(create: (_) => getIt<PlaceSuggestionCubit>()),
        ],
        child: const LocationFilterDialog(),
      ),
    );
  }

  @override
  State<LocationFilterDialog> createState() => _LocationFilterDialogState();
}

class _LocationFilterDialogState extends State<LocationFilterDialog> {
  late DateTime? _start;
  late DateTime? _end;
  late LatLng? _center;
  late double _radius;
  final _placeCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final current = context.read<LocationSearchBloc>().state.filter;
    _start = current?.start;
    _end = current?.end;
    _center = current?.center;
    _radius = current?.radiusKm ?? 10;
    _placeCtrl.text = current?.placeText ?? '';
  }

  @override
  void dispose() {
    _placeCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime({required bool isStart}) async {
    final now = DateTime.now();
    final initial = (isStart ? _start : _end) ?? now;

    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 5),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null) return;

    final picked = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() {
      if (isStart) {
        _start = picked;
      } else {
        _end = picked;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.filter,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.close,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FilterButton(
                              label: l10n.chooseStartdate,
                              value: dateFormat.format(
                                _start ?? DateTime.now(),
                              ),
                              onTap: () => _pickDateTime(isStart: true),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FilterButton(
                              label: l10n.chooseEnddate,
                              value: dateFormat.format(
                                _end ??
                                    DateTime.now().add(const Duration(days: 1)),
                              ),
                              onTap: () => _pickDateTime(isStart: false),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _placeCtrl,
                        decoration: InputDecoration(
                          labelText: l10n.places,
                          border: const OutlineInputBorder(),
                          suffixIcon:
                              BlocBuilder<
                                PlaceSuggestionCubit,
                                PlaceSuggestionState
                              >(
                                builder: (context, state) {
                                  if (state.isLoading) {
                                    return const Padding(
                                      padding: EdgeInsets.all(12),
                                      child: SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    );
                                  }
                                  if (_placeCtrl.text.isEmpty) {
                                    return const SizedBox.shrink();
                                  }
                                  return IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      _placeCtrl.clear();
                                      setState(() => _center = null);
                                      context
                                          .read<PlaceSuggestionCubit>()
                                          .clear();
                                    },
                                  );
                                },
                              ),
                        ),
                        onChanged: (value) {
                          setState(() => _center = null);
                          context.read<PlaceSuggestionCubit>().onQueryChanged(
                            value,
                          );
                        },
                      ),
                      BlocBuilder<PlaceSuggestionCubit, PlaceSuggestionState>(
                        builder: (context, state) {
                          if (state.failure != null) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                state.failure!.localizedMessage(l10n),
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          }
                          if (state.suggestions.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return Container(
                            margin: const EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).dividerColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.suggestions.length,
                              separatorBuilder: (_, _) =>
                                  const Divider(height: 1),
                              itemBuilder: (context, index) {
                                final suggestion = state.suggestions[index];
                                return ListTile(
                                  leading: Icon(
                                    suggestion.existedPlace
                                        ? Icons.location_city
                                        : Icons.public,
                                  ),
                                  title: Text(suggestion.name),
                                  onTap: () {
                                    setState(() {
                                      _center = suggestion.position;
                                      _placeCtrl.text = suggestion.name;
                                    });
                                    context
                                        .read<PlaceSuggestionCubit>()
                                        .clear();
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(l10n.radiusInput(_radius.toStringAsFixed(0))),
                      Slider(
                        value: _radius,
                        min: 1,
                        max: 200,
                        divisions: 199,
                        label: '${_radius.toStringAsFixed(0)} km',
                        onChanged: (v) => setState(() => _radius = v),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _start = null;
                        _end = null;
                        _center = null;
                        _radius = 10;
                        _placeCtrl.clear();
                      });
                      context.read<PlaceSuggestionCubit>().clear();
                    },
                    child: Text(l10n.reset),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LocationSearchBloc>().add(
                        LocationSearchFilterApplied(
                          LocationFilter(
                            start: _start,
                            end: _end,
                            center: _center,
                            placeText: _placeCtrl.text.trim().isEmpty
                                ? null
                                : _placeCtrl.text.trim(),
                            radiusKm: _radius,
                          ),
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text(l10n.apply),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

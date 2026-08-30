import 'package:casttime/features/map/presentation/bloc/map_bloc.dart';
import 'package:casttime/features/map/presentation/bloc/map_event.dart';
import 'package:casttime/features/map/presentation/bloc/map_state.dart';
import 'package:casttime/features/map/presentation/util/debouncer.dart';
import 'package:casttime/features/map/presentation/util/map_day_options.dart';
import 'package:casttime/features/map/presentation/widgets/mapslider/map_slider_daterange.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapSlider extends StatefulWidget {
  const MapSlider();

  @override
  State<MapSlider> createState() => _MapSliderState();
}

class _MapSliderState extends State<MapSlider> {
  late final Debouncer debouncer = Debouncer(
    delay: const Duration(milliseconds: 450),
  );
  RangeValues? dragValues = const RangeValues(0, 4);

  @override
  void dispose() {
    debouncer.cancel();
    super.dispose();
  }

  void _onChanged(RangeValues newValues, MapState state) {
    final snapped = RangeValues(
      newValues.start.roundToDouble(),
      newValues.end.roundToDouble(),
    );

    setState(() => dragValues = snapped);

    debouncer.run(
      () => context.read<MapBloc>().add(
        MapSliderChanged(
          bounds: state.bounds,
          rangeValues: snapped,
          startDate: dateFromDayOptionIndex(snapped.start.round()),
          endDate: dateFromDayOptionIndex(snapped.end.round()),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final timeLabels = dayOptionLabels(context);
    dragValues ??= RangeValues(0, timeLabels.length - 1);

    return BlocConsumer<MapBloc, MapState>(
      listenWhen: (p, c) =>
          p.rangeValues != c.rangeValues && dragValues != c.rangeValues,
      listener: (context, state) {
        setState(() => dragValues = state.rangeValues);
      },
      buildWhen: (p, c) => p.rangeValues != c.rangeValues,
      builder: (context, state) {
        debugPrint("main_mapslider blocbuilder");

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DateRangeLabel(timeLabels: timeLabels, dragValues: dragValues!),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                showValueIndicator: ShowValueIndicator.never,
                activeTrackColor: theme.iconTheme.color,
                inactiveTrackColor: colors.secondary.withValues(alpha: 0.3),
                thumbColor: colors.primary,
                overlayColor: colors.primary.withValues(alpha: 0.15),
                valueIndicatorColor: theme.cardTheme.color!.withValues(
                  alpha: 0.2,
                ),
                valueIndicatorTextStyle: TextStyle(color: colors.primary),
                trackHeight: 2,
                rangeThumbShape: const RoundRangeSliderThumbShape(
                  enabledThumbRadius: 8,
                ),
              ),
              child: RangeSlider(
                values: dragValues!,
                min: 0,
                max: (timeLabels.length - 1).toDouble(),
                divisions: timeLabels.length - 1,
                labels: RangeLabels(
                  timeLabels[dragValues!.start.toInt()],
                  timeLabels[dragValues!.end.toInt()],
                ),
                onChanged: (newValues) => _onChanged(newValues, state),
              ),
            ),
          ],
        );
      },
    );
  }
}

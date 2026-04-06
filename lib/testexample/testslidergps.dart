import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/exception/exception_message.dart';
import 'package:meetmaap/app/view/util/geolocationbutton_widget.dart';

class TestSliderGps extends StatefulWidget {
  const TestSliderGps({super.key});

  @override
  State<TestSliderGps> createState() => _TestSliderGpsState();
}

class _TestSliderGpsState extends State<TestSliderGps> {
  RangeValues _selectedRange = RangeValues(0, 4);
  final List<String> _dayOptions = [
    'Heute',
    'Morgen',
    'Übermorgen',
    '1 Woche',
    '1 Monat',
  ]; // Beispielwerte

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Show Modal Bottom Sheet"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade200,
      body: _buildDateSliderAndGps(),
    );
  }

  Widget _buildDateSliderAndGps() {
    final screenWidth = MediaQuery.of(context).size.width;
    final sidePadding = screenWidth * 0.2; // default padding to get ~60% width
    final fabDiameter = 40.0; // mini FAB diameter
    final bottomPadding = CenterOnUserButton.padding;

    final fullWidthMode = screenWidth < 620.0;

    final left = fullWidthMode ? 12.0 : sidePadding;
    final right = fullWidthMode ? 12.0 : sidePadding;

    // Transparent material and reduced height to match GPS button

    final sliderWidget = SafeArea(
      top: true,
      child: SizedBox(
        height: fabDiameter,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                showValueIndicator: ShowValueIndicator.onDrag,
                activeTrackColor: Colors.blue,
                inactiveTrackColor: Colors.blue.withValues(alpha: 0.3),
                thumbColor: Colors.blue,
                overlayColor: Colors.blue.withValues(alpha: 0.15),
                trackHeight: 2,
                rangeThumbShape: const RoundRangeSliderThumbShape(
                  enabledThumbRadius: 8,
                ),
              ),
              child: RangeSlider(
                values: _selectedRange,
                min: 0,
                max: (_dayOptions.length - 1).toDouble(),
                divisions: _dayOptions.length - 1,
                labels: RangeLabels(
                  _dayOptions[_selectedRange.start.round()],
                  _dayOptions[_selectedRange.end.round()],
                ),
                onChanged: (values) {
                  setState(() {
                    // snap to discrete steps
                    final start = values.start.roundToDouble();
                    final end = values.end.roundToDouble();
                    _selectedRange = RangeValues(start, end);
                  });
                  // Actions on range change can be added here
                },
              ),
            ),
          ),
        ),
      ),
    );

    // GPS button positioning: default bottom-right; in fullWidthMode place it top-right of slider
    final gpsWidget = Positioned(
      right: fullWidthMode ? right : CenterOnUserButton.padding,
      bottom: fullWidthMode
          ? bottomPadding + fabDiameter + 28.0
          : CenterOnUserButton.padding,
      child: CenterOnUserButton(
        onPressed: () =>
            ExceptionMessage.showInfo(context, "Center on user pressed!"),
      ),
    );

    final sliderPositioned = Positioned(
      left: left,
      right: right,
      bottom: bottomPadding,
      child: sliderWidget,
    );

    return Stack(children: [sliderPositioned, gpsWidget]);
  }
}

import 'package:casttime/app/config/app_config.dart';
import 'package:flutter/material.dart';

class DateRangeLabel extends StatelessWidget {
  final List<String> timeLabels;
  final RangeValues dragValues;

  DateRangeLabel({required this.timeLabels, required this.dragValues});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      child: SizedBox(
        height: 24,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              children: [
                Text(timeLabels[dragValues.start.round()]),
                const Spacer(),
                Text(timeLabels[dragValues.end.round()]),
              ],
            ),
            Text(
              AppConfig.appName,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:flutter/material.dart';

List<String> getDayOptionLabels(BuildContext context) {
  final l10n = context.l10n;
  return [
    l10n.today,
    l10n.tomorrow,
    l10n.dayAfterTomorrow,
    l10n.nextWeek,
    l10n.nextMonth,
  ];
}

List<String> dayOptionLabels(BuildContext context) {
  final l10n = context.l10n;
  return [
    l10n.today,
    l10n.tomorrow,
    l10n.dayAfterTomorrow,
    l10n.nextWeek,
    l10n.nextMonth,
  ];
}

DateTime dateFromDayOptionIndex(int index) {
  final now = DateTime.now();
  return switch (index) {
    0 => DateTime(now.year, now.month, now.day), // heute 00:00
    1 => now.add(const Duration(days: 1)),
    2 => now.add(const Duration(days: 2)),
    3 => now.add(const Duration(days: 7)),
    4 => DateTime(now.year, now.month + 1, now.day),
    _ => now,
  };
}

// Rückrichtung: welchem Options-Index kommt ein gegebenes Datum am nächsten?
// Nötig, um den Slider korrekt zu positionieren, wenn startDate/endDate
// von außen kommen (z. B. initial state, deep link, o. ä.).
int dayOptionIndexFromDate(DateTime date, int optionCount) {
  DateTime bestOption = dateFromDayOptionIndex(0);
  int bestIndex = 0;
  Duration bestDiff = (date.difference(bestOption)).abs();

  for (var i = 1; i < optionCount; i++) {
    final option = dateFromDayOptionIndex(i);
    final diff = (date.difference(option)).abs();
    if (diff < bestDiff) {
      bestDiff = diff;
      bestIndex = i;
      bestOption = option;
    }
  }
  return bestIndex;
}

// map_day_options.dart – reine UI-Helper, kein Bloc-Bezug

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

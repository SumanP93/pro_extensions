String readingTimeFromMinutes(double minutes) {
  if (minutes < 1) return "< 1 min"; // Less than a minute
  if (minutes < 60) {
    return "${minutes.toStringAsFixed(0)} min"; // Less than an hour
  } else if (minutes < 60 * 24) {
    final hours = minutes / 60;
    final min = minutes % 60;
    return "${hours.toStringAsFixed(0)} hr ${min.toStringAsFixed(0)} min"; // Less than a day
  } else if (minutes < 60 * 24 * 30) {
    final days = minutes / (60 * 24);
    final hours = (minutes % (60 * 24)) / 60;
    return "${days.toStringAsFixed(0)} day ${hours.toStringAsFixed(0)} hr"; // Less than a month
  } else if (minutes < 60 * 24 * 365) {
    final months = minutes / (60 * 24 * 30);
    final days = (minutes % (60 * 24 * 30)) / (60 * 24);
    return "${months.toStringAsFixed(0)} month ${days.toStringAsFixed(0)} day"; // Less than a year
  } else {
    final years = minutes / (60 * 24 * 365);
    final months = (minutes % (60 * 24 * 365)) / (60 * 24 * 30);
    return "${years.toStringAsFixed(0)} year ${months.toStringAsFixed(0)} month"; // More than a year
  }
}

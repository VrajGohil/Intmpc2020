String twoDigits(int n) {
  if (n >= 10) return '$n';
  return '0$n';
}

String formatBySeconds(Duration duration) =>
    twoDigits(duration.inSeconds.remainder(60));

String formatByMinutes(Duration duration) {
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  return '$twoDigitMinutes:${formatBySeconds(duration)}';
}

String formatByHours(Duration duration) {
  String twoDigitHours = twoDigits(duration.inHours.remainder(24));
  return '$twoDigitHours:${formatByMinutes(duration)}';
}

String formatByDays(Duration duration){
  return 'Starts in\n${twoDigits(duration.inDays)}:${formatByHours(duration)}';
}
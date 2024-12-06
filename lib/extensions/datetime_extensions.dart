/// Extension on DateTime to show formatted date to the user
extension DateTimeFormatting on DateTime {
  /// Method to format date and time to the user's preferred format
  String toFormattedString() {
    final hour = this.hour.toString().padLeft(2, '0');
    final minute = this.minute.toString().padLeft(2, '0');
    final time = '$hour:$minute';

    final day = this.day;
    final month = this.month;
    final year = this.year;

    final monthName = _getMonthName(month);

    return '$time, $day $monthName $year';
  }

  /// Method to get month shortened name from passed month
  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }
}

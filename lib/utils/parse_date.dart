import 'package:intl/intl.dart';

DateTime parseDateString(String dateString) {
  // Split the date string and remove the timezone information
  String trimmedDateString = dateString.split(' GMT')[0];

  // Define the date format for parsing
  final DateFormat format = DateFormat("EEE MMM d yyyy HH:mm:ss");

  return format.parse(trimmedDateString);
}

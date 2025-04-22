import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatter {
  static final String MMM_dd = 'MMM dd';
  static final String MMM_dd_hh_mm_a = 'MMM dd hh:mm a';
  static final String hh_mm_a = 'hh:mm a';

  static String formatDateStringToDifferentFormat({
    required String initialDateString,
    required String dateFormat,
  }) {
    var date =
        DateFormatter.formatDateStringToDate(dateString: initialDateString);
    var dateString = DateFormatter.formatDateToStringDate(
        dateTime: date, dateFormat: dateFormat);
    return dateString;
  }

  static DateTime? formatDateStringToDate({
    required String dateString,
  }) {
    try {
      return DateTime.parse(dateString);
    } catch (exception) {
      debugPrint(exception.toString());
    }
    return null;
  }

  static String formatDateToStringDate({
    required DateTime? dateTime,
    required String dateFormat,
  }) {
    if (dateTime == null) return DateFormat(dateFormat).format(DateTime.now());
    return DateFormat(dateFormat).format(dateTime);
  }

  static String getShortMonth(DateTime date) {
    return DateFormat('MMM').format(date);
  }

  static String formatDateFromInt(int initialDateString, String dateFormat) {
    try {
      final now = DateTime.fromMillisecondsSinceEpoch(initialDateString);
      final formatter = DateFormat(dateFormat);
      final formatted = formatter.format(now);

      return formatted;
    } catch (exception) {
      print(exception);
    }
    return '';
  }
}

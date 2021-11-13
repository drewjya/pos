import 'package:intl/intl.dart';

String toNormalDate(DateTime date) {
  String newDate = (DateFormat('EEEE, d MMM, yyyy').format(date)) +
      " " +
      (DateFormat('h:mm:s a').format(date));
  return newDate;
}

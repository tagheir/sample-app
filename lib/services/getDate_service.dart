import 'package:intl/intl.dart';

String getDateTime({String date}) {
    var parsedDate = DateTime.parse(date);
    parsedDate = parsedDate.add(parsedDate.timeZoneOffset);
    var dateCreated = DateFormat('dd-MM-yyyy   hh:mm a').format(parsedDate);
    return dateCreated;
  }
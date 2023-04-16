import 'dart:convert';

import 'package:easy_timezone/easy_timezone.dart';
import 'package:intl/intl.dart';

void main() {
  // print(EasyTimeZone.allTimeZoneAndOffset());
  EasyTimeZone.setFromTimeZone('asia/shanghai');
  final now = DateTime.now();
  print(jsonEncode({
    'default': {
      'now': now.toString(),
      'utc': now.toUtc().toString(),
      'TimeZone': now.timeZoneName,
      'TimeZoneOffset': now.timeZoneOffset.toString(),
      'format': DateFormat('yyyy-MM-dd HH:mm:ss').format(now),
    },
    'EZTimeZone': {
      'now': now.toTimeZone().toString(),
      '.utc.toTimeZone': now.toUtc().toTimeZone().toString(),
      'EZTimeZoneName': now.toTimeZone().ezTimeZoneName,
      'EZTimeZoneOffset': now.toTimeZone().ezTimeZoneOffset.toString(),
      'format': DateFormat('yyyy-MM-dd HH:mm:ss').format(now.toTimeZone()),
    },
  }));
}

# Easy TimeZone for Dart

## Features

The Easy TimeZone package is a DateTime extension.

It's very easy to use, just like `DateTime.now().toTimeZone()`

## Getting started

```dart
import 'package:easy_timezone/easy_timezone.dart';

EasyTimeZone.setFromTimeZone('asia/shanghai'); // same as "Asia/Shanghai"
/// Is Asia/Shanghai or Asia/ShangHai?
/// You no longer need to know when to use uppercase or lowercase.
/// Yes, it's case-insensitive! 🎉🎉

```

## Usage

```dart
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

```
Output: 
```json
{
  "default": {
    "now": "2023-04-16 05:55:06.260235",
    "utc": "2023-04-16 13:55:06.260235Z",
    "TimeZone": "Pacific Standard Time",
    "TimeZoneOffset": "-8:00:00.000000",
    "format": "2023-04-16 05:55:06"
  },
  "EZTimeZone": {
    "now": "2023-04-16 21:55:06.260235",
    ".utc.toTimeZone": "2023-04-16 21:55:06.260235",
    "EZTimeZoneName": "Asia/Shanghai",
    "EZTimeZoneOffset": "8:00:00.000000",
    "format": "2023-04-16 21:55:06"
  }
}
```

## Additional information
Show the list of the timezone and hours offset.
```dart
print(EasyTimeZone.allTimeZoneAndOffset());
```

## Fork and update timezone list by yourself:
Goto the [build.dart](./build.dart), and add your timezone to the `fixed`
Then run the command in the cli: `dart build.dart`

## Timezone list source:
https://github.com/dmfilipenko/timezones.json/blob/master/timezones.json
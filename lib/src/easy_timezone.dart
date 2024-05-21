import 'data.dart';

extension EasyTimeZone on DateTime {
  static late String _globalTimeZone = DateTime.now().timeZoneName;
  static Duration _globalOffset = Duration.zero;

  static void setFromDuration(Duration d) {
    _globalOffset = d;
    _globalTimeZone = 'Customize';
  }

  static void setFromTimeZone(String utcTimezone) {
    utcTimezone = utcTimezone.toLowerCase();
    final found = data.cast<Map?>().firstWhere((timezone) {
      final list = timezone!['utc'] as List;
      final index =
          list.map((e) => e.toLowerCase()).toList().indexOf(utcTimezone);
      if (index > -1) {
        _globalTimeZone = list[index];
        return true;
      }
      return false;
    }, orElse: () => null);
    if (found == null) throw Exception('Not Found: $utcTimezone');
    final num hours = found['offset'];
    final minutes = (hours - hours.truncate()) * 60;
    _globalOffset = Duration(hours: hours.toInt(), minutes: minutes.toInt());
    // print('_offset:$_offset');
  }

  static Map<String, num> allTimeZoneAndOffset() {
    final res = <String, num>{};
    for (var item in data) {
      for (var tz in item['utc'] as List) {
        res[tz] = item['offset'] as num;
      }
    }
    return res;
  }

  DateTime toTimeZone([Duration? offset]) {
    return copyWith(isUtc: false).add(offset ?? _globalOffset);
  }

  String get ezTimeZoneName => _globalTimeZone;

  Duration get ezTimeZoneOffset => _globalOffset;
}
